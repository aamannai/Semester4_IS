class Family < ApplicationRecord
  # callbacks
  before_destroy do 
    cannot_destroy_object()
  end
  before_update :family_inactive 

  # relationships
  belongs_to :user, optional: true
  has_many :students
  has_many :registrations, through: :students  

  # validations
  validates_presence_of :family_name, :parent_first_name

  validates :family_name, format: { with: /\A[a-zA-Z]+\z/}
  validates :parent_first_name, format: { with: /\A[a-zA-Z]+\z/}  
  #validates :user_id, numericality: { only_integer: true }    

  # delegates
  delegate :email, to: :user, allow_nil: true
  delegate :phone, to: :user, allow_nil: true
  delegate :username, to: :user, allow_nil: true  
  
  # scopes
  scope :alphabetical, -> {order('family_name, parent_first_name')}
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }  
  
  # methods
  
  # def make_active
  #   self.active = true
  #   self.save
  # end
  
  def make_inactive
    self.active = false
    self.save
  end    
  
  private
  def family_inactive
    if self.active == false
      self.registrations.select{|r| r.camp.start_date >= Date.current}.each{|r| r.destroy}
      self.students.each{|s| s.make_inactive}
    end
  end  
  
  def cannot_destroy_object
    errors[:base] << "cannot destroy family"
    throw(:abort)   
  end
  
  
end
