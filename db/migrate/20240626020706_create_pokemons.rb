class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :ability
      t.string :type
      t.integer :hp
      t.integer :attack
      t.integer :defence
      t.integer :special_attack
      t.integer :special_defence
      t.integer :speed

      t.timestamps
    end
  end
end
