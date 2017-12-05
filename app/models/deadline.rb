class Deadline < ApplicationRecord
  belongs_to :task

  # validates :task_id, uniqueness: true
end
