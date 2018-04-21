class Location < ApplicationRecord
    #Relationships
    has_many :camps
    
    #Required
    validates_presence_of :name
    validates_presence_of :street_1 
    validates_presence_of :zip
    validates_presence_of :max_capacity
    
    #Format
    validates :name, format: { with: /\A[a-zA-Z]+\z/}
    validates :street_1, format: { with: /\A[a-zA-Z0-9_. -]+\z/}
    validates :street_2, format: { with: /\A[a-zA-Z0-9_. -]+\z/}
    validates :city, format: { with: /\A[a-zA-Z]+\z/}
    validates :state, format: { with: /\A[a-zA-Z]+\z/}
    validates :zip, format: { with: /\A\d{5}(-\d{4})?+\z/}     
    validates :max_capacity, numericality: {:only_integer => true}  
    
    #Unique
    validates :name, uniqueness: {case_sensitive: false}
    
    #Scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order('name') }    
    
end
