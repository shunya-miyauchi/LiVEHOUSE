class Event < ApplicationRecord
  belongs_to :livehouse
  has_many :comments, dependent: :destroy
end
