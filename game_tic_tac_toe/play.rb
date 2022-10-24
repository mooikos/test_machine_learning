# frozen_string_literal: true

# debugger
require 'pry-byebug'

# game
require_relative './game'

## interfaces
# game creation: initialize
# get game moves: available_moves
# make move: make_move
# check winner: winner?

my_game = Game.new

9.times do |iteration|
  value = iteration.odd? ? 1 : 0
  move = my_game.available_moves.shuffle.first
  my_game.make_move(move:, value:)

  if my_game.winner?(previous_move: move, value:)
    puts "\n'#{value}' is the WINNER !!\n\n"
    my_game.board.each { |row| p row }
    puts "\nlast move: #{move}"
    break
  end
end
