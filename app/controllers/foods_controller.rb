class FoodsController < ApplicationController
    before_action :get_current_user, only: [:new, :destroy, :index]
    before_action :set_food, only: [:show, :edit, :update, :destroy]
    def index
        redirect_to user_path(@user)
    end

    def show 
    end

    def new
        if params[:food_category_id] && !FoodCategory.exists?(params[:food_category_id])
            redirect_to root_path,
            alert: "Food Category not found"
          else
          @food = Food.new(food_category_id: params[:food_category_id])
          end
    end 

    def create
        @food = current_user.foods.new(food_params)
        if @food.save
        redirect_to user_food_path(@food.user_id, @food)
        else 
        render :new
        end
    end

    def edit
        @food.food_img.attach(params[:food_img])
    end

    def update
        @food.update(food_params)
        redirect_to food_path(@food)
    end

    def destroy
        @food.destroy
        redirect_to user_path(@user)
    end
    
    private

    def food_params
        params.require(:food).permit(:name, :food_category_id, :user_id, :food_img, food_category_attributes:[:id, :name, :_destroy])
    end

    def set_food
        @food = Food.find(params[:id])
    end

    def get_current_user
        @user = current_user
      end
end
