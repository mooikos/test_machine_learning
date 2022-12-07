# frozen_string_literal: true

# debugger
require "pry-byebug"

# genetic algorithm runner
require_relative "genetic_algorithm"

# neural network + mutator
require_relative "neural_network"
require_relative "mutator"

# tic tac toe classes
require_relative "game_environment"
require_relative "game"
require_relative "tic_tac_toe_game"
require_relative "tic_tac_toe_brain"
require_relative "tic_tac_toe_match"

# initialisations and start
GeneticAlgorithm.new(
  environment: GameEnvironment.new(match_class: TicTacToeMatch),
  entity: TicTacToeBrain,
  population_size: 10,
  mutator: Mutator.new
).simulate_generations(generations: 5)
