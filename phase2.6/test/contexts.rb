require './test/sets/curriculum_contexts'
require './test/sets/location_contexts'
require './test/sets/camp_contexts'
require './test/sets/instructor_contexts'
require './test/sets/camp_instructor_contexts'

module Contexts
  include Contexts::CurriculumContexts
  include Contexts::LocationContexts
  include Contexts::CampContexts
  include Contexts::InstructorContexts
  include Contexts::CampInstructorContexts
  
  def create_contexts
    create_curriculums
    create_locations
    create_camps
    create_instructors
    create_camp_instructors
  end
end
