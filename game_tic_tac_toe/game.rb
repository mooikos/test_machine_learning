# frozen_string_literal: true

class Game
  class IllegalMoveError < StandardError; end

  def initialize(rows_amount: 3, columns_amount: 3, winner_amount: 3)
    @rows_amount = rows_amount
    @columns_amount = columns_amount
    @board = Array.new(rows_amount) {Array.new(columns_amount)}
    @winner_amount = 3
  end

  attr_accessor :rows_amount, :columns_amount, :board, :winner_amount

  def available_moves
    moves = []
    board.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        moves << [row_index, column_index] unless column
      end
    end
    moves
  end

  def make_move(move:, value:)
    if board[move[0]][move[1]]
      raise IllegalMoveError, "it is not possible to move in #{move}"
    else
      board[move[0]][move[1]] = value
    end
  end

  def winner?(previous_move:, value:)
    winner_up_down?(row: previous_move[0], column: previous_move[1], value:) ||
    winner_down_left_up_right?(row: previous_move[0], column: previous_move[1], value:) ||
    winner_left_rigth?(row: previous_move[0], column: previous_move[1], value:) ||
    winner_up_left_down_right?(row: previous_move[0], column: previous_move[1], value:) ||
    false
  end

  private

  def winner_up_down?(row:, column:, value:)
    amount = 1
    row_copy = row
    while (row_copy += 1) < rows_amount && board[row_copy][column] == value
      amount += 1
      return true if amount == winner_amount
    end
    while (row -= 1) > -1 && board[row][column] == value
      amount += 1
      return true if amount == winner_amount
    end
  end

  def winner_down_left_up_right?(row:, column:, value:)
    amount = 1
    row_copy = row
    column_copy = column
    while (row_copy += 1) < rows_amount && (column_copy += 1) < columns_amount && board[row_copy][column_copy] == value
      amount += 1
      return true if amount == winner_amount
    end
    while (row -= 1) > -1 && (column -= 1) > -1 && board[row][column] == value
      amount += 1
      return true if amount == winner_amount
    end
  end

  def winner_left_rigth?(row:, column:, value:)
    amount = 1
    column_copy = column
    while (column_copy += 1) < columns_amount && board[row][column_copy] == value
      amount += 1
      return true if amount == winner_amount
    end
    while (column -= 1) > -1 && board[row][column] == value
      amount += 1
      return true if amount == winner_amount
    end
  end

  def winner_up_left_down_right?(row:, column:, value:)
    amount = 1
    row_copy = row
    column_copy = column
    while (row_copy -= 1) > -1 && (column_copy += 1) < columns_amount && board[row_copy][column_copy] == value
      amount += 1
      return true if amount == winner_amount
    end
    while (row += 1) < rows_amount && (column -= 1) > -1 && board[row][column] == value
      amount += 1
      return true if amount == winner_amount
    end
  end
end
