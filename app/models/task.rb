class Task < ApplicationRecord
  belongs_to :project
  has_one :deadline, dependent: :destroy

  validates :name, presence: true
end
