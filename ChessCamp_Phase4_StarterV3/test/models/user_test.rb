require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:username)
  should validate_presence_of(:password_digest)
  should validate_presence_of(:role)
  should validate_presence_of(:email)  
  
  should allow_value("3931-234").for(:phone) 
  should_not allow_value("S").for(:phone)   
  should allow_value("admin").for(:role)
  should_not allow_value("none").for(:role)  
  should allow_value("something@test.com").for(:email)
  should_not allow_value("e").for(:email)  
  should allow_value("just").for(:password_digest)
  should_not allow_value("not").for(:password_digest)    
  # context
  context "Within context" do
    setup do
      create_users
    end
    
    teardown do
      delete_users
    end
  end
  
end
