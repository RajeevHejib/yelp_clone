class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user

  def average_rating
    return "N/A" if reviews.none?
    # reviews.inject(0) {|memo, review| memo + review.rating} / reviews.count
    reviews.inject(0) {|sum, review| sum + review.rating } / reviews.count
    # reviews.average(:rating)
  end

  def build_review(review_params, user)
    review = reviews.create(review_params)
    review.user = user
    review
  end

end
