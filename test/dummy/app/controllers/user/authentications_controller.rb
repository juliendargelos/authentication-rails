class User::AuthenticationsController < ApplicationController
  authenticates! :user, only: :destroy
  unauthenticates! :user, except: :destroy

  def new
    @authentication = User::Authentication.new
  end

  def create
    @authentication = User::Authentication.new authentication_params

    if @authentication.save
      flash[:notice] = 'You have been logged in'
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    User::Authentication.current.destroy
    flash[:notice] = 'You have been logged out'
    redirect_to root_path
  end

  protected

  def authentication_params
    params.require(:user_authentication).permit :email, :password
  end
end
