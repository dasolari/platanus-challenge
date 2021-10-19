# frozen_string_literal: true

require_relative './base_decorator'

# Concrete implementation of the Decorator Base class for GameController
class GameControllerDecorator < BaseDecorator
  def play
    @component.view.print_greeting
    @component.play
    @component.view.print_tournament_winner(@component.tournament_decorator.component.winner.name)
    @component.view.print_goodbye
  end
end
