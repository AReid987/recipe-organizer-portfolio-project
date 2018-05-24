class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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

  def show
    byebug
    @message = params[:message] if params[:message]
    @message ||= false
  end

  private

  def set_user
   @user = User.find(params[:id])
 end

  def user_params
        params.require(:user).permit(:name, :email, :password)
      end

end
