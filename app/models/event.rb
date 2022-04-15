class Event < ApplicationRecord
  belongs_to :livehouse
  has_many :comments, dependent: :destroy
  has_many :joins

  scope :date_after_today, -> { where('held_on >= ?', Date.current) }
  scope :date_before_today, -> { where('held_on < ?', Date.current) }
  scope :sort_held_on, -> { order(held_on: "ASC") }
end
