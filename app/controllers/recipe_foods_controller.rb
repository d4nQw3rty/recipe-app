class RecipeFoodsController < ApplicationController
  load_and_authorize_resource except: :create
  def new
    @recipefood = RecipeFood.new
    @foods = Food.where(user_id: current_user.id)
  end

  def shopping_list
    @recipefoods = RecipeFood.includes(:food).where(recipe_id: params[:recipe_id])
    @recipe = Recipe.find(params[:recipe_id])
    @recipefoods.each do |recipefood|
      @food = Food.find(recipefood.food_id)
      @food.quantity = @food.quantity - recipefood.quantity
    end
  end

  def create
    @recipefood = RecipeFood.new(params.permit(:quantity, :food_id, :recipe_id))
    if @recipefood.save
      redirect_to recipe_path(params[:recipe_id]), notice: 'Food was successfully created.'
    else
      redirect_to recipe_path(params[:recipe_id]), notice: 'Food was not created.'
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipefood = RecipeFood.find(params[:id])
  end

  def update
    @recipefood = RecipeFood.find(params[:id])
    if @recipefood.update(params.permit(:quantity))
      redirect_to recipe_path(params[:recipe_id]), notice: 'Food was successfully updated.'
    else
      redirect_to recipe_path(params[:recipe_id]), notice: 'Food was not updated.'
    end
  end

  def destroy
    @recipefood = RecipeFood.find(params[:id])
    @recipefood.destroy
    redirect_to recipe_path(params[:recipe_id]), status: :see_other
  end
end
