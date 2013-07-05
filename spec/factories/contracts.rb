# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contract do
    partner_id 1
    customer_id 1
    expiry_date "2013-07-02"
    start_date "2013-07-02"
    notes "MyText"
  end
end
