class AddImageUrlToPokemons < ActiveRecord::Migration[7.1]
  def change
    add_column :pokemons, :images_url, :string
  end
end
