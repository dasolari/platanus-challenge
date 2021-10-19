# frozen_string_literal: true

require_relative 'controllers/game_controller'
require_relative 'helpers/pokemon_generator'
require_relative 'helpers/validate'
require_relative 'models/tournament'
require_relative 'views/game_view'

#### <CHANGE INPUTS HERE> ####
number_of_pokemons = 8
first_n_pokemons = 151
#### </CHANGE INPUTS HERE> ####

if validate_number_of_pokemons(number_of_pokemons) && validate_pool_size(first_n_pokemons)
  generator = PokemonGenerator.new(first_n_pokemons, number_of_pokemons)
  tournament = Tournament.new(generator.pokemons)
  view = View.instance
  game_controller = GameController.new(tournament, view)
  game_controller.play
else
  puts 'Wrong number of inputs...'
  puts '  - The ammount of pokemons has to be a power of 2.'
  puts '  - You cannot choose from more than 898 pokemons, there are not that many.'
end
