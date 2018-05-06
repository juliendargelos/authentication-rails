class ApplicationController < ActionController::Base
  authenticates(:user) { redirect_to new_user_authentication_path }
  unauthenticates(:user) { redirect_to root_path }

  def index

  end

  protected

  def current_user
    User::Authentication.current.user
  end
  helper_method :current_user
end
