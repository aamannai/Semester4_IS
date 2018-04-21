FactoryBot.define do
  factory :camp do
    #curriculum_id 1
    #location_id 1
    cost 1.5
    start_date "2018-04-07"
    end_date "2018-04-07"
    time_slot "am"
    max_students 1
    active true
    association :curriculum
    association :location    
  end
end
