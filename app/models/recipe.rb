class Recipe < ApplicationRecord
    belongs_to :pet_category 
    belongs_to :user
    has_many :measurements, dependent: :destroy
    has_many :ingredients, through: :measurements, dependent: :destroy
    has_one_attached :recipe_img
    validates :title, presence: true
    validates :description, presence: true
    validates :instructions, presence: true
    validates_associated :pet_category,  message: "Is Already Created"
    accepts_nested_attributes_for :measurements, reject_if: proc {|measurement_params| measurement_params.values.any?(&:empty?) ||
   (measurement_params["ingredient_attributes"]["name"].blank? && !measurement_params["ingredient_id"])}

    scope :animal, -> (params){where("pet_category_id = ?", params)}
    
    
   
    def pet_category_attributes=(attributes)
        self.pet_category = PetCategory.find_or_create_by(attributes) if !attributes['name'].empty?
        self.pet_category
      end
   
    def self.food(params)
        joins(:ingredients).where("LOWER(name) LIKE :term", term: "%#{params}%")
    end

    def self.search(params)
        joins(:pet_category).where("LOWER(title) LIKE :term OR LOWER(description) LIKE :term OR LOWER(name) LIKE :term", term: "%#{params}%")
    end
end
