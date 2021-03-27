class PetsController < ApplicationController
    before_action :get_current_user, only: [:new, :destroy, :index]
    before_action :set_pet, only: [:show, :edit, :update, :destroy]
    def index
        redirect_to user_path(@user)
    end

    def show 
    end

    def new
        if params[:pet_category_id] && !PetCategory.exists?(params[:pet_category_id])
            redirect_to root_path,
            alert: "Pet Category not found"
          else
          @pet = Pet.new(pet_category_id: params[:pet_category_id])
          end
    end 

    def create
        @pet = current_user.pets.new(pet_params)
        if @pet.save
        redirect_to user_pet_path(@pet.user_id, @pet)
        else 
        render :new
        end
    end

    def edit
        @pet.pet_img.attach(params[:pet_img])
    end

    def update
        @pet.update(pet_params)
        redirect_to pet_path(@pet)
    end

    def destroy
        @pet.destroy
        redirect_to user_path(@user)
    end
    
    private

    def pet_params
        params.require(:pet).permit(:name, :pet_category_id, :user_id, :pet_img, pet_category_attributes:[:id, :name, :_destroy])
    end

    def set_pet
        @pet = Pet.find(params[:id])
    end

    def get_current_user
        @user = current_user
      end
end
