# frozen_string_literal: true
require_relative 'grid'
require_relative 'player'

class Game
  attr_accessor :players, :current_player, :dice, :board, :grid

  def initialize
    @grid = Grid.new
    # Inside the initialize method of the Game class
    @players = %w[r g y b].map { |color| Player.new(color) }

    @current_player = @players[0]
    @dice = Die.new

  end



  def play_turn
    puts "#{@current_player}'s turn"
    puts "#{@current_player.color}'s turn. Press Enter to roll the dice."
    gets.chomp

    roll = dice.roll
    puts "#{@current_player.color} rolled: #{roll}"

    pieces = current_player.pieces

    if pieces.nil? || pieces.empty?
      puts "No pieces left for #{current_player.color}. Turn skipped."
      switch_turn
      return
    end

    piece = pieces.first
    piece_position = @grid.find_piece_position(piece)
    puts "Piece to move: #{piece}"
    puts "Piece position: #{piece_position}"

    if piece_position.nil?
      puts "Error: Piece not found on the board for #{current_player.color}'s turn."
      return
    end

    move_piece(roll)
    display_board

    switch_turn
    puts "Board state after #{@current_player}'s turn:"
    display_board
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
    return nil unless current_position

    row, col = current_position
    new_col = (col + roll) % @grid.board.first.size
    new_row = (row + (col + roll) / @grid.board.first.size) % @grid.board.size
    [new_row, new_col]
  end





  def move_piece_to_new_position(piece, new_position)
    new_row, new_col = new_position

    # Check if the new position is within the bounds of the board
    if valid_position?(new_position)
      board[new_row][new_col] = piece
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
    # Your logic for entering the safehouse goes here
    # For simplicity, let's assume the player's piece is removed from the board
    current_player.pieces.shift
  end


  def start_position
    board.size - 1
  end

  def safehouse_position
    10
  end

  def display_board
    board.display
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
    # Your game over logic goes here
    # For simplicity, let's assume the game ends after a certain number of turns.
    false
  end
  grid = Grid.new

  # Now, you can use the find_piece_position method
  piece_identifier = "r1"
  position = grid.find_piece_position(piece_identifier)

  # Check if the piece was found
  if position
    puts "Piece #{piece_identifier} position: #{position}"
  else
    puts "Piece #{piece_identifier} not found on the board."
  end
end

class Die
  def roll
    rand(1..6)
  end
end