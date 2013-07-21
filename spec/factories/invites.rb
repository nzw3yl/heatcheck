# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite do
    user_id 1
    provider_id 1
    invitee_email "MyString"
    access_code "MyString"
    accepted false
    valid_thru "2013-07-19"
  end
end
