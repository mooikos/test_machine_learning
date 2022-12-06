# frozen_string_literal: true

class TicTacToeBrain
  # FIXME: improve creation of brains ?
  def initialize(rows: 3, columns: 3)
    inputs = []
    outputs = []
    rows.times do |row|
      outputs << "r#{row}".to_sym
      outputs << "c#{row}".to_sym
      columns.times do |column|
        inputs << "r#{row}c#{column}".to_sym
      end
    end
    @neural_network = NeuralNetwork.new(inputs:, outputs:)
  end

  attr_reader :neural_network

  def calculate_score(inputs:)
    neural_network.calculate_score(inputs:)
  end
end
