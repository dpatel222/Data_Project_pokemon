class Move < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :power, numericality: true
  
end
