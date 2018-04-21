module Contexts
  module CampInstructorContexts
    def create_camp_instructors
      @ci_brian = FactoryBot.create(:camp_instructor, instructor: @brian, camp: @camp1)
      @ci_david = FactoryBot.create(:camp_instructor, instructor: @david, camp: @camp2)      
    end
    
    def destroy_instructors
      @ci_brian.destroy
      @ci_david.destroy
    end
  end
end