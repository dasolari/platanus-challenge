# frozen_string_literal: true

require_relative './game_interface'

# Base decorator class for printing before and after the play method
class BaseDecorator < GameInterface
  attr_accessor :component

  def initialize(component)
    super()
    @component = component
  end

  def play
    @component.play
  end
end
