# frozen_string_literal: true

require 'colorize'

COLOR = {
  'RED' => ->(text) { text.colorize(:red) },
  'BLUE' => ->(text) { text.colorize(:blue) },
  'CYAN' => ->(text) { text.colorize(:cyan) },
  'GREEN' => ->(text) { text.colorize(:green) },
  'WHITE' => ->(text) { text.colorize(:white) },
  'YELLOW' => ->(text) { text.colorize(:yellow) }
}.freeze
