FactoryGirl.define do
  factory :task do
    sequence(:name) { |n| "Task #{n}" }
    completed false
    project

    trait :completed do
      completed true
    end

    trait :edited do
      name 'edited name'
    end

    trait :with_comments do
      after(:create) do |instance|
        create_list :comment, 2, task: instance
      end
    end

    trait :with_deadline do
      after(:create) do |instance|
        create :deadline, task: instance
      end
    end
  end
end
