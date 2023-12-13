# frozen_string_literal: true

class Game
  def initialize
    @players = [
      Player.new('Red'),
      Player.new('Green'),
      Player.new('Yellow'),
      Player.new('Blue',)
    ]
    @current_player_index = 0
    @board = Grid.new
  end

  def play_turn
    player = @players[@current_player_index]

    puts "#{player.name}'s turn. Press enter to roll the dice."
    gets.chomp

    roll_result = roll_dice
    puts "#{player.name} rolled a #{roll_result}."

    move_player(player, roll_result)

    display_board

    check_winner(player)

    # Switch to the next player for the next turn
    @current_player_index = (@current_player_index + 1) % @players.length
  end

  def roll_dice
    rand(1..6)
  end

  def move_player(player, steps)
    # Implement the logic to move the player on the board based on the dice roll
    # You'll need to update the player's position and handle special cases
    # such as safehouses, start positions, and capturing opponents' pieces.
    # Update the board accordingly.
  end

  def display_board
    @board.display_board
  end

  def check_winner(player)
    # Implement the logic to check if the player has won the game
    # For example, if all player's pieces have reached the end.
  end
end

