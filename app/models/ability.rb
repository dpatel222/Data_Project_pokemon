class Ability < ApplicationRecord
  has_and_belongs_to_many :pokemons

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
