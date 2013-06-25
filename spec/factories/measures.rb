# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :measure do
    content "MyString"
    display_order 1
    weight 1
    provider nil
  end
end
