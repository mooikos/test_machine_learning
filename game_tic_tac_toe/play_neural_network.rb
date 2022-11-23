# frozen_string_literal: true

# debugger
require 'pry-byebug'

# game
require_relative './game'

# ai
require_relative '../test_neural_network/neural_network'


### TODOS
# - create a general "script" for GA based on "test_simple_ga" to:
#   - make the "thing" based on dependency injection of fitness based on "number"
#   - extract class to own file
#   - make the functions: "sort_pop_by_fit" to invoke some external fitness evaluator on the population



# generate the instances
my_game = Game.new
inputs = { NeuralNetwork::LAYER_NAME_KEY => :in }
outputs = { NeuralNetwork::LAYER_NAME_KEY => :out }
3.times do |row|
  outputs["r#{row}".to_sym] = {}
  outputs["c#{row}".to_sym] = {}
  3.times do |column|
    inputs["r#{row}c#{column}".to_sym] = nil
  end
end
ai = NeuralNetwork.new(network: [inputs, outputs])

# connect to neural network
9.times do |iteration|
  value = iteration.odd? ? 1 : 0

  # map the game representation "my_game.board" to the inputs for the ai
  ai_inputs = {}
  my_game.board.each_with_index do |row, row_index|
    row.each_with_index do |column, column_index|
      ai_inputs["r#{row_index}c#{column_index}".to_sym] = column.nil? ? 0.5 : column
    end
  end

  # ask the ai to calculate the scores
  ai_scores = ai.calculate_score(inputs: ai_inputs)

  # assign the ai_scores to the available_moves
  available_moves = my_game.available_moves
  available_moves.map! do |available_move|
    {
      move: available_move,
      score: ai_scores["r#{available_move[0]}".to_sym] + ai_scores["c#{available_move[1]}".to_sym]
    }
  end

  # sort by score
  available_moves.sort! do |move_a, move_b|
    move_a[:score] <=> move_b[:score]
  end

  # will pick the first
  my_game.make_move(move: available_moves.first, value:)

  if my_game.winner?(previous_move: move, value:)
    puts "\n'#{value}' is the WINNER !!\n\n"
    my_game.board.each { |row| p row }
    puts "\nlast move: #{move}"
    break
  end
end
