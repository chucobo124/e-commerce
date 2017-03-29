require 'carrierwave/orm/activerecord'

class Image < ApplicationRecord
  belongs_to :picturable, polymorphic: true, touch: true
  mount_uploader :asset, ImageUploader
end
