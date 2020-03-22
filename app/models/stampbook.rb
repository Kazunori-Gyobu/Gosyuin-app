class Stampbook < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :cover, CoverUploader
  validates :user_id, presence: true
  validates :name, presence: true
end
