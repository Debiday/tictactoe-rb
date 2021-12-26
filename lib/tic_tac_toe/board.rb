module TicTacToe
  class Board
    attr_reader :grid

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end

    # query board object for value at a given (x, y)
    def get_cell(x, y)
      grid[y][x]
    end

    # dependency
    def set_cell(x, y, value)
      get_cell(x, y).value = value
    end

    def game_over
      return :winner if winner?
      return :draw if draw?

      false
    end

    def formatted_grid
      grid.each do |row|
        puts row.map { |cell| cell.value.empty? ? '_' : cell.value }.join(' ')
      end
    end

    private

    def default_grid
      Array.new(3) { Array.new(3) { Cell.new } }
    end

    def draw?
      grid.flatten.map { |cell| cell.value }.none_empty?
    end

    # define method thatp returns an array of the 8 possible winning positions
    def winning_positions
      grid +
        grid.transpose +
        diagonals
    end

    def diagonals
      [
        [get_cell(0, 0), get_cell(1, 1), get_cell(2, 2)],
        [get_cell(0, 2), get_cell(1, 1), get_cell(2, 0)]
      ]
    end

    def winning_position_values(winning_position)
      winning_position.map { |cell| cell.value }
    end

    def winner?
      winning_positions.each do |winning_position|
        # return false if the winning positions are not filled yet
        next if winning_position_values(winning_position).all_empty?
        return true if winning_position_values(winning_position).all_same?
      end
      false
    end
  end
end
