# frozen_string_literal: true

# Interface common for all classes with a play method
class GameInterface
  def play
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
