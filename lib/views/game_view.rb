# frozen_string_literal: true

require 'terminal-table'

# Class that represents the user interface in console
class View
  def print_greeting
    display("Hello and welcome to this pokemon tournament", 3, true)
  end

  def print_players_and_stats(pokemons)
    players_table = Terminal::Table.new do |table|
      pokemons.each do |pokemon|
        pk = pokemon
        table << [pk.name, pk.hp, pk.attack, pk.defense, pk.special_attack, pk.special_defense, pk.speed]
      end
      table.align_column(1, :center)
      table.align_column(2, :center)
      table.align_column(3, :center)
      table.align_column(4, :center)
      table.align_column(5, :center)
      table.align_column(4, :center)
    end
    players_table.headings = [' ', 'HP', 'Attack', 'Defense', 'Special Attack', 'Special Defense', 'Speed']
    players_table.style = { all_separators: true }
    display("These are the Pokemons remaining in the tournament:", 2, false)
    puts players_table
    display("We advance to the next stage...", 1, true)
  end

  def print_match_started(match_number, player1, player2)
    display("It's match number #{match_number} and we have #{player1} against #{player2}", 1.5, true, 1)
  end

  def print_attack(attacker, defender, attack_type, damage, type = nil)
    if type.nil?
      display("💥 #{attacker} does a #{attack_type} attack to #{defender} for #{damage} damage!", 0.4, false, 2)
    elsif damage.zero?
      display("❌ #{attacker} does a SPECIAL attack, but #{defender} completely blocks it!!", 0.4, false, 2)
    else
      display("💥 #{attacker} does a #{type} #{attack_type} attack to #{defender} for #{damage} damage!", 0.4, false, 2)
    end
  end

  def print_effective_defense(defender)
    display("💪 #{defender} completely blocks off the attack!", 0.4, false, 2)
  end

  def print_defense(defender, incoming_damage, actual_damage, hp_left)
    display("💪 #{defender} takes a hit for #{incoming_damage}, but resists it and recieves #{actual_damage} damage. It is left with #{hp_left} HP!", 0.4, false, 2)
    return unless hp_left <= 0

    display("😵 #{defender} is defeated.", 1.4, true, 1)
  end

  def print_match_winner(match_number, winner)
    display("Match number #{match_number} is finished and #{winner} is the winner!!", 2.5, true, 2)
  end

  def print_tournament_winner(winner)
    display("👑 👑 #{winner} wins the tournament with a crushing victory 👑 👑", 3, false)
  end

  def print_goodbye
    display('Goodbye :)', 0, false)
  end

  def display(text, sleep_time, line_skip, tab = 0, color = nil)
    puts '  ' * tab + text
    line_skip && puts
    sleep(sleep_time)
  end
end
