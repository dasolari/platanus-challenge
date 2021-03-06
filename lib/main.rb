# frozen_string_literal: true

require_relative './inputs'
require_relative 'controllers/game_controller'
require_relative 'decorator/game_controller_decorator'
require_relative 'decorator/tournament_decorator'
require_relative 'helpers/pokemon_generator'
require_relative 'helpers/validate'
require_relative 'models/tournament'

if validate_number_of_pokemons(NUMBER_OF_POKEMONS) && validate_pool_size(FIRST_N_POKEMONS)
  # Initialize the Pokemon generator, getting data from the API
  generator = PokemonGenerator.new(FIRST_N_POKEMONS, NUMBER_OF_POKEMONS)

  # Initialize the tournament instance with it's decorator for printing console messages
  tournament = Tournament.new(generator.pokemons)
  tournament_decorator = TournamentDecorator.new(tournament)

  # Initialize the Game Controller and it's decorator for printing console messages
  game_controller = GameController.new(tournament_decorator)
  game_controller_decorator = GameControllerDecorator.new(game_controller)

  # Start the game
  game_controller_decorator.play
else
  puts 'Wrong number of inputs...'
  puts '  - The ammount of pokemons has to be a power of 2.'
  puts '  - You cannot choose from more than 898 pokemons, there are not that many.'
end
