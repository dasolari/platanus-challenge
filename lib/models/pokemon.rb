# frozen_string_literal: true

require 'strings-case'
require_relative './type'
require_relative './move'
require_relative '../constants/move_nature'
require_relative '../constants/move_type'

# Class that represents a pokemon object
class Pokemon
  attr_accessor :hp
  attr_reader :name, :attack, :defense, :special_attack, :special_defense, :speed, :types

  def initialize(name)
    @name = name.capitalize
    @types = []
    @special_odds = 1
    @normal_odds = 2
    @alive = true
  end

  def initialize_stats(stats_array)
    stats_array.each do |stat_object|
      name = Strings::Case.snakecase(stat_object.stat.name)
      value = stat_object.base_stat.to_i
      instance_variable_set("@#{name}", value)
    end
  end

  def initialize_types(types_array, api_object)
    types_array.each do |type_object|
      name = type_object.type.name
      response = api_object.get_type(name)
      @types << Type.new(name, response.damage_relations)
    end
  end

  def strike(opponent)
    attack_move = choose_attack(opponent.types)
    opponent.defend(attack_move)
  end

  def defend(attack_move)
    damage_taken = calculate_damage_taken(attack_move)
    return unless damage_taken.positive?

    @hp -= damage_taken
    check_health
  end

  def choose_attack(opponent_types)
    odds = [MoveType::PHISICAL] * @normal_odds + [MoveType::SPECIAL] * @special_odds # [PHISICAL, PHISICAL, SPECIAL]
    attack_type = odds.delete_at(rand(odds.length))
    return Move.new(MoveNature::ATTACK, MoveType::PHISICAL, @attack) unless attack_type == MoveType::SPECIAL

    chosen_attack = @types.sample
    modified_damage = consider_opponent_defense(chosen_attack, opponent_types, @special_attack)
    Move.new(MoveNature::ATTACK, MoveType::SPECIAL, modified_damage, chosen_attack.name)
  end

  def consider_opponent_defense(chosen_attack, opponent_types, damage)
    damage = check_damage_to_stats(chosen_attack.double_damage_to, 2, opponent_types, damage)
    damage = check_damage_to_stats(chosen_attack.half_damage_to, 0.5, opponent_types, damage)
    check_damage_to_stats(chosen_attack.no_damage_to, 0, opponent_types, damage)
  end

  def check_damage_to_stats(damage_stats_array, multiplier, opponent_types, damage)
    damage_stats_array.each do |type_name|
      damage *= multiplier if opponent_types.map(&:name).include?(type_name)
    end
    damage
  end

  def calculate_damage_taken(attack_move)
    return attack_move.value - @defense unless attack_move.type == MoveType::SPECIAL

    modified_damage = consider_opponent_attack(attack_move.chosen_type, attack_move.value)
    modified_damage - @special_defense
  end

  def consider_opponent_attack(attack_type, damage)
    @types.each do |type|
      damage = check_damage_from_stats(type.double_damage_from, 2, attack_type, damage)
      damage = check_damage_from_stats(type.half_damage_from, 0.5, attack_type, damage)
      damage = check_damage_from_stats(type.no_damage_from, 0, attack_type, damage)
    end
    damage
  end

  def check_damage_from_stats(damage_stats_array, multiplier, attack_type, damage)
    damage_stats_array.each do |type_name|
      damage *= multiplier if attack_type == type_name
    end
    damage
  end

  def check_health
    @alive = false if @hp <= 0
  end
end
