class Stamp < ApplicationRecord
  belongs_to :stampbook
  has_one :user, through: :stampbook
  default_scope -> { order(created_at: :desc) }
  mount_uploader :photo, PhotoUploader
  validates :name, presence: true
end
