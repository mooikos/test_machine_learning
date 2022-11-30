# frozen_string_literal: true

class TicTacToeMatch
  def initialize(player_1:, player_2:)
    @game = TicTacToeGame.new
    @player_1 = { value: 0, brain: player_1 }
    @player_2 = { value: 1, brain: player_2 }
  end

  attr_accessor :game, :player_1, :player_2

  def play!
    9.times do |iteration|
      of_turn = iteration.odd? ? player_2 : player_1

      # map the game representation "my_game.board" to the inputs for the ai
      ai_inputs = {}
      game.board.each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          ai_inputs["r#{row_index}c#{column_index}".to_sym] = column.nil? ? 0.5 : column
        end
      end
binding.pry
      # ask the ai to calculate the scores
      ai_scores = of_turn.calculate_score(inputs: ai_inputs)

      # select the best row and column score
      best_row_score = 0
      best_rows = []
      best_column_score = 0
      best_columns = []
      ai_scores.each_pair do |output, score|
        if output.start_with? "r"
          if score > best_row_score
            best_row_score = score
            best_rows = [{ output => score }]
          elsif score == best_row_score
            best_rows << { output => score }
          end
        else
          if score > best_column_score
            best_column_score = score
            best_columns = [{ output => score }]
          elsif score == best_column_score
            best_columns << { output => score }
          end
        end
      end

      # will pick the first
      move = [best_rows.first, best_columns.first]
      game.make_move(move:, value:)

      # FIXME: consider checking the winner after moving
      if game.winner?(previous_move: move, value:)
        puts "\n'#{value}' is the WINNER !!\n\n"
        game.board.each { |row| p row }
        puts "\nlast move: #{move}"
        break
      end
    end

    # returns winner or 0 ??
  end
end
