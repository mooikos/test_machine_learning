# debugger
require 'pry-byebug'

# neural network class
require_relative 'neural_network'
# mutator class
require_relative 'mutator'

# run
original_network = NeuralNetwork.new
mutator = Mutator.new

deep_copy = Marshal.load(Marshal.dump original_network.network)

mutator.add_layer(network: deep_copy)

# debug situation
binding.pry

p 'end'
