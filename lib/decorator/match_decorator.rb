# frozen_string_literal: true

require_relative './base_decorator'

# Concrete implementation of the Decorator Base class for Match
class MatchDecorator < BaseDecorator
  def play
    @component.view.print_match_started(@component.match_number, @component.pokemon1.name, @component.pokemon2.name)
    @component.play
    @component.view.print_match_winner(@component.match_number, @component.winner.name)
  end
end
