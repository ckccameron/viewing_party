class UsersController < ApplicationController
  def new

  end

  def create
    new_user = User.create(user_params)
    flash[:success] = "Welcome, #{new_user.name}!"
    session[:user_id] = new_user.id
    redirect_to "/dashboard"
  end

  def show
  end

  private

  def user_params
    params.permit(:name, :email, :passsword, :password_confirmation)
  end
end
