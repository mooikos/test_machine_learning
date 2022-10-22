# frozen_string_literal: true

# debugger
require 'pry-byebug'

# game
require_relative './game'

my_game = Game.new

9.times do |iteration|
  value = iteration.odd? ? 1 : 0
  move = my_game.available_moves.shuffle.first
  my_game.make_move(move:, value:)

  if my_game.winner?(previous_move: move, value:)
    puts "'#{value}' is the WINNER !!\n\n"
    my_game.board.each { |row| p row }
    puts "\nlast move: #{move}"
    break
  end
end

binding.pry

# FIXME: need to understand why sometimes it fails
my_game.winner?(previous_move: [0, 0], value: 0)

p 'the end'
