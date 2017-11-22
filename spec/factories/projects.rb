FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    user

    trait :edited do
      name 'edited name'
    end
  end
end
