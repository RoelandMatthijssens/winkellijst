# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :household do
    name "MyString"
    password_protected false
    password "MyString"
    city "MyString"
    postal_code "MyString"
    housenumber 1
    housenumber_addition "MyString"
    phonenumber "MyString"
  end
end
