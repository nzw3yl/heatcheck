# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    name "MyString"
    title "MyString"
    team "MyString"
    ancestry "MyString"
    contactable_id 1
    contactable_type "MyString"
  end
end
