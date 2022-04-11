class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_livehouses, through: :favorites, source: :livehouse
  mount_uploader :image, IconUploader

  def favorites_by?(livehouse_id)
    favorites.find_by(livehouse_id: livehouse_id).present?
  end
end
