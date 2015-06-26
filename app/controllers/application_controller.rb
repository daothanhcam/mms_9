class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  load_and_authorize_resource except: [:home, :help, :about],
                              unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |expection|
    redirect_to root_url, alert: expection.message
  end

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:home, :help, :about]

  include SessionsHelper

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
