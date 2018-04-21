module Contexts
  module CampContexts
    def create_camps
      @camp1 = FactoryBot.create(:camp, curriculum: @programming, location: @doha, start_date: Date.today, end_date: Date.today)
      @camp2 = FactoryBot.create(:camp, curriculum: @drama, location: @pittsburgh, start_date: Date.today, end_date: Date.today)      
    end
    
    def destroy_camps
      @camp1.destroy
      @camp2.destroy
    end
  end
end