module HistoryBase
  extend ActiveSupport::Concern

  included do
    has_many :histories, as: :historyable
    after_create :generate_create_history
    after_update :generate_update_history
  end

  def generate_create_history
    class_name = self.class.name.constantize
    model_name = I18n.t("#{class_name.model_name.element}.formname")
    name = self.name rescue nil || self.username rescue nil || self.number rescue nil || self.content rescue nil
  	self.histories.create(detail: "创建了#{model_name} #{value_to_human(name)}", user_id: (User.current_user.id rescue 1), operation: "create")
  end

  def generate_update_history
    class_name = self.class.name.constantize
    model_name = I18n.t("#{class_name.model_name.element}.formname")

    unless self.try(:current_sign_in_at_changed?) #获取current user的方法与用户登陆时执行after update方法会有冲突，所以做个判断
      attributes_changes = self.changes    #获取更新的字段
      ["updated_at", "password", "encrypted_password"].each { |a| attributes_changes.delete(a) }
    	if attributes_changes != {}
    	  attr = ["修改了#{model_name}"]
    	  attributes_changes.each_with_index do |(key, value), index|
          association = {}
    	  	self.class.reflect_on_all_associations(:belongs_to).each do |x|
            association = association.merge({x.foreign_key.to_s => x.class_name}) #获取关联对象的model name
          end

          association_model_name = []
          if association["#{key}"]
            association_model = association["#{key}"].constantize
            value.each do |x|
              name = association_model.find(x).name rescue nil || association_model.find(x).username rescue nil || association_model.find(x).number rescue nil
              association_model_name << value_to_human(name)
            end
            attr.push I18n.t("#{class_name.model_name.element}.#{key}")+"从 #{association_model_name[0]} 修改为 #{association_model_name[1]}"
          else
      	  	attr.push I18n.t("#{class_name.model_name.element}.#{key}")+"从 #{value_to_human(value[0])} 修改为 #{value_to_human(value[1])}"
          end
    	  end
    	  details = attr.join("--- !ruby")
    	  self.histories.create(detail: details, user_id: (User.current_user.id rescue 1), operation: "update")
      end
    end
  end

  private
  def value_to_human(val)
    if val.class == TrueClass || val.class == FalseClass
      val === true ? val = "是" : val = "否"
    end
    val = val || "空"
    val = "<span class='blue'>#{val}</span>"
  end
end