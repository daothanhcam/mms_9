FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "user#{n}"
    end
    sequence :email do |n|
     "user.example#{n}@gmail.com"
    end
    password "123456789"
    password_confirmation "123456789"
    role "admin"
  end
end
