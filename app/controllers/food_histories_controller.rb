class FoodHistoriesController < ApplicationController
  before_action :set_food_history, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @food_histories = FoodHistory.all
    respond_with(@food_histories)
  end

  def show
    respond_with(@food_history)
  end

  def new
    @food_history = FoodHistory.new
    respond_with(@food_history)
  end

  def edit
  end

  def create
    @food_history = FoodHistory.new(food_history_params)
    @food_history.save
    respond_with(@food_history)
  end

  def update
    @food_history.update(food_history_params)
    respond_with(@food_history)
  end

  def destroy
    @food_history.destroy
    respond_with(@food_history)
  end

  private
    def set_food_history
      @food_history = FoodHistory.find(params[:id])
    end

    def food_history_params
      params.require(:food_history).permit(:title, :detail)
    end
end
