class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      redirect_to @food, notice: 'Food was not created.'
    end
  end

  def new
    @food = Food.new
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to foods_path, notice: 'Food was successfully destroyed.'
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
