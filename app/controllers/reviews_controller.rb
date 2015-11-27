class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create

    @restaurant = Restaurant.find(params[:restaurant_id])

    if current_user.has_reviewed?(@restaurant)
      flash[:notice] = 'You can leave only one review per restaurant'
    else
      @review = Review.new(review_params)
      @review.restaurant_id = @restaurant.id
      @review.user_id = current_user.id
      @review.save
    end
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
