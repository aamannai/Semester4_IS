require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  should belong_to(:user)
  should have_many(:students)
  should have_many(:registrations).through(:students)
  
  should validate_presence_of(:family_name)
  should validate_presence_of(:parent_first_name)  
  
  should allow_value("Mike").for(:family_name)  
  should_not allow_value("0129").for(:family_name)  
  should allow_value("Charles").for(:parent_first_name)  
  should_not allow_value("92").for(:parent_first_name)  
  #should allow_value("1").for(:user_id)  
  #should_not allow_value("Simon").for(:user_id)    
  
  context "Within context" do
    setup do 
      create_families
      create_family_users      
    end
    
    teardown do
      delete_families
      delete_family_users
    end
    
    #SCOPES TO TEST
    should "have a scope to order alphabetically by name" do
      assert_equal ["Dan","Brian"], Family.alphabetical.all.map(&:family_name)
    end 
    
    should "show active family" do
      assert_equal ["Yale"], Family.active.map(&:family_name)
    end
    
    should "inactive family" do
      assert_equal ["Mark"], Family.inactive.map(&:family_name)
    end    
    
    #OTHERS
    should "family should not be destroyed" do
      deny @regans.destroy
    end
    
    should "remove upcoming registrations when family is made inactive" do
      create_curriculums
      create_locations
      create_camps
      create_students
      create_registrations
      assert_equal 3, @regans.registrations.count
      @regans.make_inactive
      @regans.reload
      assert_equal 0, @regans.registrations.count
      delete_registrations
      delete_students
      delete_camps
      delete_locations
      delete_curriculums
    end    
    
    should "test out that a family is inactive" do
      assert_equal 1, Family.inactive.size
      assert_equal %w[Ellis], Family.inactive.all.map(&:family_name).sort
    end    
    
  end  
end
