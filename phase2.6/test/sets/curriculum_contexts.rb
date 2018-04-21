module Contexts
  module CurriculumContexts
    def create_curriculums
      @english = FactoryBot.create(:curriculum)
      @drama = FactoryBot.create(:curriculum, name: "Drama", active: false)
      @programming = FactoryBot.create(:curriculum, name: "Programming", min_rating:700, max_rating:1000)
    end
    
    def destroy_curriculums
      @english.destroy
      @drama.destroy
      @programming.destroy
    end
  end
end