class Product < ApplicationRecord
  has_many :variants
  has_many :images, as: :picturable
end
