class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    @restaurant.user_id  = current_user.id
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :image)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
      @restaurant = Restaurant.find(params[:id])
      if @restaurant.user != current_user
        flash[:notice] = "You can't edit as you didnt create this restaurant"
        redirect_to '/restaurants'
      end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)

    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user != current_user
      flash[:notice] = "You can't delete as you didnt create this restaurant"
      redirect_to('/restaurants')
    else
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to('/restaurants')
    end
  end
end
