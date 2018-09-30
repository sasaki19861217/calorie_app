class CreateFoods < ActiveRecord::Migration[4.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :calorie

      t.timestamps
    end
  end
end
