class UsersController < ApplicationController
  def new; end

  def create
    new_user = User.new(user_params)
    if new_user.save
      flash[:success] = "Welcome, #{new_user.name}!"
      session[:user_id] = new_user.id
      redirect_to '/dashboard'
    else
      flash[:error] = new_user.errors.full_messages.uniq.to_sentence
      redirect_to '/register'
    end
  end

  def show; end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
