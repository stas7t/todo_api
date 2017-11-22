FactoryGirl.define do
  factory :deadline do
    date '2017-10-20'
    time '01:35:07'
    task

    trait :edited do
      date '2018-05-10'
      time '15:35:11'
    end
  end
end
