class Stamp < ApplicationRecord
  belongs_to :stampbook
  has_one :user, through: :stampbook
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :stampbook_id, presence: true
end
