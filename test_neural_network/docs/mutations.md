# mutations

add 1 layer
- randomize the name
  - must be unique
```
[
  { _name: :input, a: nil, b: nil },
  { a: {}, b: {} }
]

[
  { _name: :input, a: nil, b: nil },
  { _name: :a },
  { a: {}, b: {} }
]
```

add 1 neuron
  - randomize the layer position
  - randomize the name
    - must be unique
```
[
  { _name: :input, a: nil, b: nil },
  { _name: :a },
  { a: {}, b: {} }
]

[
  { _name: :input, a: nil, b: nil },
  { _name: :a, a: {} },
  { a: {}, b: {} }
]
```


add 1 weight from 1 neuron to a neuron of a previous layer
- randomize the layer
- randomize the neuron
- randomize the target layer
- randomize the target neuron
- randomize the weight
```
[
  { _name: :input, a: nil, b: nil },
  { a: {}, b: {} }
]

[
  { _name: :input, a: nil, b: nil },
  { a: { input: { a: 0.5 } }, b: {} }
]
```

modify 1 weight value
- randomize the layer
- randomize the neuron
- randomize the target layer
- randomize the target neuron
- randomize the weight
- randomize amount of + / -
- randomize it to be a reasonable change
```
[
  { _name: :input, a: nil, b: nil },
  { a: { input: { a: 0.5 } }, b: {} }
]

[
  { _name: :input, a: nil, b: nil },
  { a: { input: { a: 0.7 } }, b: {} }
]
```

remove 1 weight
- randomize the layer
- randomize the neuron
- if neuron has target_layers
  - randomize the target layer
  - randomize the weight
  - remove the weight
  - if last weight
    - remove the target layer
```
[
  { _name: :input, a: nil, b: nil },
  { _name: :a, a: { input: { a: 0.5 } } },
  { a: {}, b: {} }
]

[
  { _name: :input, a: nil, b: nil },
  { _name: :a, a: {} },
  { a: {}, b: {} }
]
```

remove 1 neuron
- randomize the layer
- randomize the neuron
- iterate through next layers
  - iterate through neurons
    - if to be deleted layer
      - if to be deleted neuron
        - remove weight
        - if last weight
          - remove the target layer
```
[
  { _name: :input, a: nil, b: nil },
  { _name: :a, a: { input: { a: 0.5 } } },
  { a: { a: { a: 0.5 } }, b: {} }
]

[
  { _name: :input, a: nil, b: nil },
  { _name: :a },
  { a: {}, b: {} }
]
```

remove 1 layer
- randomize the layer
- iterate through next layers
  - iterate through neurons
    - if to be deleted layer
      - remove the layer
```
[
  { _name: :input, a: nil, b: nil },
  { _name: :a, a: { input: { a: 0.5 } } },
  { a: { a: { a: 0.5 } }, b: {} }
]

[
  { _name: :input, a: nil, b: nil },
  { a: {}, b: {} }
]
```
