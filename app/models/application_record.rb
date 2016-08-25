class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.searching(account, params, *includes)
    collects = all
    collects = collects.includes(*includes) if includes.present?
    collects = collects.search(params[:q])
    collects = collects.result(:distinct => true)
    collects.set_statistics
    collects = collects.paginate(:page => params[:page], :per_page => params[:per_page])
    collects.try(:order,"#{self.table_name}.id desc")
  end
end

module ActiveRecord
  class Relation
    def statistics_results
      paginate_date = {}
      attrs = self.first.class::StatisticsColumns rescue []
      return unless attrs.present?
      attrs.each do |attr|
        paginate_date["paginate_#{attr}"] = self.all.inject(0) { |sum, object| sum + (object.send(attr) || 0)}
      end
      paginate_date.merge!(@statistics_data || {})
    end

    def set_statistics
      @statistics_data ||= {}
      attrs = self.first.class::StatisticsColumns rescue []
      return unless attrs.present?
      fileds = attrs.collect{|attr_name| "sum(#{attr_name}) as #{attr_name}"}.join(",")
      result = self.select("*, #{fileds}").first
      attrs.each do |attr_name|
        @statistics_data["all_#{attr_name}"] = result.send(attr_name)
      end
    end

    # def statistics_results
    #   paginate_date = {}
    #   attrs = self.first.class::StatisticsColumns rescue []
    #   attrs.each do |attr|
    #     paginate_date["paginate_#{attr}"] = self.all.inject(0) { |sum, object| sum + (object.send(attr) || 0)}
    #   end
    #   paginate_date.merge!(@statistics_data || {})
    # end

    # def set_statistics
    #   @statistics_data ||= {}
    #   attrs = self.first.class::StatisticsColumns rescue []
    #   attrs.each do |attr|
    #     @statistics_data["all_#{attr}"] = self.all.inject(0) { |sum, object| sum + (object.send(attr) || 0)}
    #   end
    # end
  end
end
