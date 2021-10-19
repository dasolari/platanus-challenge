### Gems Used
- [colorize](https://github.com/fazibear/colorize) for console printing in colors.
- [httparty](https://github.com/jnunemaker/httparty) for making http requests.
- [rake](https://github.com/ruby/rake) for running scripts with the rake command.
- [recursive-open-struct](https://github.com/aetherknight/recursive-open-struct) for handling API responses in a more friendly way (allowing dot notation).
- [rubocop](https://github.com/rubocop/rubocop) for static code analysis and formatting.
- [strings-case](https://github.com/piotrmurach/strings-case) for converting _kebab case_ API responses into _snake case_.
- [terminal-table](https://github.com/tj/terminal-table) for printing in a table like way the current participating Pokemons.


### Considerations
- All the code is located in the `lib` directory.
- The game was slowed down using the `sleep` function to allow a more friendly experience and enjoy every moment of the tournament.
- There will be a 1 in 3 chance of doing a special attack for every Pokemon.
- There is an equal chance of attacking with any one of the Pokemon's own types, but only one is used per attack.
- When a Pokemon does a special attack, the defender Pokemon does a special defense.
- Phisical attacks do not get incremented/decremented by any factor given the attacker or defender's type(s), meanwhile, special attacks __do__.
- There is a small chance that two battling Pokemons enter in a __deadlock__, where none can hurt the other. When this happens, a counter allows up 20 deadlock turns, and if no Pokemon loses `hp`, they both get their `defense` reduced by 25% to keep the odds even and finish the match quicker.
- For every match, the following attributes where considered for deciding the outcome of the fight:
  - `hp`
  - `attack` (phisical)
  - `defense` (phisical)
  - `special_attack`
  - `special_defense`
  - `speed`
  - `types` (own and oppenent's are considered when fighting)
- The `speed` of the Pokemon determines who attacks first in a match.

### Architecture
- The console logs and prints where abstracted and separated from the business logic of the program in a pseudo-mvc  architecture.
- The Singleton design pattern was used for instantiating the same object of the `View` class in every part it was needed.
- The Decorator design pattern was used for decorating the `play` method with some console prints, present in many classes.

### Commands
To install the dependencies, run this command (you should have the latest version of ruby installed):
```rb
bundle install
```
Once the dependencies are installed, to play the tournament, run the following command:

```rb
rake
```

### Inputs
In the `main.rb` file you can change the starting inputs if you want to try running a bigger tournament or selecting from a bigger pool of Pokemons.

### Interface
There is not really a user interface in this program, everything is shown through console prints. You will know the state of the tournament in every moment thanks to these console prints. To make them more user friendly and easier to distinguish, some statements were given certain colors, here is a list:
- Red: represents an attack by a Pokemon to another.
- Blue: represents a defensive move by a Pokemon.
- Green: represents a match win by a Pokemon.
- Cyan: represents the defeat of a Pokemon at the end of a match.
- Yellow: represents the winner of the tournament.
