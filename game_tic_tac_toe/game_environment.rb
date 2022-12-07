# frozen_string_literal: true

# FIXME: clarify if it should extend an Environment
class GameEnvironment
  def initialize(match_class:)
    @match_class = match_class
  end

  attr_accessor :match_class

  def sort_by_fitness!(population:)
    population = population.map! { |brain| { brain => 0 } }

    population.each_with_index do |protagonist, protagonist_index|
      population[protagonist_index+1..-1].each do |challenger|
        # do 3 matches for each side
        3.times do
          winner = match_class.new(player_1: protagonist.keys.first, player_2: challenger.keys.first)
                              .play!
          if protagonist.keys.first == winner
            protagonist[protagonist.keys.first] += 1
          else
            challenger[challenger.keys.first] += 1
          end
          winner = match_class.new(player_1: challenger.keys.first, player_2: protagonist.keys.first)
                              .play!
          if protagonist.keys.first == winner
            protagonist[protagonist.keys.first] += 1
          else
            challenger[challenger.keys.first] += 1
          end
        end
      end
    end

    population.sort! { |brain_1, brain_2| brain_1.first.last <=> brain_2.first.last }
              .reverse!
    population.map! { |brain| brain.keys.first }
  end
end
