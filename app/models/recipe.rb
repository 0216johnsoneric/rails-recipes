class Recipe < ApplicationRecord
    belongs_to :food_category 
    belongs_to :user
    has_many :measurements, dependent: :destroy
    has_many :ingredients, through: :measurements, dependent: :destroy
    has_one_attached :recipe_img
    validates :title, presence: true
    validates :description, presence: true
    validates :instructions, presence: true
    validates_associated :food_category,  message: "Is Already Created"
    accepts_nested_attributes_for :measurements, reject_if: proc {|measurement_params| measurement_params.values.any?(&:empty?) ||
   (measurement_params["ingredient_attributes"]["name"].blank? && !measurement_params["ingredient_id"])}

    scope :animal, -> (params){where("food_category_id = ?", params)}
    
    
   
    def food_category_attributes=(attributes)
        self.food_category = FoodCategory.find_or_create_by(attributes) if !attributes['name'].empty?
        self.food_category
      end
   
    def self.food(params)
        joins(:ingredients).where("LOWER(name) LIKE :term", term: "%#{params}%")
    end

    def self.search(params)
        joins(:food_category).where("LOWER(title) LIKE :term OR LOWER(description) LIKE :term OR LOWER(name) LIKE :term", term: "%#{params}%")
    end
end
