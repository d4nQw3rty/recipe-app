class RecipeFoodsController < ApplicationController
  def new
    @recipefood = RecipeFood.new
    @foods = Food.where(user_id: current_user.id)
  end

  def shopping_list
    @recipefoods = RecipeFood.includes(:food).where(recipe_id: params[:id])
    @recipe = Recipe.find(params[:id])
    @recipefoods.each do |recipefood|
      @food = Food.find(recipefood.food_id)
      @food.quantity = @food.quantity - recipefood.quantity
      @food.save
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
end
