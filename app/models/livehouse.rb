class Livehouse < ApplicationRecord
  has_many :events, dependent: :destroy
