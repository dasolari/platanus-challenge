# frozen_string_literal: true

require_relative './base_decorator'

# Concrete implementation of the Decorator Base class for Tournament
class TournamentDecorator < BaseDecorator
  def play
    @component.view.print_players_and_stats(@component.current_stage_pokemons)
    @component.play
  end
end
