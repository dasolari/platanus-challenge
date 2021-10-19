# frozen_string_literal: true

require_relative 'helpers/pokemon_generator'
require_relative 'controllers/game_controller'
require_relative 'models/tournament'
require_relative 'views/game_view'

generator = PokemonGenerator.new(151, 8)

tournament = Tournament.new(generator.pokemons)
view = View.new
game_controller = GameController.new(tournament, view)
game_controller.play
