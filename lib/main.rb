# frozen_string_literal: true

require_relative './helpers/pokemon_generator'

generator = PokemonGenerator.new(151, 8)

generator.pokemons.each do |pokemon|
  puts pokemon.name
  puts "Health Points: #{pokemon.hp}"
  puts "Attack: #{pokemon.attack}"
  puts "Defense: #{pokemon.defense}"
  puts "Special Attack: #{pokemon.special_attack}"
  puts "Special Defense: #{pokemon.special_defense}"
  puts "Speed: #{pokemon.speed}"
  pokemon.affecting_types.each do |type|
    puts "  Name: #{type.name}"
    puts "  DDF: #{type.double_damage_from}"
  end
  puts ' '
end
