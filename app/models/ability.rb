#encoding: UTF-8
class Ability
  include CanCan::Ability
  include ActionView::Helpers

  def initialize(user)
    if user.blank?
    else
      #管理员
      if user.id == 1
        can :manage, :all
      else
        can :manage, :all
      end
    end
  end
end
