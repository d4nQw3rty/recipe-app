class RecipesController < ApplicationController
  def index
    @food = Food.where(user_id: current_user.id)
  end

  def create
    @food = Food.new(params.require(:food).permit(:name, :measurement_unit, :price, :quantity))
    @food.user = current_user
    if @pfood.save
      flash[:success] = 'Post created successfully'
      redirect_to foods_path
    else
      flash.now[:error] = 'Something went wrong'
      render :new, status: 422
    end
  end
end