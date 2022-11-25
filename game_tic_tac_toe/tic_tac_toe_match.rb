# frozen_string_literal: true

def TicTacToeMatch
  def initialize(player_1:, player_2:)
    @game = TicTacToeGame.new
    @player_1 = player_1
    @player_2 = player_2
  end

  attr_accessor :game, :player_1, :player_2

  def play!
    # returns winner ?
  end
end
