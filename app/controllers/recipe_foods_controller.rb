class RecipeFoodsController < ApplicationController
  def new
    @recipefood = RecipeFood.new
    @foods = Food.where(user_id: current_user.id)
  end

  def shopping_list
    @recipefoods = RecipeFood.includes(:food).where(recipe_id: params[:id])
    @recipe = Recipe.find(params[:id])
    @total = 0
    @items_to_buy = 0
    @recipefoods.each do |recipefood|
      if (recipefood.quantity - recipefood.food.quantity).positive?
        @total += (recipefood.quantity - recipefood.food.quantity) * recipefood.food.price
        @items_to_buy += 1
      end
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
