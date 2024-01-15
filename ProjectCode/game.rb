# frozen_string_literal: true
require_relative 'grid'
require_relative 'player'
require_relative 'die'



class Game
  attr_accessor :players, :current_player, :dice, :board, :grid

  def initialize (players)
    @grid = Grid.new
    @board = @grid.board
    @players = players
    @game_started = false
    @current_player = @players[0]
    @dice = Die.new

  end

  def play_turn
    rolls_left = @current_player.rolled_six? ? 1 : 3

    rolls_left.times do
      puts "#{@current_player.color}'s turn. Press Enter to roll the dice."
      loop { break if STDIN.gets.chomp.empty? }

      roll = dice.roll
      puts "#{@current_player.color} rolled: #{roll}"

      if roll == 6
        puts "Player #{@current_player.color} got a 6! They start the game."
        start_game(roll)
        @current_player.roll_six
        return
      end
    end

    unless @current_player.rolled_six?
      puts "Player #{@current_player.color} did not roll a 6 in three attempts. Turn skipped."
      switch_turn
      return
    end

    return if @current_player.pieces.nil? || @current_player.pieces.empty?

    piece = @current_player.pieces.first
    piece_position = @grid.find_piece_position(piece)
    puts "Piece to move: #{piece}"
    puts "Piece position: #{piece_position}"

    if piece_position.nil?
      puts "Error: Piece not found on the board for #{@current_player.color}'s turn."
      return
    end

    move_piece(dice.roll) if @game_started

    switch_turn

  end




  def start_game(roll)
    pieces = @current_player.pieces

    if pieces.nil? || pieces.empty?
      puts "No pieces left for #{@current_player.color}. Turn skipped."
      switch_turn
      return
    end

    piece = pieces.first
    piece_position = @grid.find_piece_position(piece)
    puts "Piece to move: #{piece}"
    puts "Piece position: #{piece_position}"

    if piece_position.nil?
      puts "Error: Piece not found on the board for #{@current_player.color}'s turn."
      return
    end

    move_piece(roll)


    switch_turn


  end

  def find_start_position(color)

    case color
    when 'r' then [8, 0]
    when 'g' then [20, 8]
    when 'y' then [12, 20]
    when 'b' then [0, 12]
    else [0, 0]
    end
  end


  def move_piece(roll)
    pieces = current_player.pieces

    if pieces.nil? || pieces.empty?
      puts "Error: No pieces left for #{current_player.color}'s turn."
      return
    end

    piece_to_move = pieces.first

    current_position = @grid.find_piece_position(piece_to_move)
    if current_position.nil?
      puts "Error: Piece not found on the board for #{current_player.color}'s turn."
      return
    end

    new_position = calculate_new_position(current_position, roll)

    puts "New position: #{new_position}"

    unless valid_position?(new_position)
      puts "Error: Invalid position on the board."
      return
    end

    handle_collisions(new_position)
    move_piece_to_new_position(piece_to_move, new_position)
    enter_safehouse if new_position == safehouse_position
    switch_turn unless roll == 6
  end

  def calculate_new_position(current_position, roll)
    return nil unless current_position && roll

    row, col = current_position
    new_col = (col + roll) % @grid.size
    new_row = (row + (col + roll) / @grid.size) % @grid.size
    [new_row, new_col]
  end



  def move_piece_to_new_position(piece, new_position)
    new_row, new_col = new_position

    if valid_position?(new_position)
      # Clear the old position
      current_position = @grid.find_piece_position(piece)
      current_row, current_col = current_position
      @grid[current_row, current_col] = nil

      # Update the new position
      @grid[new_row, new_col] = piece
    else
      puts "Error: Invalid position on the board."
    end
  end

  def valid_position?(position)
    row, col = position
    return false unless row && col

    cell_value = @grid.board[row][col]
    cell_value.nil? || cell_value == ' '
  end


  def handle_collisions(new_position)
    other_players = players - [current_player]

    other_players.each do |player|
      player.pieces.each do |piece|
        if @grid.find_piece_position(piece) == new_position
          puts "#{current_player.color}'s piece #{piece} ate #{player.color}'s piece #{piece}. #{player.color}'s piece goes back to start!"
          move_piece_to_new_position(piece, start_position)
        end
      end
    end
  end
  def enter_safehouse
    puts "#{current_player.color}'s piece entered the safehouse!"
    safehouse_marker = 'S'
    current_player.pieces[0] = "#{current_player.color}#{safehouse_marker}"
  end


  def start_position
    board.size - 1
  end

  def safehouse_position
    10
  end

  def display_board
    system 'clear' # Clear the console for a clean display (works on Unix-like systems)

    @board.each do |row|
      puts row.map { |cell| cell.nil? ? ' ' : cell }.join(' ')
    end
  end


  def switch_turn
    current_index = players.index(@current_player)
    next_index = (current_index + 1) % players.length
    @current_player = players[next_index]
    puts "Switching turn to #{@current_player.color}"
  end

  def play
    loop do

      play_turn
      break if game_over?
    end

    puts "Game over! #{current_player.color} wins!"
  end


  def game_over?
    players.each do |player|
      safehouse_count = player.pieces.count { |piece| piece.end_with?('S') }
      return true if safehouse_count == player.pieces.length
    end

    false
  end
  grid = Grid.new


  piece_identifier = "r1"
  position = grid.find_piece_position(piece_identifier)

  # Check if the piece was found
  if position
    puts "Piece #{piece_identifier} position: #{position}"
  else
    puts "Piece #{piece_identifier} not found on the board."
  end

  end
