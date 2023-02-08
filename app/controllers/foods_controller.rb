class FoodsController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      redirect_to foods_path, notice: 'Food was not created.'
    end
  end

  def new
    @food = Food.new
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      redirect_to foods_path, notice: 'Food was successfully destroyed.'
    else
      redirect_to foods_path, notice: 'Food was not destroyed.'
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
