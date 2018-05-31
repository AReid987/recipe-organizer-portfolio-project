class SessionsController < ApplicationController

  def new
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      log_user_in
      redirect_to user_path(@user), notice: "Sign in success!"
    else

      redirect_to signin_path, notice: "Incorrect username or password"
    end
  end

  def create_facebook
    @user = User.from_omniauth(auth)
    log_user_in
    redirect_to user_path(@user), notice: "You are logged in with Facebook!"
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
