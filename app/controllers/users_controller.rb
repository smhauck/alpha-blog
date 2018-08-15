class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Alpha Blog #{user.username}"
      redirect_to_articles_path
    else
      render 'new'
    end
  end

  def index
  end

  def new
    @user = User.new
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
  end

end

