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
  population_size: 20,
  mutator: Mutator.new
)
genetic_algorithm.simulate_generations!(generations: 100)

binding.pry

# check manualy prowess
latest_best_brain = genetic_algorithm.population.first
ai_inputs = {
  r0c0: 0.5, r0c1: 0.5, r0c2: 0.5,
  r1c0: 0.5, r1c1: 0.5, r1c2: 0.5,
  r2c0: 0.5, r2c1: 0.5, r2c2: 0.5,
}
latest_best_brain.calculate_score(inputs: ai_inputs).sort


p "THE END !!"
