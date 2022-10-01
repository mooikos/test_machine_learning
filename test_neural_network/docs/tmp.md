```
[
  {
    _name: :input, # this is the layer name
    a: 0.1, # this is one of the inputs
    b: 0.2
  },
  {
    _name: :a,
    a: { # this is the neuron name
      input: { # this is the layer name where the weights hash points
        a: 0.5, # this is the ouput to point to + weight
        b: 0.3
      }
    },
    b: {
      input: {
        a: 0.7,
        b: 0.5
      }
    }
  },
  {
    a: { # this is one of the outputs
      a: {
        a: 0.5,
        b: 0.3
      }
    },
    b: {
      a: {
        a: 0.7,
        b: 0.5
      }
    }
  }
]

layer_1
  a (0.5*0.1 + 0.3*0.2) / 2 = 0.11 / 2 = 0.055
  b (0.7*0.1 + 0.5*0.2) / 2 = 0.17 / 2 = 0.085
```
