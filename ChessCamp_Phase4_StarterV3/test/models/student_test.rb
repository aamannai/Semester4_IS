require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  should belong_to(:family)
  should have_many(:registrations)
  should have_many(:camps).through(:registrations)

  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  #should validate_presence_of(:family_id)
  
  should allow_value("Dan").for(:first_name) 
  should_not allow_value("3").for(:first_name)   
  should allow_value("Zack").for(:last_name) 
  should_not allow_value("4").for(:last_name) 
  should allow_value(500).for(:rating)    
  should_not allow_value(-2).for(:rating)    
  should_not allow_value(4000).for(:rating)  
  
  context "Creating a student context" do
    setup do
      create_students
    end
    
    teardown do
      delete_students
    end



  #Scopes to test
    should "have a scope to order alphabetically by name" do
      assert_equal ["Skirpan, Max"], Student.alphabetical.all.map(&:first_name)
    end  
  
    should "show active students" do
      assert_equal ["Skirpan, Max"], Student.active.map(&:first_name)
    end
    
    should "inactive students" do
      assert_equal ["Skirpan, Max"], Student.inactive.map(&:first_name)
    end 
    
  #Methods  
    should "have a name method" do
      assert_equal "Skirpan, Zach", @zach.name
    end  
    
    should "have a proper name method" do
      assert_equal "Zach Skirpan", @zach.proper_name
    end   
    
    should "have an age method" do 
      assert_equal 10, @zach.age
    end   
    
  #OTHERS
    should "remove upcoming registrations for inactive student" do
      create_curriculums
      create_locations
      create_camps
      create_registrations
      assert_equal 3, @camp4.registrations.count
      assert_equal 1, @zach.registrations.count
      @zach.make_inactive
      @zach.reload
      deny @zach.active
      assert_equal 2, @camp4.registrations.count
      assert_equal 0, @zach.registrations.count
      delete_registrations
      delete_camps
      delete_locations
      delete_curriculums
    end
    
    should "allow a student with no past camps to be destroyed" do
      assert @sean.destroy
      create_curriculums
      create_locations
      create_camps
      create_registrations
      assert_equal 3, @camp4.registrations.count
      assert @zach.destroy
      @camp4.reload
      assert_equal 2, @camp4.registrations.count
      delete_registrations
      delete_camps
      delete_locations
      delete_curriculums
    end    
    
    should "deactive a student with past camps rather than destroy" do
      # check against student with one upcoming registration
      create_curriculums
      create_locations
      create_camps
      create_registrations
      # move camp 1 into the past
      @camp1.update_attribute(:start_date, 52.weeks.ago.to_date)
      @camp1.update_attribute(:end_date, 51.weeks.ago.to_date)
      assert_equal 3, @camp4.registrations.count
      assert_equal 2, @peter.registrations.count
      deny @peter.destroy
      @camp4.reload
      deny @peter.active
      assert_equal 2, @camp4.registrations.count
      assert_equal 1, @peter.registrations.count
      delete_registrations
      delete_camps
      delete_locations
      delete_curriculums
    end    
    
  end
end
