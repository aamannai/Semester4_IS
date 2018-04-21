class CampInstructor < ApplicationRecord
    #Relationship
    belongs_to :instructor
    belongs_to :camp
    
    #Required
    validates_presence_of :camp_id
    validates_presence_of :instructor_id 
   
    #Format
    validates :camp_id, numericality: {:only_integer => true} 
    validates :instructor_id, numericality: {:only_integer => true} 

    #Unique
    validates :camp_id, uniqueness: true
    validates :instructor_id, uniqueness: true    
    
end
