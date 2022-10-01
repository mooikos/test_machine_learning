class NeuralNetwork
  def initialize(network: nil)
    @network = network || new_initial_network
  end

  attr_reader :network

  private

  def new_initial_network
    [
      { _name: :input, a: nil, b: nil },
      { a: {}, b: {} }
    ]
  end
end
