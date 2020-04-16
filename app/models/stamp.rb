class Stamp < ApplicationRecord
  belongs_to :stampbook
  has_one :user, through: :stampbook
  default_scope -> { order(created_at: :desc) }
  mount_uploader :photo, PhotoUploader
  validates :name, presence: true
  validates :photo, presence: true
  validates :stampbook_id, presence: true

  scope :search, -> (search_params) do
    return if search_params.blank?

    name_like(search_params[:name])
      .distinction_is(search_params[:distinction])
      .given_date_from(search_params[:given_date_from])
      .given_date_to(search_params[:given_date_to])
      .stampbook_id_is(search_params[:stampbook_id])
  end
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :distinction_is, -> (distinction) { where(distinction: distinction) if distinction.present? }
  scope :given_date_from, -> (from) { where('? <= given_date', from) if from.present? }
  scope :given_date_to, -> (to) { where('given_date <= ?', to) if to.present? }
  scope :stampbook_id_is, -> (stampbook_id) { where(stampbook_id: stampbook_id) if stampbook_id.present? }
end
