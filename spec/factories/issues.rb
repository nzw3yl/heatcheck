# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    content "MyText"
    issueable_id 1
    issueable_type "MyString"
  end
end
