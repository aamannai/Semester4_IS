module Contexts
  module InstructorContexts
    def create_instructors
      @brian = FactoryBot.create(:instructor, first_name: "Brian", last_name: "Smith", bio: "TESTING TEACHER", phone: "5555555", email: "brian@yahoo.com")
      @david = FactoryBot.create(:instructor, first_name: "David", last_name: "Richard", bio: nil, phone: "543234", email: "david@yahoo.com")      
    end
    
    def destroy_instructors
      @brian.destroy
      @david.destroy
    end
  end
end