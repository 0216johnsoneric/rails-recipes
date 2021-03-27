class RecipesController < ApplicationController
    before_action :get_current_user, only: [:new]
    before_action :set_recipe, only: [:show, :edit, :update, :destroy]
    
    
    def index
        if params[:user_id]
            @recipes = User.find(params[:user_id]).recipes
        else
            @recipes = Recipe.all.order(:title)
        end
          
            @recipes = @recipes.search(params[:q].downcase) if params[:q]
            @recipes = @recipes.animal(params[:recipe][:pet_category_id]) if params[:recipe] && params[:recipe][:pet_category_id] 
            @recipes = @recipes.food(params[:ingredient].downcase) if params[:ingredient]
            
    end

    def show
        
    end

    def new
        if params[:pet_category_id] && !PetCategory.exists?(params[:pet_category_id])
            redirect_to root_path
            
        else
          @recipe = Recipe.new(pet_category_id: params[:pet_category_id])
          4.times do 
            m = @recipe.measurements.build
            m.build_ingredient
            end
        end
    end 

    def create
        @recipe = current_user.recipes.new(recipe_params)
            if @recipe.save
            redirect_to recipe_path(@recipe)
            else 
            4.times do 
                m = @recipe.measurements.build
                m.build_ingredient
            end
            render :new
        end
    end

    def edit
        @recipe.recipe_img.attach(params[:recipe_img]) 
    end

    def update
        if @recipe.update_attributes(recipe_params)
           
            redirect_to recipe_path(@recipe)
            else
            render :edit
            end
    end

    def destroy
        @recipe.destroy
        redirect_to recipes_path
    end

    private
    def recipe_params
        params.require(:recipe).permit(:title, :description, :instructions, :pet_category_id, :user_id, :recipe_img, :recipe_img_id, ingredient_ids: [], pet_category_attributes:[:name], measurements_attributes:[:unit, :quantity, :id, :_destroy, ingredient_attributes:[:name]])
    end

    def set_recipe
        @recipe = Recipe.find(params[:id])
    end

    def get_current_user
        @user = User.find(session[:user_id])
      end
end
