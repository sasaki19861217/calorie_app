class AddAteAtToFoodHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :food_histories, :ate_at, :datetime
  end
end
