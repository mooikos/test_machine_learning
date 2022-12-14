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
          ai_inputs["r#{row_index}c#{column_index}".to_sym] = column.nil? ? 0.5 :
                                                              iteration.odd? ? column : 1 - column
        end
      end

      # ask the ai to calculate the scores
      ai_scores = of_turn[:brain].calculate_score(inputs: ai_inputs)

      # splits the scores
      rows = []
      columns = []
      ai_scores.each do |score|
        if score.first.start_with? 'r'
          rows << score
        else
          columns << score
        end
      end

      # create the combined scores
      ai_scores = []
      rows.each do |row|
        columns.each do |column|
          ai_scores << [[row[0][1].to_i, column[0][1].to_i], row[1] + column[1]]
        end
      end
      # sort them
      ai_scores.shuffle!.sort! { |score_a, score_b| score_a[1] <=> score_b[1] }
      # only map the moves
      moves = ai_scores.map { |ai_score| ai_score[0] }

      # find one the best usable
      available_moves = game.available_moves
      move = moves.find { |move| available_moves.include? move }

      # play it !
      game.make_move!(move:, value: of_turn[:value])

      # FIXME: consider checking the winner after moving
      return of_turn[:brain] if game.winner?(value: of_turn[:value])
    end

    # nobody wins
    nil
  end
end
