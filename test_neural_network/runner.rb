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

# for output formatting
require 'json'

3.times { mutator.add_layer(network: deep_copy) }
puts "added layers:"
puts deep_copy
puts ''

10.times { mutator.add_neuron(network: deep_copy) }
puts "added neurons:"
puts deep_copy
puts ''

20.times { mutator.add_connection(network: deep_copy) }
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
# puts JSON.pretty_generate(deep_copy)
puts ''

# 2.times { mutator.remove_neuron(network: deep_copy) }
# puts "removed neurons:"
# puts deep_copy
# puts JSON.pretty_generate(deep_copy)
# puts ''

# 3.times { mutator.remove_layer(network: deep_copy) }
# puts "removed layers:"
# puts deep_copy
# puts ''

puts "got result:"
puts NeuralNetwork.new(network: deep_copy).calculate_score(input: { a: 1, b: 2 })

# debug situation
# binding.pry

p 'end'
