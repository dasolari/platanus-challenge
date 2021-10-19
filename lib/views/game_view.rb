# frozen_string_literal: true

require 'terminal-table'
require_relative '../helpers/colorizer'

# Singleton class in charge of the user interface
class View
  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def print_greeting
    display('Hello and welcome to this pokemon tournament', 2, true)
  end

  def print_players_and_stats(pokemons)
    players_table = Terminal::Table.new do |table|
      pokemons.each do |pokemon|
        pk = pokemon
        table << [pk.name, pk.hp, pk.attack, pk.defense, pk.special_attack, pk.special_defense, pk.speed]
      end
      center_table_columns(table)
    end
    players_table.headings = [' ', 'HP', 'Attack', 'Defense', 'Special Attack', 'Special Defense', 'Speed']
    players_table.style = { all_separators: true }
    display_table(players_table)
  end

  def display_table(table)
    display('These are the Pokemons remaining in the tournament:', 2, false)
    puts table
    display('We advance to the next stage...', 1, true)
  end

  def center_table_columns(table)
    (1..6).each do |col|
      table.align_column(col, :center)
    end
  end

  def print_match_started(match_number, player1, player2)
    display("It's match number #{match_number} and we have #{player1} against #{player2}", 1.5, true, 1)
  end

  def print_attack(attacker, defender, attack_type, damage, type = nil)
    if type.nil?
      display("💥 #{attacker} does a #{attack_type} attack to #{defender} for #{damage} damage!", 0.4, false, 2, 'RED')
    elsif damage.zero?
      display("❌ #{attacker} does a SPECIAL attack, but #{defender} completely blocks it!!", 0.4, false, 2, 'RED')
    else
      display("💥 #{attacker} does a #{type} #{attack_type} attack to #{defender} for #{damage} damage!", 0.4, false, 2,
              'RED')
    end
  end

  def print_effective_defense(defender)
    display("💪 #{defender} completely blocks off the attack!", 0.4, false, 2, 'BLUE')
  end

  def print_defense(defender, incoming_damage, actual_damage, hp_left)
    hit_msg = "💪 #{defender} takes a hit for #{incoming_damage}."
    damage_taken_msg = " Given it's defense and type, recieves #{actual_damage} damage. It is left with #{hp_left} HP!"
    display(hit_msg + damage_taken_msg, 0.4, false, 2, 'BLUE')
  end

  def print_defeated(defender)
    display("😵 #{defender} is defeated.", 1.4, true, 1, 'CYAN')
  end

  def print_match_winner(match_number, winner)
    display("Match number #{match_number} is finished and #{winner} is the winner!!", 2.5, true, 2, 'GREEN')
  end

  def print_deadlock_formed(attacker, defender)
    display("🔒 Deadlock formed. Reducing #{attacker} and #{defender}'s defense by 25%.", 0.6, false, 2, 'RED')
  end

  def print_tournament_winner(winner)
    display("👑 👑 #{winner} wins the tournament with a crushing victory 👑 👑", 3, true, 0, 'YELLOW')
  end

  def print_goodbye
    display('Goodbye :)', 0, false)
  end

  def display(text, sleep_time, line_skip, tab = 0, color = 'WHITE')
    puts '  ' * tab + COLOR[color].call(text)
    line_skip && puts
    sleep(sleep_time)
  end
end
