# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :heat_log do
    transaction_date "2013-06-29"
    entity_type "MyString"
    entity_id 1
    temperature 1
    measure nil
    provider_id 1
  end
end
