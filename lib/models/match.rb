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
    @deadlock_counter = 0
    @view = View.instance
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
      status = @pokemon_attacking.strike(defender)
      deadlock_status(status, defender)
      unless defender.alive
        @winner = @pokemon_attacking
        @done = true
      end
      break if @done

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

  def deadlock_status(status, defender)
    if status
      @deadlock_counter = 0
    else
      @deadlock_counter += 1
    end
    check_if_deadlock_exists(defender)
  end

  def check_if_deadlock_exists(defender)
    return unless @deadlock_counter >= 20

    @view.print_deadlock_formed(@pokemon_attacking.name, defender.name)
    @pokemon_attacking.defense *= 0.75
    defender.defense *= 0.75
    @deadlock_counter = 0
  end
end
