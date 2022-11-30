# frozen_string_literal: true

class TicTacToeBrain
  def initialize
    inputs = { NeuralNetwork::LAYER_NAME_KEY => :in }
    outputs = { NeuralNetwork::LAYER_NAME_KEY => :out }
    3.times do |row|
      outputs["r#{row}".to_sym] = {}
      outputs["c#{row}".to_sym] = {}
      3.times do |column|
        inputs["r#{row}c#{column}".to_sym] = nil
      end
    end
    @neural_network = NeuralNetwork.new(inputs:, outputs:)
  end

  attr_reader :neural_network
end
