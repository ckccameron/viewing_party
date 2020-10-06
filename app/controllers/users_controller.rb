class UsersController < ApplicationController
  def new

  end

  def create
    User.create(user_params)
    redirect_to "/dashboard"
  end

  def show
  end

  private

  def user_params
    params.permit(:name, :email, :passsword, :password_confirmation)
  end
end
