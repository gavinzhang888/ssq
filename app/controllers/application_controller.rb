class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale, :set_cookies

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path
  end

  private 

    def set_locale
      I18n.locale = current_user.try(:locale) || I18n.default_locale
    end

    def set_cookies
       cookies.signed[:user_id] ||= current_user.id if current_user
    end
end
