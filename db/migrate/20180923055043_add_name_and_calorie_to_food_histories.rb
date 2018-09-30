class AddNameAndCalorieToFoodHistories < ActiveRecord::Migration[5.2]

  def up
    add_column :food_histories, :name, :string
    add_column :food_histories, :calorie, :integer
    
    FoodHistory.all.each do |food_history|
      food = Food.find_by(id: food_history.food_id)
      food_history.name = food.name
      food_history.calorie = food.calorie
      food_history.save
    end
    
    remove_column :food_histories, :food_id
  end
  
  def down
    add_column :food_histories, :food_id, :integer

    FoodHistory.includes(:food).each do |food_history|
      food = Food.where(:name, food_history.name).where(:calorie, food_history.calorie).first
      food_history.food_id = food.id
      food_history.save
    end
    
    remove_column :food_histories, :name, :string
    remove_column :food_histories, :calorie, :integer
  end
end
