require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  should have_many(:camps)
  
  should validate_presence_of(:name)  
  should validate_presence_of(:min_rating)   
  should validate_presence_of(:max_rating)  
  
  should allow_value("Chess").for(:name)  
  should_not allow_value("019").for(:name) #FAILURE    
  should allow_value(800).for(:min_rating)
  should_not allow_value(-800).for(:min_rating)  #FAILURE
  should_not allow_value(4200).for(:max_rating) #FAILURE
  should allow_value(2800).for(:max_rating)
  should_not allow_value("String").for(:min_rating) #FAILURE
  
  
  context "Creating a curriculum context" do
    setup do
      create_curriculums
    end

    teardown do
      destroy_curriculums
    end  

  #Scopes to test
    should "have a scope to order alphabetically by name" do
      assert_equal ["English","Drama"], Curriculum.alphabetical.all.map(&:name), "#{Curriculum.class}"
    end  
  
    should "show active curriculum" do
      assert_equal ["Programming"], Curriculum.active.map(&:name)
    end
    
    should "inactive curriculum" do
      assert_equal ["Drama"], Curriculum.inactive.map(&:name)
    end
    
    should "scope rating" do
      assert_equal ["Drama","English"], Curriculum.for_rating(700).all.map(&:name)
    end
  end
end
