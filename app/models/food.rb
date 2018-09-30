class Food < ActiveRecord::Base
#    has_many :food_histories, dependent: :destroy
    has_many :users, through: :food_histories
    
    validates :name, presence: true, uniqueness: true
    validates :calorie, presence: true, numericality: { greater_than_or_equal_to: 0 }
    
    scope :options, -> { self.select(:name, :id).map { |food| [food.name, food.id] } }
end
