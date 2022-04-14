class Livehouse < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :favorites, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
