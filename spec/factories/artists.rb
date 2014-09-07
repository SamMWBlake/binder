FactoryGirl.define do
  sequence(:name) { |n| "#{100 - n} Degrees" }

  factory :artist do
    name
  end
end
