FactoryGirl.define do
  factory :activity_post, class: ActivityPost do
    sequence(:description) {|n| "#{n}_Thing" }
    activity

  end
end
