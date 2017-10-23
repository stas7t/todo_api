class Comment < ApplicationRecord
  belongs_to :task

  mount_uploader :file, ImageUploader

  validates :text, presence: true
  validates :file, file_size: { less_than_or_equal_to: 10.megabytes }
end
