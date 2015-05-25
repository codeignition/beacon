# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call_log do
    phone_number "MyString"
    answered_at "2014-07-04 14:28:03"
  end
end
