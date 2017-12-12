FactoryGirl.define do
  factory :comment do
    sequence(:text) { |n| "Comment text #{n}" }
    task

    trait :with_file do
      file "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcS"+
           "JAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdv"+
           "qGQAAAAadEVYdFNvZnR3YXJlAFBhaW50Lk5FVCB2My41LjEwMPRyoQAAAA1JREFUG"+
           "Fdj+P///38ACfsD/QVDRcoAAAAASUVORK5CYII="
    end
  end
end
