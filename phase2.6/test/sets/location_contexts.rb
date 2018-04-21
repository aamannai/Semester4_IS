module Contexts
  module LocationContexts
    def create_locations
      @doha = FactoryBot.create(:location)
      @pittsburgh = FactoryBot.create(:location, name: "Doha", street_1: "Education City", zip: "70006", max_capacity: "10", active: true)
    end
    
    def destroy_locations
      @doha.destroy
      @pittsburgh.destroy
    end
  end
end