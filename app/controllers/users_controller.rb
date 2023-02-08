class UsersController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    @users = User.all
    @current_user = current_user
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
