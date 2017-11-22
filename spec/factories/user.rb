FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:password) { |n| "password#{n}" }
    sequence(:password_confirmation) { |n| "password#{n}" }

    trait :no_existing_user do
      username 'username1X'
      password 'password1X'
      password_confirmation 'password1X'
    end

    trait :no_username do
      username ''
    end

    trait :no_password do
      password ''
    end

    trait :no_password_confirmation do
      password_confirmation ''
    end

    trait :lower_than_min_username do
      username 'x'
    end

    trait :greater_than_max_username do
      username 'x'*51
    end

    trait :lower_than_min_password do
      password 'pass1'
      password_confirmation 'pass1'
    end

    trait :no_alphanumeric_password do
      password 'pass1-<>!*'
      password_confirmation 'pass1-<>!*'
    end
  end
end
