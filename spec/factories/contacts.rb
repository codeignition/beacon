# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :contact do
    name "String"
    phone_number "0000000000"
    email_id "example@email.com"
    user_id 
  end
end
