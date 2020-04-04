class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :stampbooks, dependent: :destroy
  has_many :stamps, through: :stampbooks
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :active_relationships,
        class_name: 'Relationship',
       foreign_key: :follower_id,
         dependent: :destroy
  has_many :passive_relationships,
        class_name: 'Relationship',
       foreign_key: :followed_id,
         dependent: :destroy
  # @user.active_relationships.map(&:followed)
  # @user.following
  has_many :following,
    through: 'active_relationships',
     source: 'followed'
  has_many :followers,
    through: 'passive_relationships',
     source: 'follower'

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true

  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id",user_id: self.id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # def already_liked?(post)
  #   self.likes.exists?(post_id: post.id)
  # end
end
