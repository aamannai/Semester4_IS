class Camp < ApplicationRecord
    #Relationships
    has_many :camp_instructors
    has_many :instructors, through: :camp_instructors
    belongs_to :location
    belongs_to :curriculum
    
    #Required
    validates_presence_of :curriculum_id
    validates_presence_of :location_id
    validates_presence_of :start_date
    validates_presence_of :end_date
    
    #Format
    validates :curriculum_id, numericality: {:only_integer => true} 
    validates :location_id, numericality: {:only_integer => true} 
    validates :cost, numericality: {:only_float => true} 
    #validates :start_date, format: { with: /\d{2}\/\d{2}\/\d{4}/}
    #validates :end_date, format: { with: /\d{2}\/\d{2}\/\d{4}/}
    validates_date :start_date, on_or_after: lambda { Date.today }
    validates_date :end_date, on_or_after: lambda { Date.today }
    #validates :time_slot, format: { with: /\A[a-zA-Z]+\z/}   
    validates :time_slot, inclusion: { in: %w(am pm)}
    validates :max_students, numericality: {:only_integer => true}      
    
    #validates :name, uniqueness: true    
    
    #Scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { joins(:curriculum).order('name') }  
    scope :chronological, -> {order('start_date','end_date')}
    scope :morning, -> {where('time_slot=?','am')}
    scope :afternoon, -> {where('time_slot=?','pm')}
    scope :upcoming, -> {where('start_date>=?',Date.today)}
    scope :past, -> {where('start_date<?',Date.today)}
    scope :for_curriculum, -> (curriculum_id) {where('curriculum_id=?', curriculum_id)}
    
    #Methods
    def name
        self.curriculum.name
    end
end
