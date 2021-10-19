# frozen_string_literal: true

# Class that represents a move with all its necesary attributes
class Move
  attr_reader :nature, :type, :value, :chosen_type

  def initialize(nature, type, value, chosen_type = nil)
    @nature = nature
    @type = type
    @value = value
    @chosen_type = chosen_type
  end
end
