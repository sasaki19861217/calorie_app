class User < ActiveRecord::Base
  extend Enumerize
  
  has_many :food_histories, dependent: :destroy
  has_many :foods, through: :food_histories
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :name,  presence: true, length: { maximum: 50 }

  enumerize :gender, in: {unknown: 0, male: 1, female: 2}, scope: true
    
  scope :options, -> { self.select(:name, :id).map { |user| [user.name, user.id] } }
end
