require 'test_helper'

class CampInstructorTest < ActiveSupport::TestCase
  should belong_to(:instructor)
  should belong_to(:camp)
  
  should validate_presence_of(:camp_id)  
  should validate_presence_of(:instructor_id)   
  
  should allow_value("1").for(:camp_id) 
  should allow_value("2").for(:instructor_id)
end
