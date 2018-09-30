class FoodHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food_history, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @search_params = {}
    @search_params[:user_id] = params[:user_id]
    @search_params[:ate_at_from_date] = params[:ate_at_from_date]
    @search_params[:ate_at_to_date] = params[:ate_at_to_date]
    
    @search_params[:name] = params[:name]
    @search_params[:calorie_from] = params[:calorie_from]
    @search_params[:calorie_to] = params[:calorie_to]
    
    @food_histories = FoodHistory.includes(:user)
    @food_histories = @food_histories.where(user_id: @search_params[:user_id].to_i) if @search_params[:user_id].present?
    @food_histories = @food_histories.where('ate_at >= ?', Time.zone.parse(@search_params[:ate_at_from_date])) if @search_params[:ate_at_from_date].present?
    if @search_params[:ate_at_to_date].present?
      ate_at_to = Time.zone.parse(@search_params[:ate_at_to_date])
      ate_at_to = ate_at_to.beginning_of_day.tomorrow
      @food_histories = @food_histories.where('ate_at < ?', ate_at_to)
    end
    
    @food_histories = @food_histories.where('name LIKE ?', "%#{@search_params[:name]}%") if @search_params[:name].present?
    @food_histories = @food_histories.where('calorie >= ?', @search_params[:calorie_from].to_i) if @search_params[:calorie_from].present?
    @food_histories = @food_histories.where('calorie <= ?', @search_params[:calorie_to].to_i) if @search_params[:calorie_to].present?

    respond_with(@food_histories)
  end

  def show
    respond_with(@food_history)
  end

  def new
    @food_history = FoodHistory.new
    @total_calories = total_calories
    respond_with(@food_history)
  end

  def edit
  end

  def create
    @food_history = FoodHistory.new(food_history_params)
    @food_history.user_id = current_user.id
    @food_history.ate_at = Time.now if @food_history.ate_at.blank?
    @food_history.save
    respond_with(@food_history)
  end

  def update
    @food_history.update(food_history_params)
    @food_history.user_id = current_user.id
    respond_with(@food_history)
  end

  def destroy
    @food_history.destroy
    respond_with(@food_history)
  end

  private
  
  def total_calories
    FoodHistory.where(user_id: current_user.id)
      .where('ate_at >= ?', Time.current.beginning_of_day)
      .where('ate_at < ?', (Time.current + 1.day).beginning_of_day)
      .sum(:calorie)
  end
  
  def set_food_history
    @food_history = FoodHistory.find(params[:id])
  end

  def food_history_params
    params.require(:food_history).permit(:ate_at, :name, :calorie, :user_id)
  end
end
