# frozen_string_literal: true

# debugger
require 'pry-byebug'

class GeneticAlgorithm
  attr_reader :population, :population_size, # population
              :genoma_size, # genoma
              :elitism, :mutations_amount, :parenting_population_ratio, # evolution
              :print_every # visualization

  # population_size: the population to have at each iteration
  # genoma_size: genoma of the individuals (example as array of binary)
  # elitism: the best N individuals are preserved to next generation
  def initialize(population_size:, genoma_size:, elitism: 0, mutations_amount: 1, parenting_population_ratio: 0.5, print_every: false)
    @population_size = population_size
    @elitism = elitism

    @genoma_size = genoma_size

    @mutations_amount = mutations_amount
    @parenting_population = (population_size * parenting_population_ratio).round

    @print_every = print_every

    @population = init_pop
  end

  ### population initialization
  def init_pop
    (1..population_size).map { (1..genoma_size).map { random_gene  } }
  end

  def random_gene
    rand 2 # binary genotype
  end
  ###


  ### generation loop
  def simulate_generations(generations:)
    generations.times do |ngen|
      # sort based on fitness
      sort_pop_by_fit

      # fill with children (select parents + crossover)
      population[elitism..-1] = generate_children(population_size - elitism)

      # mutate new pop (0 to mutations_amount per gen, uniformly distributed)
      rand(mutations_amount + 1).times { mutate(population[rand(population_size)], rand(genoma_size)) }

      # conditional printing (avoid spam)
      if print_every && (ngen.zero? || ((ngen + 1) % print_every).zero?)
        puts "Generation #{ngen+1}\n#{self}"
      end
    end
  end
  ###


  ### fitness evaluation
  def sort_pop_by_fit
    population.sort_by! { |gen| -fitness(gen) } # "-" for descending order
  end

  def fitness(genotype)
    genotype.sum # simple sum
  end
  ###


  ### create new population
  def generate_children(nchildren)
    (1..nchildren).map do
      crossover(select_parents)
    end
  end

  def select_parents
    p1 = select_parent
    p2 = select_parent

    while p1.__id__ == p2.__id__ do
      p2 = select_parent
    end

    [p1, p2]
  end

  def select_parent
    population[rand(parenting_population)]
  end

  def crossover(parents)
    parents_amount = parents.length

    (0..genoma_size - 1).map do |gene_index|
      parents[rand(parents_amount)][gene_index]
    end
  end
  ###


  ### mutate
  def mutate(individual, gene)
    individual[gene] = mutate_gene(individual[gene])
  end

  def mutate_gene(g)
    1 - g # invert bit
  end
  ###


  ### visualization
  def to_s
    population.each_with_index.collect do |g, i|
      "#{format("%2d", i+1)}: #{g} => #{fitness g}"
    end.join("\n")
  end
  ###
end

ga = GeneticAlgorithm.new(
  population_size: 6, genoma_size: 25,
  elitism: 4, mutations_amount: 1, parenting_population_ratio: 0.8,
  print_every: 20
)
# You should see the population converging towards all individuals made of ones
ga.simulate_generations(generations: 1000)
