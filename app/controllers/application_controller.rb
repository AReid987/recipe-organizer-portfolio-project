class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_user
  before_action :require_logged_in, except: [:new, :create, :home, :create_facebook]

  def logged_in?
   !!current_user
  end

  private

  def require_logged_in
    redirect_to root_path, notice: "You must be logged in to do that" unless logged_in?

  end

  def log_user_in
    session[:user_id] = @user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
