class Grid
  def initialize
    @board = create_board
  end

  def create_board
    empty_cell = '◯'
    player_red = ['r1', 'r2', 'r3', 'r4']
    player_green = ['g1', 'g2', 'g3', 'g4']
    player_yellow = ['y1', 'y2', 'y3', 'y4']
    player_blue = ['b1', 'b2', 'b3', 'b4']
    #player_cells = ['R', 'G', 'Y', 'B']
    safehouse_cell = '●'
    start_cell = '*'
    nil_cell = nil

    board = Array.new(21) { Array.new(21, ' ') }

    # Initialize start positions for each player
    board[8][0] = start_cell
    board[20][8] = start_cell
    board[12][20] = start_cell
    board[0][12] = start_cell

    # red player
    #[18].each { |row| [18,20].each { |col| board[row][col] = player_red[0,1] } }
    #[20].each { |row| [18,20].each { |col| board[row][col] = player_red[2,3] } }
    [18, 20].each { |row| [18,20].each { |col| board[row][col] = player_red.shift } }

    # green player
    [0, 2].each { |row| [18,20].each { |col| board[row][col] = player_green.shift } }

    # blue player
    [18, 20].each { |row| [0,2].each { |col| board[row][col] = player_blue.shift } }

    # yellow player
    [0,2].each { |row| [0,2].each { |col| board[row][col] = player_yellow.shift } }


    # Initialize start positions for each player
    board[8][0] = start_cell
    board[20][8] = start_cell
    board[12][20] = start_cell
    board[0][12] = start_cell

    # Initialize safehouses for each player
    #red
    [10].each { |row| [12, 14, 16, 18].each { |col| board[row][col] = safehouse_cell } }

    #yellow
    [10].each { |row| [2, 4, 6, 8].each { |col| board[row][col] = safehouse_cell } }

    #green
    [2, 4, 6, 8].each { |row| [10].each { |col| board[row][col] = safehouse_cell } }

    #blue
    [12, 14, 16, 18].each { |row| [10].each { |col| board[row][col] = safehouse_cell } }


    # Set specified cells to empty_cells

    [8].each { |row| [0, 2, 4, 6, 8].each { |col| board[row][col] = empty_cell } }
    [6, 4, 2, 0].each { |row| [8].each { |col| board[row][col] = empty_cell } }
    [0].each { |row| [10, 12].each { |col| board[row][col] = empty_cell } }
    [2, 4, 6, 8].each { |row| [12].each { |col| board[row][col] = empty_cell } }
    [8].each { |row| [14, 16, 18, 20].each { |col| board[row][col] = empty_cell } }
    [10, 12].each { |row| [20].each { |col| board[row][col] = empty_cell } }
    [12].each { |row| [12, 14, 16, 18].each { |col| board[row][col] = empty_cell } }
    [14, 16, 18, 20].each { |row| [12].each { |col| board[row][col] = empty_cell } }
    [20].each { |row| [8, 10].each { |col| board[row][col] = empty_cell } }
    [12, 14, 16, 18].each { |row| [8].each { |col| board[row][col] = empty_cell } }
    [12].each { |row| [0, 2, 4, 6].each { |col| board[row][col] = empty_cell } }
    [10].each { |row| [0].each { |col| board[row][col] = empty_cell } }


    return board
  end

  def display_board
    system 'clear' # Clear the console for a clean display (works on Unix-like systems)

    @board.each do |row|
      puts row.map { |cell| cell.nil? ? '' : cell }.join(' ')
    end
  end
end

# Example usage
ludo_board = Grid.new
ludo_board.display_board