class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  mount_uploaders :image, ImagesUploader

  validates :title, presence: true,length: { maximum: 30 }
end
