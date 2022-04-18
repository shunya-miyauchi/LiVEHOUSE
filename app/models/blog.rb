class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  mount_uploaders :images, ImagesUploader

  validates :title, presence: true, length: { maximum: 30 }

  scope :reverse_created_at, -> { order(created_at: 'DESC') }
end
