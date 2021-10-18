# frozen_string_literal: true

require 'recursive-open-struct'
require_relative './pokemon'
require_relative './pokemon_request'

# Class that generates the needed Pokemon objects for the tournament
class PokemonGenerator
  attr_reader :pokemons

  def initialize(pool_length, number_of_pokemons)
    @pool = [*1..pool_length]
    @pokemon_api = PokemonRequest.new
    @pokemons = []
    setup(number_of_pokemons)
  end

  def setup(number_of_pokemons)
    counter = 0
    loop do
      break unless counter < number_of_pokemons

      @pokemons << create_pokemon
      counter += 1
    end
  end

  def random_pokemon_id
    @pool.delete_at(rand(@pool.length))
  end

  def create_pokemon
    response = @pokemon_api.get_pokemon(random_pokemon_id)
    structured_response = RecursiveOpenStruct.new(response, recurse_over_arrays: true)
    pokemon = Pokemon.new(structured_response.name)
    pokemon.initialize_stats(structured_response.stats)
    pokemon
  end
end
