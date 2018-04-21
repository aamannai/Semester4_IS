class Student < ApplicationRecord

  # callbacks
  before_save do
      self.rating ||= 0
  end
  
  before_destroy do 
   check_if_ever_registered_for_past_camp
   if errors.present?
     throw(:abort)
   else
     remove_upcoming_registrations
   end
  end  
  
  before_update :remove_upcoming_registrations_if_inactive

  # relationships
  belongs_to :family, optional: true
  has_many :registrations
  has_many :camps, through: :registrations

  # validations
  #validates_presence_of :first_name, :last_name, :family_id
  validates_presence_of :first_name, :last_name
  validates :first_name, format: { with: /\A[a-zA-Z]+\z/}
  validates :last_name, format: { with: /\A[a-zA-Z]+\z/}  
  validates :rating, numericality: { only_integer: true, greater_than: -1, less_than: 3001, allow_blank: true}  
  #validates :family_id, numericality: { only_integer: true }  
  validates_date :date_of_birth, :before => lambda { Date.today } 

  # scopes
  scope :alphabetical, -> {order('last_name, first_name')}
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :below_rating, ->(ceiling) {where('rating < ?', ceiling)}
  scope :at_or_above_rating, ->(floor) {where('rating >= ?', floor)}
  
  # methods
  def name
      last_name + ", " + first_name
  end    

  def proper_name
      first_name + " " + last_name
  end      

  def age
      today = Date.today
      d = Date.new(today.year, date_of_birth.month, date_of_birth.day)
      currentage = d.year - date_of_birth.year - (d > today ? 1 : 0)
      currentage
  end
  
  def make_inactive
    self.active = false
    self.save
  end      
    
    
  private
  # def student_inactive
  #   remove_upcoming_registrations
  #   self.make_inactive    
  # end

  def remove_upcoming_registrations_if_inactive
    remove_upcoming_registrations if !self.active 
  end

  def remove_upcoming_registrations
    return true if self.registrations.empty?
    upcoming_registrations = self.registrations.select{|r| r.camp.start_date >= Date.current}
    upcoming_registrations.each{ |ur| ur.destroy }
  end
  
  def check_if_ever_registered_for_past_camp
    return if self.registrations.empty?
    if registered_for_past_camps?
      errors.add(:base, "Student now made inactive.")
    end
  end

  def registered_for_past_camps?
    !self.registrations.select{|r| r.camp.start_date < Date.current}.empty?
  end

  
end
