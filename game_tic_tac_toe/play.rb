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
genetic_algorithm = GeneticAlgorithm.new(
  environment: GameEnvironment.new(match_class: TicTacToeMatch),
  entity: TicTacToeBrain,
  population_size: 100,
  mutator: Mutator.new
)
genetic_algorithm.simulate_generations!(generations: 50)

binding.pry

p "THE END !!"
