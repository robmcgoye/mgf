class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_locale
  helper_method :current_user, :logged_in?, :admin_user?
  after_action :track_action

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end 

  def logged_in?
    !!current_user
  end
  
  def admin_user?
    logged_in? && current_user.admin?
  end

  def require_admin_user
    if !logged_in?
      flash[:alert] = I18n.t(:must_be_logged_in)
      redirect_to login_path
    elsif !current_user.admin?
      flash[:alert] = I18n.t(:must_be_admin)
      redirect_to root_path      
    end
  end

  private 
  def track_action
    ahoy.track "Ran action", request.path_parameters
  end
  
  def set_locale
    # I18n.locale = params[:locale] if params[:locale].present?
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    # {locale: I18n.locale}
    {locale: I18n.locale}.merge options
  end

end
