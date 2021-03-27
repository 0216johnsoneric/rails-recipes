class User < ApplicationRecord
    has_many :recipes, :dependent => :destroy
    has_many :pet_catigories, through: :recipes
    has_many :pets, :dependent => :destroy
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :password, :presence => { :on => :create },
          :length   => { :minimum => 6, :allow_nil => true },
          :confirmation => true
    
    has_secure_password
   
    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |user|
          user.name = auth.info.first_name
          user.email = auth.info.email
          user.password = SecureRandom.hex
         
        end
      end
   
    
end
