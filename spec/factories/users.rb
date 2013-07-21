# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'test'
    last_name 'user'
    email 'foo@bar.com'
    password 'changeme'
    password_confirmation 'changeme'
    confirmed_at Time.now
    provider
  end
end
