class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  respond_to :html
  
  URL = "https://www.eatsmart.jp/do/caloriecheck/list1?category=00&nutritionCode=0101&operatorKbn=01&searchKey="

  def autocomplete_food_menu
    term = params[:term]
    # APIで指定された名前から一覧を取得する

    suggestions = {}
    
    agent = Mechanize.new
    page = agent.get(URL + URI.encode(term))
    tr_list = page.search('div.result table tr')
    tr_list.each do |tr|
      alt_text = nil
      calorie = nil
      
      tr.search('td').each.with_index do |td, index|
        if index == 0
          alt_text = td.at('div.thumb40 a img').get_attribute(:alt)
        elsif index == 3
          calorie_text = td.at('div').inner_text
          calorie = calorie_text.to_i if calorie_text.present?
        end
      end
        
      if alt_text.present? # and calorie.present?
        suggestions[alt_text] = calorie
      end
    end
    render json: suggestions
  end

  def index
    @search_params = {}
    @search_params[:name] = params[:name]
    @search_params[:calorie_from] = params[:calorie_from]
    @search_params[:calorie_to] = params[:calorie_to]

    @foods = Food.all
    # @foods = @foods.where('name LIKE ?' => @search_params[:name]) if @search_params[:name].present?
    @foods = @foods.where('name LIKE ?', "%#{@search_params[:name]}%") if @search_params[:name].present?
    @foods = @foods.where('calorie >= ?', @search_params[:calorie_from].to_i) if @search_params[:calorie_from].present?
    @foods = @foods.where('calorie <= ?', @search_params[:calorie_to].to_i) if @search_params[:calorie_to].present?

    respond_with(@foods)
  end

  def show
    respond_with(@food)
  end

  def new
    @food = Food.new
    respond_with(@food)
  end

  def edit
  end

  def create
    @food = Food.new(food_params)
    @food.save
    respond_with(@food)
  end

  def update
    @food.update(food_params)
    respond_with(@food)
  end

  def destroy
    @food.destroy
    respond_with(@food)
  end

  private
    def set_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:name, :calorie)
    end
end
