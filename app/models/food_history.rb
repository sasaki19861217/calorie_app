class FoodHistory < ActiveRecord::Base
    belongs_to :user
    
    validates :user_id, presence: true
    validates :ate_at, presence: true
    validates :name, presence: true
    validates :calorie, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
