class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :title, presence: true,length: { maximum: 30 }
end
