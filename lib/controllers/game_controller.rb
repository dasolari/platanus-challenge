# frozen_string_literal: true

# Class that controls the flow of the game and interacts with the UI
class GameController
  attr_accessor :model, :view

  def initialize(game_model, game_view)
    @tournament = game_model
    @view = game_view
  end

  def play
    @view.print_greeting
    @tournament.start
    @view.print_tournament_winner(@tournament.winner.name)
    @view.print_goodbye
  end
end
