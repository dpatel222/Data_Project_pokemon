class ChangeTypeToTextInPokemons < ActiveRecord::Migration[7.1]
  def change
    change_column :pokemons, :type, :text
  end
end
