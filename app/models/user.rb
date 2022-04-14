class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_livehouses, through: :favorites, source: :livehouse
  has_many :comments, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :join_events, through: :joins, source: :event

  mount_uploader :image, IconUploader

  validates :name, presence: true
  validates :display_name,
            uniqueness: true,
            length: { minimum: 5, maximum: 15 },
            format: { with: /\A[a-z0-9_]{5,15}\z/ }
  

  def favorites_by?(livehouse_id)
    favorites.find_by(livehouse_id: livehouse_id).present?
  end

  def joins_by?(event_id)
    joins.find_by(event_id: event_id).present?
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'ゲスト'
      user.display_name = 'guest'
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.admin_guest
    find_or_create_by!(email: 'admin_guest@example.com') do |user|
      user.name = '管理者ゲスト'
      user.display_name = 'admin_guest'
      user.password = SecureRandom.urlsafe_base64
      user.admin = true
    end
  end
end
