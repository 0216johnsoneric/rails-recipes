class Food < ApplicationRecord
    belongs_to :user
    belongs_to :food_category
    has_one_attached :food_img
    validates :name, presence: true
    validates_associated :food_category,  message: "Is Already Created"
    validate :not_a_duplicate

    def not_a_duplicate
        food = Food.find_by(name: name, food_category_id: food_category_id, user_id: user_id)
        if !!food && food != self
          errors.add(:food, 'has already been added.')
        end
      end

    def food_category_attributes=(attributes)
        self.food_category = FoodCategory.find_or_create_by(attributes) if !attributes['name'].empty?
        self.food_category
    end
    
      
    
end
