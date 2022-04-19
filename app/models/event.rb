class Event < ApplicationRecord
  belongs_to :livehouse
  has_many :comments, dependent: :destroy
  has_many :joins
  has_many :blogs

  scope :date_after_today, -> { where('held_on >= ?', Date.current) }
  scope :this_week, -> { where('held_on <= ?',Date.current.end_of_week) }
  scope :date_before_today, -> { where('held_on < ?', Date.current) }
  scope :next_week, -> { where('held_on >= ?',Date.current.next_week(:monday)).where('held_on <= ?',Date.current.next_week(:sunday)) }
  scope :sort_held_on, -> { order(held_on: 'ASC') }
  scope :reverse_held_on, -> { order(held_on: 'DESC') }

  def date_title
    date = held_on.strftime('%Y/%-m/%d')
    "#{date}#{title}".truncate(30, omission: '...')
  end
end
