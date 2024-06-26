require 'http'
require 'json'

# Clear existing data
Pokemon.destroy_all

url = 'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0'
response = HTTP.get(url)
data = JSON.parse(response)

data["results"].each do |pokemon|
  pokemon_url = pokemon["url"]
  pokemon_response = HTTP.get(pokemon_url)
  pokemon_data = JSON.parse(pokemon_response)

  # Extract abilities as a comma-separated string
  abilities = pokemon_data["abilities"].map { |ability| ability["ability"]["name"] }.join(', ')

  # Extract types as an array of strings
  types = pokemon_data["types"].map { |type| type["type"]["name"] }.join(', ')

  # Extract stats
  hp = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "hp" }["base_stat"]
  attack = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "attack" }["base_stat"]
  defence = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "defense" }["base_stat"]
  special_attack = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "special-attack" }["base_stat"]
  special_defence = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "special-defense" }["base_stat"]
  speed = pokemon_data["stats"].find { |stat| stat["stat"]["name"] == "speed" }["base_stat"]

  image_url = pokemon_data["sprites"]["front_default"]
  # Create Pokemon record
  Pokemon.create(
    name: pokemon_data["name"],
    ability: abilities,
    pokemon_types: types,  # Updated to use the renamed column
    hp: hp,
    attack: attack,
    defence: defence,
    special_attack: special_attack,
    special_defence: special_defence,
    speed: speed,
    images_url: image_url
  )


end



puts "Pokémon data has been successfully imported."
