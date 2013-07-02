# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue_history do
    close_date "2013-06-30"
    issue_id "MyString"
    content "MyString"
    measure "MyString"
    temperature 1
    issueable_id 1
    issueable_type "MyString"
  end
end
