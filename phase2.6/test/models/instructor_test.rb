require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  should have_many(:camp_instructors)
  should have_many(:camps).through(:camp_instructors)
  
  should validate_presence_of(:first_name)  
  should validate_presence_of(:last_name)   
  should validate_presence_of(:email)   
 
  should allow_value("Emily").for(:first_name)  
  should_not allow_value("2").for(:first_name)  #FAILURE
  should allow_value("Smith").for(:last_name)  
  should_not allow_value("2").for(:last_name)  #FAILURE  
  should allow_value("3412").for(:phone) 
  should_not allow_value("A").for(:phone) #FAILURE
  should_not allow_value("aamannai@yahoo").for(:email) #FAILURE
  should allow_value("aamannai@yahoo.com").for(:email)  
  
  context "Creating a instructor context" do
    setup do
      create_instructors
    end


  
  #Scopes to test
    should "show active instructors" do
      assert_equal ["David"], Instructor.active.map(&:first_name)
    end
    
    should "inactive instructors" do
      assert_equal ["Brian"], Instructor.inactive.map(&:first_name)
    end
    
    should "have a scope to order alphabetically by instructor's last then first name" do
      assert_equal ["Brian","David"], Instructor.alphabetical.all.map(&:first_name)
    end
    
    should "have a scope for requiring bio" do
      assert_equal ["Brian","David"], Instructor.needs_bio.all.map(&:first_name)
    end    
    
  #Methods  
    should "have a name method" do
      assert_equal "Richard, David", @david.name
    end  
    
    should "have a proper name method" do
      assert_equal "David Richard", @david.proper_name
    end        

    should "have a for_camp class method" do
      create_curriculums
      create_locations
      create_camps
      create_camp_instructors
      assert_equal ["Brian","David"], Instructor.for_camp(@camp1).map(&:first_name)
      destroy_curriculums
      destroy_locations
      destroy_camps
      destroy_camp_instructors      
    end 
    
  end   
end
