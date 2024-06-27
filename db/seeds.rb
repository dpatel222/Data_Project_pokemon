require 'http'
require 'json'

# Clear existing data
Pokemon.destroy_all
Type.destroy_all
Ability.destroy_all

url = 'https://pokeapi.co/api/v2/pokemon?limit=2000&offset=0'
response = HTTP.get(url)
data = JSON.parse(response)

data["results"].each do |pokemon|
  pokemon_url = pokemon["url"]
  pokemon_response = HTTP.get(pokemon_url)
  pokemon_data = JSON.parse(pokemon_response)

  # Extract abilities as a capitalized string with each ability on a new line
  abilities = pokemon_data["abilities"].map { |ability| ability["ability"]["name"].capitalize }

  # Extract types as a capitalized string with each type on a new line
  types = pokemon_data["types"].map { |type| type["type"]["name"].capitalize }

  # Extract stats
  hp = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "hp" }["base_stat"]
  attack = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "attack" }["base_stat"]
  defence = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "defense" }["base_stat"]
  special_attack = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "special-attack" }["base_stat"]
  special_defence = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "special-defense" }["base_stat"]
  speed = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "speed" }["base_stat"]

  image_url = pokemon_data["sprites"]["front_default"]

  # Create Pokemon record
  new_pokemon = Pokemon.create(
    name: pokemon_data["name"].capitalize,
    ability: abilities,
    hp: hp,
    attack: attack,
    defence: defence,
    special_attack: special_attack,
    special_defence: special_defence,
    speed: speed,
    images_url: image_url
  )

  # Associate Pokemon with Types
  types.each do |type_name|
    pokemon_type = Type.find_or_create_by(name: type_name)
    new_pokemon.types << pokemon_type
  end
  abilities.each do |ability_name|
    pokemon_ability = Ability.find_or_create_by(name: ability_name)
    new_pokemon.abilities << pokemon_ability
  end
end

puts "Pokémon data has been successfully imported."



Move.destroy_all

# Fetch data from the API
url = 'https://pokeapi.co/api/v2/move?limit=1000'  # Assuming you want to fetch all moves
response = HTTP.get(url)
data = JSON.parse(response)

# Iterate over each move and create records in the database
data['results'].each do |move|
  Move.create(name: move['name'].capitalize)
end

puts "Move data has been successfully imported."

Item.destroy_all

item_url = 'https://pokeapi.co/api/v2/item?offset=0&limit=200'
item_response = HTTP.get(item_url)
item_data = JSON.parse(item_response)

# Iterate over each item and create records in the database
item_data['results'].each do |item|
  Item.create(name: item['name'].capitalize)
end
puts "Move and Item data have been successfully imported."
