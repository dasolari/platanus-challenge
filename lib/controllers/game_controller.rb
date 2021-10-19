# frozen_string_literal: true

require_relative '../views/game_view'

# Class that controls the flow of the game and interacts with the UI
class GameController
  attr_reader :tournament_decorator, :view

  def initialize(tournament_decorator)
    @tournament_decorator = tournament_decorator
    @view = View.instance
  end

  def play
    @tournament_decorator.play
  end
end
