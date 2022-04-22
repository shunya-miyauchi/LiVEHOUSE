class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :content, presence: true

  scope :sort_created_at, -> { order(created_at: 'ASC') }
end
