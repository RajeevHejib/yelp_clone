class Review < ActiveRecord::Base
  # validates :user_id, :uniqueness => { :scope => :restaurant_id}
  belongs_to :restaurant
  belongs_to :user
  validates :rating, inclusion: (1..5)
end
