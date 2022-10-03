class NeuralNetwork
  class DifferentInputsError < StandardError; end

  LAYER_NAME_KEY = :_name

  def initialize(network: nil)
    @network = network || default_new_initial_network
  end

  attr_reader :network

  def calculate_score(input:)
    unless (network[0].keys - [LAYER_NAME_KEY]) == input.keys
      raise DifferentInputsError, "the provided inputs\n:#{input}" \
                                  "are different from the network inputs\n:#{}"
    end

    layers_results = { in: input }
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

  def default_new_initial_network
    [
      { LAYER_NAME_KEY => :in, a: nil, b: nil },
      { LAYER_NAME_KEY => :out, a: {}, b: {} }
    ]
  end
end
