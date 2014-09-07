FactoryGirl.define do
  sequence(:email)    { |n| "user#{n}@emptyorchestra.co" }
  sequence(:username) { |n| "user#{n}" }

  factory :user do
    email
    username
    password              "password"
    password_confirmation { |user| user.password }

    factory :admin do
      email    "admin@emptyorchestra.co"
      username "admin"
      admin    true
    end
  end
end
