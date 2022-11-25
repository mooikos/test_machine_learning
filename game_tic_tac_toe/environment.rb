# frozen_string_literal: true

# FIXME: clarify if it should extend an Environment
class GameEnvironment
  def initialize(game:)
    @game = game
  end

  attr_accessor :game

  def sort_by_fitness(population:)
    population.each_with_index do |protagonist, protagonist_index|
      population[protagonist_index..-1].each do |challenger|
        TicTacToeMatch.new(player_1: protagonist, player_2: challenger).play!

      end
    end
  end
end
