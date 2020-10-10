class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    session[:user_id]
  end

  private

  def require_login
    render(file: Rails.root.join('public/404.html'), status: :not_found, layout: false) unless logged_in?
  end
end
