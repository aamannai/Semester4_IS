require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  should belong_to(:student)
  should belong_to(:camp)
  should have_one(:family).through(:student)

  should validate_numericality_of(:camp_id).only_integer.is_greater_than(0)
  should validate_numericality_of(:student_id).only_integer.is_greater_than(0) 
  
  # context
  context "Within context" do
    setup do 
      create_family_users
      create_families
      create_students
      create_curriculums
      create_locations
      create_camps
      create_registrations
    end
    
    teardown do
      delete_family_users
      delete_families
      delete_students
      delete_curriculums
      delete_locations
      delete_camps
      delete_registrations
    end 

    #SCOPES    
    should "have an alphabetical scope" do
      assert_equal ["Regan, Kelsey", "Regan, Peter", "Regan, Peter", "Skirpan, Max", "Skirpan, Zach"], Registration.alphabetical.all.map{|r| r.student.name}
    end

    should "have an for_camp scope" do
      assert_equal [@peter_tactics, @max_tactics], Registration.for_camp(@camp1).sort_by{|r| r.student.last_name}
    end    

    #OTHERS    
    should "student is active in the system" do
      create_students
      test_registration = FactoryBot.build(:registration, student: @ellen, camp: @camp1)
      deny test_registration.valid?
      delete_students
    end
    
    should "identify different types of credit card by their pattern" do
      # lengths are all correct for these tests, but prefixes are not
      assert @max_tactics.valid?
      numbers = {4123456789012=>"VISA", 4123456789012345=>"VISA", 5123456789012345=>"MC", 5412345678901234=>"MC", 6512345678901234=>"DISC", 6011123456789012=>"DISC", 30012345678901=>"DCCB", 30312345678901=>"DCCB", 341234567890123=>"AMEX", 371234567890123=>"AMEX",7123456789012=>"N/A",30612345678901=>"N/A",351234567890123=>"N/A",5612345678901234=>"N/A",6612345678901234=>"N/A"}
      numbers.each do |num, name|
        @max_tactics.credit_card_number = num
        assert_equal name, @max_tactics.credit_card_type, "#{@max_tactics.credit_card_type} :: #{@max_tactics.credit_card_number}"
      end
    end
    
    should "payment" do
      @max_tactics.payment = nil
      assert @max_tactics.save
      @max_tactics.credit_card_number = "4123456789012"
      @max_tactics.expiration_month = Date.current.month + 1
      @max_tactics.expiration_year = Date.current.year
      assert @max_tactics.valid?
      @max_tactics.pay
      assert_equal "camp: #{@max_tactics.camp_id}; student: #{@max_tactics.student_id}; amount_paid: #{@max_tactics.camp.cost}; card: #{@max_tactics.credit_card_type} ****#{@max_tactics.credit_card_number[-4..-1]}", Base64.decode64(@max_tactics.payment)
      @max_tactics.reload
      assert_not_nil @max_tactics.payment
      deny @max_tactics.pay
    end
  
    should "detect valid and invalid expiration dates" do
      assert @max_tactics.valid?
      @max_tactics.credit_card_number = "4123456789012"
      @max_tactics.expiration_month = Date.current.month
      @max_tactics.expiration_year = 1.year.ago.year
      deny @max_tactics.valid?
      @max_tactics.expiration_year = Date.current.year
      assert @max_tactics.valid?
      @max_tactics.expiration_month = Date.current.month - 1
      deny @max_tactics.valid?
      @max_tactics.expiration_month = Date.current.month + 1
      assert @max_tactics.valid?
    end  

    should "check short credit card numbers" do
      @max_tactics.expiration_month = Date.current.month + 1
      @max_tactics.expiration_year = Date.current.year
      short_numbers = %w[23515325 4444444]
      short_numbers.each do |num|
        @max_tactics.credit_card_number = num
        deny @max_tactics.valid?, "#{@max_tactics.credit_card_number}"
      end
    end
    
    should "verify that the student has a rating appropriate for the camp" do
      sean_endgames = FactoryBot.build(:registration, student: @sean, camp: @camp4)
      assert sean_endgames.valid?
      max_endgames = FactoryBot.build(:registration, student: @max, camp: @camp4)
      deny max_endgames.valid?
    end

    should "verify that student is not registered for another camp at the same time" do
      camp5 = FactoryBot.create(:camp, curriculum: @endgames, location: @north) 
      test_registration = FactoryBot.build(:registration, student: @peter, camp: camp5)
      deny test_registration.valid?
      camp5.delete
    end    
    
  end
end
