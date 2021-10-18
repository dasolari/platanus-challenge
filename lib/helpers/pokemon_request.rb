# frozen_string_literal: true

require 'httparty'
require 'recursive-open-struct'

# Class in charge of making requests to the Pokemon API
class PokemonRequest
  include HTTParty
  base_uri 'https://pokeapi.co/api/v2'

  def get_pokemon(id)
    response = self.class.get("/pokemon/#{id}")
    structure_response(response)
  end

  def get_type(type)
    response = self.class.get("/type/#{type}")
    structure_response(response)
  end

  # Structure response to allow dot notation
  def structure_response(response)
    RecursiveOpenStruct.new(response, recurse_over_arrays: true)
  end
end
