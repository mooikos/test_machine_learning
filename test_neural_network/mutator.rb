class Mutator
  LAYER_NAME_KEY = :_name
  CHARSET = ('a'..'z').to_a
  MAX_WEIGHT = 100000.0

  DEFAULT_NAMES_LENGTH = 6
  DEFAULT_LIMIT_LAYERS = 10
  DEFAULT_LIMIT_NEURONS = 10
  DEFAULT_WEIGHT_VARIANCE = 2

  def initialize(names_length: DEFAULT_NAMES_LENGTH, limit_layers: DEFAULT_LIMIT_LAYERS,
                 limit_neurons: DEFAULT_LIMIT_NEURONS, limit_weight: DEFAULT_WEIGHT_VARIANCE)
    # length of the keys related to objects
    @names_length = names_length
    # limits the amount of internal layers of the network
    @limit_layers = limit_layers + 2 # include input and output
    # limit the amount of neurons of the layers
    @limit_neurons = limit_neurons + 1 # include "_name" key
  end

  attr_reader :names_length, :limit_layers, :limit_neurons

  def add_layer(network:)
    # do not pass the layers limit
    return unless network.length <= limit_layers

    # generate a new unique layer name
    while network_includes_layer_name?(network, new_name = random_name); end

    # create the new layer
    new_layer = { _name: new_name }

    # add the new layer in a random position
    network.insert(rand(network.length - 2) + 1, new_layer)
  end

  def add_neuron(network:)
    # do not add neurons to input or output layers
    return if network.length <= 2

    # randomize a layer
    target_layer = network[rand(network.length - 2) + 1]

    # do not pass the neurons limit
    return unless target_layer.length <= limit_neurons

    # generate a new unique neuron name
    while layer_includes_neuron_name?(target_layer, new_name = random_name); end

    # add the new neuron
    target_layer[new_name] = {}
  end

  def add_connection(network:)
    # randomize a layer
    target_layer_index = rand(network.length - 1) + 1
    target_layer = network[target_layer_index]

    # return if the layer has no neurons
    return if target_layer[LAYER_NAME_KEY] && target_layer.length <= 1

    # randomize a neuron
    target_neuron = target_layer[(target_layer.keys - [LAYER_NAME_KEY]).sample]

    # randomize the referenced layer
    referenced_layer = network[rand(target_layer_index)]

    # return if all of the target layer neurons have already a connection
    referenced_neurons = target_neuron[referenced_layer[LAYER_NAME_KEY]]
    return if referenced_neurons && (referenced_neurons.length == referenced_layer.length - 1)

    # create the referenced layer if did not existed
    referenced_neurons = target_neuron[referenced_layer[LAYER_NAME_KEY]] = {} unless referenced_neurons

    # randomize a referenced neuron
    referenced_neuron = (referenced_layer.keys - [LAYER_NAME_KEY] - referenced_neurons.keys).sample

    # add the weight
    referenced_neurons[referenced_neuron] = random_weight
  end

  def modify_connection_weight(network:)
    # randomize a layer
    target_layer = network[rand(network.length - 1) + 1]

    # return if the layer has no neurons
    return if target_layer[LAYER_NAME_KEY] && target_layer.length <= 1

    # randomize a neuron
    target_neuron = target_layer[(target_layer.keys - [LAYER_NAME_KEY]).sample]

    # return if empty neuron referenced layers
    return if target_neuron.empty?

    # randomize the referenced layer
    referenced_layer = target_neuron[target_neuron.keys.sample]

    # modify a random connection
    target_connection = referenced_layer.keys.sample
    referenced_layer[target_connection] = random_modified_weight(referenced_layer[target_connection])
  end

  def remove_connection(network:)
    # randomize a layer
    target_layer = network[rand(network.length - 1) + 1]

    # return if the layer has no neurons
    return if target_layer[LAYER_NAME_KEY] && target_layer.length <= 1

    # randomize a neuron
    target_neuron = target_layer[(target_layer.keys - [LAYER_NAME_KEY]).sample]

    # return if empty neuron referenced layers
    return if target_neuron.empty?

    # randomize the referenced layer
    referenced_layer_key = target_neuron.keys.sample
    referenced_layer = target_neuron[referenced_layer_key]

    # remove the referenced layer if there is only 1 connection
    if referenced_layer.length <= 1
      target_neuron.delete(referenced_layer_key)
    else # remove a random connection
      target_connection = referenced_layer.keys.sample
      referenced_layer.delete(target_connection)
    end
  end

  private

  def network_includes_layer_name?(network, name)
    network.find { |layer| layer[LAYER_NAME_KEY] == name }
  end

  def layer_includes_neuron_name?(layer, name)
    layer.has_key? name
  end

  def random_name(length = names_length)
    Array.new(length) { CHARSET.sample }.join.to_sym
  end

  def random_weight
    rand(0)
  end

  def random_modified_weight(weight)
    new_weight = rand(0) * DEFAULT_WEIGHT_VARIANCE * weight
    new_weight > MAX_WEIGHT ? MAX_WEIGHT : new_weight
  end
end
