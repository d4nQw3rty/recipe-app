class UsersController < ApplicationController
  def index
    @users = User.all
    @current_user = current_user
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @recipes = @user.recipes
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
