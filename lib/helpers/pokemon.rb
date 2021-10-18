# frozen_string_literal: true

require 'strings-case'

# Class that represents a pokemon object
class Pokemon
  attr_accessor :name, :hp, :attack, :defense, :special_attack, :special_defense, :speed

  def initialize(name)
    @name = name
  end

  def initialize_stats(stats_array)
    stats_array.each do |stat_object|
      name = Strings::Case.snakecase(stat_object.stat.name)
      value = stat_object.base_stat.to_i
      instance_variable_set("@#{name}", value)
    end
  end

  # TODO
  # def initialize_types
  # end
end
