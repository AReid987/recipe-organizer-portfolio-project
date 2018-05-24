class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    #byebug
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_path(@user), notice: "Sign Up Success" }
      else
        format.html { render :new }
      end
    end
  end

  def user_params
        params.require(:user).permit(:name, :email, :password)
      end

end
