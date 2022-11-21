# frozen_string_literal: true

# debugger
require 'pry-byebug'

# game
require_relative './game'

# ai
require_relative '../test_neural_network/neural_network'

# generate the instances
my_game = Game.new
inputs = { NeuralNetwork::LAYER_NAME_KEY => :in }
outputs = { NeuralNetwork::LAYER_NAME_KEY => :out }
(1..3).each do |row|
  outputs["r#{row}".to_sym] = {}
  outputs["c#{row}".to_sym] = {}
  (1..3).each do |column|
    inputs["r#{row}c#{column}".to_sym] = nil
  end
end
ai = NeuralNetwork.new(network: [inputs, outputs])

# connect to neural network
9.times do |iteration|
  value = iteration.odd? ? 1 : 0

  # translate to network language in correct values
  inputs = {}
  my_game.board.each_with_index do |row, row_index|
    row.each_with_index do |column, column_index|
      inputs["r#{row_index + 1}c#{column_index + 1}".to_sym] = column.nil? ? 0.5 : column
    end
  end
binding.pry

  # inquire what the move of the network would be
  ai_scores = ai.calculate_score(inputs:)

  # decide validity
  available_moves = my_game.available_moves

  move = nil

  # will need to decide what to move
  my_game.make_move(move:, value:)

  if my_game.winner?(previous_move: move, value:)
    puts "\n'#{value}' is the WINNER !!\n\n"
    my_game.board.each { |row| p row }
    puts "\nlast move: #{move}"
    break
  end
end
