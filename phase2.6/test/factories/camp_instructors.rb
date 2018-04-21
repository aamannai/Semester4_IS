FactoryBot.define do
  factory :camp_instructor do
    #camp_id 1
    #instructor_id 1
    association :camp
    association :instructor    
  end
end
