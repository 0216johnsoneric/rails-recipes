class FoodCategory < ApplicationRecord
    has_many :recipes
    has_many :users, through: :recipes
    has_many :foods
    validates :name, presence: true, uniqueness: true
    before_validation :capitalize_name

    private
    def capitalize_name
    name.capitalize!
    end

end
