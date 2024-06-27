class Pokemon < ApplicationRecord
  has_one_attached :image
  has_and_belongs_to_many :abilities
  has_and_belongs_to_many :types
  validates :name, presence: true, uniqueness: true
  validates :images_url, presence: true

end
