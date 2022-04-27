class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  mount_uploaders :images, ImagesUploader

  validates :title, presence: true, length: { maximum: 30 }

  scope :reverse_event_held_on, -> { order('events.held_on desc') }
end
