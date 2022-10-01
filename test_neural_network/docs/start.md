# start

start and end of each step of the fitness evaluation
```
{ _name: :input, a: 1, b: 2 },
{ a: {}, b: {} }
```

starting neural network
```
{ _name: :input, a: nil, b: nil },
{ a: {}, b: {} }
```

step evaluation
- for each layer in order
  - calculate the layer next layer inputs based on the previous layer inputs
    - `layer_plus_1_neuron_x_input_a = (weight_a + weight_b) / n_weights`
- at the end of the iteration calculate the final outputs based on the final layer
