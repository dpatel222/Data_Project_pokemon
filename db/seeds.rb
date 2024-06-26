require 'http'
require 'json'

# Clear existing data
Pokemon.destroy_all
Type.destroy_all

url = 'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0'
response = HTTP.get(url)
data = JSON.parse(response)

data["results"].each do |pokemon|
  pokemon_url = pokemon["url"]
  pokemon_response = HTTP.get(pokemon_url)
  pokemon_data = JSON.parse(pokemon_response)

  # Extract abilities as a capitalized string with each ability on a new line
  abilities = pokemon_data["abilities"].map { |ability| ability["ability"]["name"].capitalize }.join(", ")

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
end

puts "Pokémon data has been successfully imported."
