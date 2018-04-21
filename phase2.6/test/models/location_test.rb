require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  should have_many(:camps)
  
  should validate_presence_of(:name)  
  should validate_presence_of(:street_1)   
  should validate_presence_of(:zip)   
  should validate_presence_of(:max_capacity)  

  should allow_value("Belgium").for(:name)
  should_not allow_value("11111").for(:name)  #FAILURE
  should_not allow_value("S").for(:zip) #FAILURE
  should_not allow_value("2121").for(:zip)  #FAILURE
  should allow_value("CMU").for(:name)     
  should allow_value("City").for(:street_1)   
  should allow_value("39408").for(:zip) 
  should allow_value("Doha").for(:city)
  should allow_value(4).for(:max_capacity)
  
  context "Creating a location context" do
    setup do
      create_locations
    end

    teardown do
      destroy_locations
    end  
  
  #Scopes to test
    should "show active location" do
      assert_equal ["Doha"], Location.active.map(&:name)
    end
    
    should "inactive location" do
      assert_equal ["Pittsburgh"], Location.inactive.map(&:name)
    end
    
    should "have a scope to order alphabetically by location" do
      assert_equal ["Pittsburgh","Doha"], Location.alphabetical.all.map(&:name)
    end
  end  
end
