class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_livehouses, through: :favorites, source: :livehouse
  has_many :comments, dependent: :destroy
  has_many :joins
  has_many :join_events, through: :joins, source: :event

  mount_uploader :image, IconUploader

  validates :name, presence: true
  validates :display_name, 
    uniqueness: true,
    length: {minimum:5, maximum:15},
    format: { with: /\A[a-z0-9_]{5,15}\z/ }


  
  def favorites_by?(livehouse_id)
    favorites.find_by(livehouse_id: livehouse_id).present?
  end

  def joins_by?(event_id)
    joins.find_by(event_id: event_id).present?
  end
end
