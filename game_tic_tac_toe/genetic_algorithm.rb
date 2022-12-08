# frozen_string_literal: true

class GeneticAlgorithm
  attr_reader :environment, # the environment to "evolve" the entities
              :entity, # the entity that will "evolve"
              :population, :population_size, # population array and size
              :elitism, # the best N individuals are preserved for the next generation
              :parenting_population, # amount of NON ELITISM population that will generate childs
              :mutator, # the class that will perform the mutations on the entity network
              :mutations_amount # amount of invocations of the mutations

  # parenting_population_ratio: ratio of NON ELITISM population that will generate childs
  #   eg: 10 population, 3 elitism, 0.5 ratio => (10 - 4) * 0.5 = 3
  def initialize(environment:, entity:, population_size:, elitism: 1, parenting_population_ratio: 0.5, mutator:, mutations_amount: 1)
    @environment = environment
    @entity = entity
    @population_size = population_size
    @population = Array.new(population_size) { entity.new }

    @elitism = elitism
    @parenting_population = (population_size * parenting_population_ratio).round

    @mutator = mutator
    @mutations_amount = mutations_amount
  end

  ### generation loop
  def simulate_generations!(generations:)
    generations.times do |generation|
      p "going to run generation n. #{generation} !!"
      # sort based on fitness
      environment.sort_by_fitness!(population:)

      # replace with children the non elite
      generate_children!
    end
  end

  private

  def generate_children!
    parents_amount = parenting_population - elitism
    population[elitism..-1] = population[elitism..-1].each_with_index.map do |_parent, index|
      child = population[(index + elitism) % parents_amount].clone
      mutator.mutate!(network: child.neural_network.network)
      child
    end
  end
end
