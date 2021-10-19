# frozen_string_literal: true

# Check if the number is a power of 2
def validate_number_of_pokemons(number)
  number.to_s(2).count('1') == 1
end

# Check if the max pool number is in range with actual existing pokemons
def validate_pool_size(size)
  size <= 898 # number of pokemons
end
