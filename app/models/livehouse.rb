class Livehouse < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
