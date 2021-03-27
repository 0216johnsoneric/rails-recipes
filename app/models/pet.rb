class Pet < ApplicationRecord
    belongs_to :user
    belongs_to :pet_category
    has_one_attached :pet_img
    validates :name, presence: true
    validates_associated :pet_category,  message: "Is Already Created"
    validate :not_a_duplicate

    def not_a_duplicate
        pet = Pet.find_by(name: name, pet_category_id: pet_category_id, user_id: user_id)
        if !!pet && pet != self
          errors.add(:pet, 'has already been added.')
        end
      end

    def pet_category_attributes=(attributes)
        self.pet_category = PetCategory.find_or_create_by(attributes) if !attributes['name'].empty?
        self.pet_category
    end
    
      
    
end
