class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}!"
    redirect_to "/dashboard"
  end

  def destroy
    session[:user_id] = nil
    flash[:error] = "You have logged out!"
    redirect_to "/"
  end
end
