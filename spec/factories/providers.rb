# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider do
    name "MyString"
    description "MyString"
    
    factory :provider_with_user do
      after_create do |provider|
        create(:user, provider: provider)
      end
    end
    
    factory :provider_with_customer do
      after_create do |provider|
        create(:customer, provider: provider)
      end
    end
    
    factory :provider_with_partner do
      after_create do |provider|
        create(:partner, provider: provider)
      end
    end
  end
end
