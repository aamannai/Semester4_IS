require 'test_helper'

class CampTest < ActiveSupport::TestCase
  should have_many(:camp_instructors)
  should have_many(:instructors).through(:camp_instructors)
  should belong_to(:location)
  should belong_to(:curriculum)  
  
  should validate_presence_of(:curriculum_id)  
  should validate_presence_of(:location_id)   
  should validate_presence_of(:start_date)   
  should validate_presence_of(:end_date)  
  
  should allow_value(1).for(:curriculum_id) 
  should allow_value(2).for(:location_id)
  should allow_value(1.50).for(:cost)
  should allow_value(Date.today).for(:start_date)  
  should allow_value(Date.today).for(:end_date)  
  should allow_value("am").for(:time_slot)   
  should_not allow_value("at").for(:time_slot)  #FAILURE
  should allow_value(10).for(:max_students)    
  
  context "Creating a camp test context" do
    setup do
      create_curriculums
      create_locations
      create_camps
    end

    teardown do
      destroy_curriculums
      destroy_locations
      destroy_camps
    end  
  
  #Scopes to test
    should "show active camps" do
      assert_equal ["1"], Camp.active.map(&:curriculum_id)
    end
    
    should "inactive camps" do
      assert_equal ["2"], Camp.inactive.map(&:curriculum_id)
    end
    
    should "have a scope to order alphabetically by curriculum name" do
      assert_equal ["Programming","Drama"], Camp.alphabetical.all.map{|c| c.curriculum.name}
    end
    
    should "have a scope to order camps in chronological order" do
      assert_equal ["Programming","Drama"], Camp.chronological.all.map{|c| c.name}
    end   
    
    should "have a scope to order by morning camps" do
      assert_equal ["Programming","Drama"], Camp.morning.all.map{|c| c.name}.sort
    end   
    
    should "have a scope to order by afternoon camps" do
      assert_equal ["Programming","Drama"], Camp.afternoon.all.map{|c| c.name}.sort
    end     
    
    should "have a scope to return upcoming camps" do
      assert_equal ["Programming","Drama"], Camp.upcoming.all.map{|c| c.name}
    end     
    
    should "have a scope to return past camps" do
      assert_equal ["Programming","Drama"], Camp.past.all.map{|c| c.name}.sort
    end     
    
    should "have a for_curriculum scope" do
      assert_equal ["Programming"], Camp.for_curriculum(@camp1).all.map(&:name)
    end     
    
  #Methods  
    should "have a name method" do
      assert_equal "Programming", @camp1.name
    end    
  end    
end
