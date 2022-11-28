# frozen_string_literal: true

class NeuralNetwork
  class DifferentInputsError < StandardError; end

  LAYER_NAME_KEY = :_name

  # inputs and outputs need to be arrays of symbols
  def initialize(inputs: [:a, :b, :c], outputs: [:a, :b, :c])
    @network = new_initial_network(inputs:,  outputs:)
  end

  attr_reader :network

  def calculate_score(inputs:)
    unless (network[0].keys - [LAYER_NAME_KEY]) == inputs.keys
      raise DifferentInputsError, "the provided inputs\n:#{inputs}" \
                                  "\nare different from the network inputs\n:#{network[0]}"
    end

    layers_results = { in: inputs }
    # iterate on the layers
    network[1..-1].each do |layer|
      layers_results[layer[LAYER_NAME_KEY]] = {}
      # iterate on the neurons
      layer.each do |neuron_name, neuron_value|
        # skip the layer name
        next if neuron_name == LAYER_NAME_KEY

        if neuron_value.empty? # there are no referenced_layers
          neuron_result = 0.0
        else # iterate on the referenced layers
          connections_sum = 0.0
          connections = 0
          neuron_value.each do |referenced_layer_name, referenced_layer_value|
            # iterate the connections
            referenced_layer_value.each do |referenced_neuron_name, referenced_neuron_weight|
              connections_sum += referenced_neuron_weight * layers_results[referenced_layer_name][referenced_neuron_name]
              connections += 1
            end
          end
          neuron_result = connections_sum / connections
        end

        layers_results[layer[LAYER_NAME_KEY]][neuron_name] = neuron_result
      end
    end

    layers_results[:out]
  end

  private

  def new_initial_network(inputs:,  outputs:)
    network = []
    input_layer = { LAYER_NAME_KEY => :in }
    inputs.each { |input| input_layer[input] = nil }
    network << input_layer
    output_layer = { LAYER_NAME_KEY => :out }
    outputs.each { |output| output_layer[output] = {} }
    network << output_layer
  end
end
