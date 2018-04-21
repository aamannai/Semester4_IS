class Instructor < ApplicationRecord
    #Relationship
    has_many :camp_instructors
    has_many :camps, through: :camp_instructors
    #Required
    validates_presence_of :first_name
    validates_presence_of :last_name 
    validates_presence_of :email
    
    #Format
    validates :first_name, format: { with: /\A[a-zA-Z]+\z/}
    validates :last_name, format: { with: /\A[a-zA-Z]+\z/}    
    validates :phone, format: { with: /\A[0-9]{1,10}+\z/}
    validates :email, format: { with: /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/}
    
    #Unique
    validates :email, uniqueness: true    
    
    #Scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order('last_name, first_name') }     
    scope :needs_bio, -> { where('bio IS NULL') }     
    
    #Methods
    def name
        last_name + " " + first_name
    end    
    
    def proper_name
        first_name + " " + last_name
    end    
    
    def self.for_camp(camp)
        CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
    end    
end
