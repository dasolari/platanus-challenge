# frozen_string_literal: true

# Class that represents a match between 2 pokemons
class Match
  attr_reader :winner

  def initialize(match_number, pokemon1, pokemon2)
    @match_number = match_number
    @pokemon1 = pokemon1
    @pokemon2 = pokemon2
    @pokemon_attacking = nil
    @winner = nil
    define_who_starts
  end

  def define_who_starts
    pokemon_array = [@pokemon1, @pokemon2]
    speed_array = pokemon_array.map(&:speed)
    index_of_max = speed_array.index(speed_array.max)
    @pokemon_attacking = pokemon_array[index_of_max]
  end

  def play
    loop do
      defender = who_is_defending
      @pokemon_attacking.strike(defender)
      !defender.alive && @winner = @pokemon_attacking
      break unless @winner.nil?

      switch_turn
    end
  end

  def switch_turn
    @pokemon_attacking = if @pokemon_attacking == @pokemon2
                           @pokemon1
                         else
                           @pokemon2
                         end
  end

  def who_is_defending
    return @pokemon2 if @pokemon_attacking == @pokemon1

    @pokemon1
  end
end
