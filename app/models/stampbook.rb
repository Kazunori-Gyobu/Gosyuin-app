class Stampbook < ApplicationRecord
  belongs_to :user
  mount_uploader :cover, CoverUploader
end
