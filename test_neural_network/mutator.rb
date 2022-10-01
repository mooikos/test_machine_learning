class Mutator
  CHARSET = ('a'..'z').to_a

  def add_layer(network:)
    while network_include_layer_name(network, new_name = random_name); end

    new_layer = { _name: new_name }

    network.insert(rand(network.length - 2) + 1, new_layer)
  end

  private

  def network_include_layer_name(network, name)
    network.find { |layer| layer[:_name] == name }
  end

  def random_name(length: 6)
    Array.new(length) { CHARSET.sample }.join
  end
end
