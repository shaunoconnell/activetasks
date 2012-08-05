FactoryGirl.define do
  factory :activity, class: Activity do
    sequence(:name) {|n| "My_Activity_#{n}" }
    user
  end
end
