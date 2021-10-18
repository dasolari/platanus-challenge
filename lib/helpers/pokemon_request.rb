# frozen_string_literal: true

require 'httparty'

# Class in charge of making requests to the Pokemon API
class PokemonRequest
  include HTTParty
  base_uri 'https://pokeapi.co/api/v2'

  def get_pokemon(id)
    self.class.get("/pokemon/#{id}")
  end

  def get_type(type)
    self.class.get("/type/#{type}")
  end
end
