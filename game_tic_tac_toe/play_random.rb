# frozen_string_literal: true

# debugger
require 'pry-byebug'

# game
require_relative './game'

my_game = Game.new

# random challenge
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
