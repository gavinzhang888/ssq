class BaseSerializer < ActiveModel::Serializer
  include ActionView::Helpers
  attributes :created_at, :updated_at, :creator

  def created_at
  	object.created_at.strftime "%Y-%m-%d" rescue nil
  end

  def updated_at
  	object.updated_at.strftime "%Y-%m-%d" rescue nil
  end

  def creator
    object.creator.username rescue nil
  end
end
