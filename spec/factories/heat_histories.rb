# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :heat_history do
    year 1
    week 1
    temperature ""
    entity_id 1
    entity_type "MyString"
  end
end
