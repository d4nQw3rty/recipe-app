class UsersController < ApplicationController
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      redirect_to users_path, notice: 'User was not created.'
    end
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
