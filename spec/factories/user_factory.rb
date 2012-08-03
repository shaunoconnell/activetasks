FactoryGirl.define do
  factory :user, class: User do
    sequence(:name) {|n| "person#{n}" }
    sequence(:email) {|n| "person#{n}@example.com" }
  end
end
