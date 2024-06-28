class Item < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :effect, presence: false

end
