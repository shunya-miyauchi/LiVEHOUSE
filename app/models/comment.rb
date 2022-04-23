class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :content, presence: true

  scope :reverse_created_at, -> { order(created_at: 'DESC') }
end
