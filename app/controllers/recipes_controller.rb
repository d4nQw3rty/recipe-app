class RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipefoods = RecipeFood.includes(:food).where(recipe_id: params[:id])
  end

  def public
    @recipes = Recipe.includes(:recipe_foods, :user).where(public: true)
  end

  def toggle
    @recipe = Recipe.find(params[:id])
    @recipe.toggle! :public
    if @recipe.save
      flash[:success] = 'Post created successfully'
      redirect_to recipe_path
    else
      flash.now[:error] = 'Something went wrong'
      render :new, status: 422
    end
  end

  def create
    @recipe = Recipe.new(params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public))
    @recipe.user = current_user
    if @recipe.save
      flash[:success] = 'Post created successfully'
      redirect_to recipes_path
    else
      flash.now[:error] = 'Something went wrong'
      render :new, status: 422
    end
  end
end