# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    content "MyString"
    complete false
    contact_id 1
    issue nil
  end
end
