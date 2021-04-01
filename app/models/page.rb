class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :background_image
end
