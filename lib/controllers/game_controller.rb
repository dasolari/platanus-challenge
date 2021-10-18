# frozen_string_literal: true

# Class that controls the flow of the game and interacts with the UI
class GameController
  attr_accessor :model, :view, :playing

  def initialize(game_model, game_view)
    @model = game_model
    @view = game_view
    @playing = true
  end

  def play
    loop do
      # do something
      break unless @playing
    end
  end
end
