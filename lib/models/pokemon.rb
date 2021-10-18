# frozen_string_literal: true

require 'strings-case'
require_relative './type'

# Class that represents a pokemon object
class Pokemon
  attr_accessor :hp
  attr_reader :name, :attack, :defense, :special_attack, :special_defense, :speed, :affecting_types

  def initialize(name)
    @name = name.capitalize
    @affecting_types = []
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
      @affecting_types << Type.new(name, response.damage_relations)
    end
  end
end
