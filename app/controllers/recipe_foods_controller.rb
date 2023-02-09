class RecipeFoodsController < ApplicationController
  load_and_authorize_resource except: :create
  def new
    @recipefood = RecipeFood.new
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @recipefood = RecipeFood.new(params.permit(:quantity, :food_id, :recipe_id))
    if @recipefood.save
      redirect_to recipe_path(params[:recipe_id]), notice: 'Food was successfully created.'
    else
      redirect_to recipe_path(params[:recipe_id]), notice: 'Food was not created.'
    end
  end

  def update
    @recipefood = RecipeFood.find(params[:id])
    @recipefood.update
  end

  def put
    
  end

  def destroy
    @recipefood = RecipeFood.find(params[:id])
    @recipefood.destroy
    redirect_to recipe_path(params[:recipe_id]), status: :see_other
  end
end
