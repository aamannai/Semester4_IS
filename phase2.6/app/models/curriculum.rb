class Curriculum < ApplicationRecord
    #Relationships
    has_many :camps
    
    #Required
    validates_presence_of :name
    validates_presence_of :min_rating   
    validates_presence_of :max_rating
    
    #Format
    validates :name, format: { with: /\A[a-zA-Z]+\z/}
    validates :min_rating, numericality: {:only_integer => true}
    validates :max_rating, numericality: {:only_integer => true}  
    #validates :description, format: { with: /\A[a-zA-Z]+\z/}
    
    #Range
    validates :min_rating, numericality: { greater_than: -1 }
    validates :max_rating, numericality: { less_than: 3001 }
    
    #Unique
    validates :name, uniqueness: {case_sensitive: false}
    
    #Scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order('name') }
    scope :for_rating, ->(rating) { where('min_rating > ? and max_rating < ?',rating,rating) }
end
