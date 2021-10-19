# frozen_string_literal: true

require_relative '../views/game_view'
require_relative './match'

# Class that represents a tournament, which is composed of many matches
class Tournament
  attr_reader :current_stage_pokemons, :winner

  def initialize(pokemons)
    @current_stage_pokemons = pokemons
    @next_stage_pokemons = []
    @current_match = 1
    @winner = nil
    @done = false
    @view = View.new
  end

  def start
    @view.print_players_and_stats(@current_stage_pokemons)
    loop do
      play_a_match
      @current_stage_pokemons.empty? && check_if_winner
      break if @done
    end
  end

  def play_a_match
    pokemon1, pokemon2 = choose_two_pokemons
    match = Match.new(@current_match, pokemon1, pokemon2)
    match.play
    @next_stage_pokemons << match.winner
    @current_match += 1
  end

  def choose_two_pokemons
    pokemon1 = @current_stage_pokemons.delete_at(rand(@current_stage_pokemons.length))
    pokemon2 = @current_stage_pokemons.delete_at(rand(@current_stage_pokemons.length))
    [pokemon1, pokemon2]
  end

  def check_if_winner
    if @next_stage_pokemons.length == 1 && @current_stage_pokemons.empty?
      @winner = @next_stage_pokemons.pop
      @done = true
    else
      @current_stage_pokemons = @next_stage_pokemons
      @next_stage_pokemons = []
      reset_remaining_pokemons
      @view.print_players_and_stats(@current_stage_pokemons)
    end
  end

  def reset_remaining_pokemons
    @current_stage_pokemons.each do |pokemon|
      pokemon.reset
    end
  end
end
