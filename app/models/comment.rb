class Comment < ApplicationRecord
  belongs_to :task

  mount_base64_uploader :file, ImageUploader

  validates :text, presence: true
  validates :text, length: { in: 10..256 }
  validates :file, file_size: { less_than_or_equal_to: 10.megabytes }
end
