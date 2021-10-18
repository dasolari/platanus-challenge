# frozen_string_literal: true

require_relative './helpers/pokemon_generator'

generator = PokemonGenerator.new(151, 8)

generator.pokemons.each do |pokemon|
  puts pokemon.name.capitalize()
  puts "Health Points: #{pokemon.hp}"
  puts "Attack: #{pokemon.attack}"
  puts "Defense: #{pokemon.defense}"
  puts "Special Attack: #{pokemon.special_attack}"
  puts "Special Defense: #{pokemon.special_defense}"
  puts "Speed: #{pokemon.speed}"
  puts ' '
end
