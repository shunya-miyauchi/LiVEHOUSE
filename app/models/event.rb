class Event < ApplicationRecord
  belongs_to :livehouse
  has_many :comments, dependent: :destroy
  has_many :joins
  has_many :blogs

  scope :date_after_today, -> { where('held_on >= ?', Date.current) }
  scope :date_before_today, -> { where('held_on < ?', Date.current) }
  scope :sort_held_on, -> { order(held_on: 'ASC') }
  scope :reverse_held_on, -> { order(held_on: 'DESC') }

  def date_title
    date = held_on.strftime('%Y/%-m/%d')
    "#{date}#{title}".truncate(30, omission: '...')
  end
end
