# frozen_string_literal: true

class GeneticAlgorithm
  attr_reader :environment, # the environment to "evolve" the entities
              :entity, # the entity that will "evolve"
              :population, :population_size, # population array and size
              :elitism, # the best N individuals are preserved for the next generation
              :parenting_population, # amount of NON ELITISM population that will generate childs
              :mutations_amount # amount of invocations of the mutations

  # parenting_population_ratio: ratio of NON ELITISM population that will generate childs
  #   eg: 10 population, 3 elitism, 0.5 ratio => (10 - 4) * 0.5 = 3
  def initialize(environment:, entity:, population_size:, elitism: 2, parenting_population_ratio: 0.5, mutations_amount: 1)
    @entity = entity
    @population_size = population_size
    @population = []
    population_size.times { population << entity.new }

    @elitism = elitism
    @parenting_population = (population_size * parenting_population_ratio).round

    @mutations_amount = mutations_amount
  end

  ### generation loop
  def simulate_generations(generations:)
    generations.times do |generation|
      # sort based on fitness
      environment.sort_by_fitness(population:)

      # fill with children (select parents + crossover)
      population[elitism..-1] = generate_children(population_size - elitism)

      # mutate new pop (0 to mutations_amount per gen, uniformly distributed)
      rand(mutations_amount + 1).times { mutate(population[rand(population_size)], rand(genoma_size)) }

      # conditional logging / debugging
      # ??
    end
  end
end
