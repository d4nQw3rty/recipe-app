class RecipeFoodsController < ApplicationController
  load_and_authorize_resource except: :create
  def new
    @recipefood = RecipeFood.new
    @foods = Food.where(user_id: current_user.id)
  end

  def shopping_list
    @recipefoods = RecipeFood.includes(:food).where(recipe_id: params[:recipe_id])
    @recipe = Recipe.find(params[:recipe_id])
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
    @recipefood = RecipeFood.new(params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id))
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
