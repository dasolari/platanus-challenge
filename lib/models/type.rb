# frozen_string_literal: true

# Class for representing a type object for a pokemon
class Type
  attr_reader :name, :double_damage_from, :double_damage_to, :half_damage_from, :half_damage_to, :no_damage_from,
              :no_damage_to

  def initialize(name, damage_relations)
    @name = name
    build(damage_relations)
  end

  def build(damage_relations)
    @double_damage_from = damage_relations.double_damage_from.map(&:name)
    @double_damage_to = damage_relations.double_damage_to.map(&:name)
    @half_damage_from = damage_relations.half_damage_from.map(&:name)
    @half_damage_to = damage_relations.half_damage_to.map(&:name)
    @no_damage_from = damage_relations.no_damage_from.map(&:name)
    @no_damage_to = damage_relations.no_damage_to.map(&:name)
  end
end
