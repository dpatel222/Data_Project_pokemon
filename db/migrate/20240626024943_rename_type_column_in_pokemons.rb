class RenameTypeColumnInPokemons < ActiveRecord::Migration[7.1]
  def change
    rename_column :pokemons, :type, :pokemon_types
  end
end
