class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true

  def feed
    Post.where("user_id=?", id)
  end
end
