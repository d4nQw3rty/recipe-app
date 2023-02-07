class UsersController < ApplicationController
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end  

  def user_params
    params.require(:user).permit(:name)
  end
end
