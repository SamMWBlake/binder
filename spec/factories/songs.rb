FactoryGirl.define do
  sequence(:title) { |n| "#{100 - n} Bottles of Beer (on the Wall)" }

  factory :song do
    title
    artist
  end
end
