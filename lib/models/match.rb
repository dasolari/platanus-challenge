# frozen_string_literal: true

require_relative '../views/game_view'

# Class that represents a match between 2 pokemons
class Match
  attr_reader :winner

  def initialize(match_number, pokemon1, pokemon2)
    @match_number = match_number
    @pokemon1 = pokemon1
    @pokemon2 = pokemon2
    @pokemon_attacking = nil
    @winner = nil
    @done = false
    @view = View.new
    define_who_starts
  end

  def define_who_starts
    pokemon_array = [@pokemon1, @pokemon2]
    speed_array = pokemon_array.map(&:speed)
    index_of_max = speed_array.index(speed_array.max)
    @pokemon_attacking = pokemon_array[index_of_max]
  end

  def play
    @view.print_match_started(@match_number, @pokemon1.name, @pokemon2.name)
    loop do
      defender = who_is_defending
      @pokemon_attacking.strike(defender)
      unless defender.alive
        @winner = @pokemon_attacking
        @done = true
      end
      break if @done

      sleep(0.5)
      switch_turn
    end
    @view.print_match_winner(@match_number, @winner.name)
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
