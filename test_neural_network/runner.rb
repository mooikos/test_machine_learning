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

3.times { mutator.add_layer(network: deep_copy) }
puts "added layers:"
puts deep_copy
puts ''

5.times { mutator.add_neuron(network: deep_copy) }
puts "added neurons:"
puts deep_copy
puts ''

10.times { mutator.add_connection(network: deep_copy) }
puts "added connections:"
puts deep_copy
puts ''

20.times { mutator.modify_connection_weight(network: deep_copy) }
puts "modified weights:"
puts deep_copy
puts ''

5.times { mutator.remove_connection(network: deep_copy) }
puts "removed connections:"
puts deep_copy
puts ''

# debug situation
binding.pry




p 'end'
