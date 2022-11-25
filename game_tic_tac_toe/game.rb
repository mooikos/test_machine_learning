# frozen_string_literal: true

class Game
  class NotImplementedError < StandardError
    def initialize
      super "the interface method has not been implemented"
    end
  end

  # returns a list of possible moves
  def available_moves
    raise NotImplementedError
  end

  # performs a move
  # def make_move!(move:, value:)
  #   raise NotImplementedError
  # end

  # returns if someone one
  # def winner?(value:)
  #   raise NotImplementedError
  # end
end
