# frozen_string_literal: true
# main.rb
require_relative 'player'
require_relative 'grid'
require_relative 'game'

class Main
  def self.run
    puts "Welcome to Ludo!"
    puts "================="

    num_players = prompt_for_number_of_players

    player_colors = prompt_for_player_colors(num_players)

    players = player_colors.map { |color| Player.new(color) }

    # Create the game with the chosen number of players and colors
    ludo_game = Game.new(players)


    ludo_game.play

    puts "Thanks for playing!"
  end

  def self.prompt_for_number_of_players
    puts "How many players will be playing? (Choose a number between 2 and 4)"
    num_players = gets.chomp.to_i

    until (2..4).include?(num_players)
      puts "Invalid number of players. Please choose a number between 2 and 4."
      num_players = gets.chomp.to_i
    end

    num_players
  end

  def self.prompt_for_player_colors(num_players)
    colors = %w[r g y b]
    selected_colors = []

    puts "Choose a color for each player: #{colors.join(', ')}"

    num_players.times do |i|
      puts "Player #{i + 1}, choose a color: "

      chosen_color = gets.chomp.downcase

      until colors.include?(chosen_color) && !selected_colors.include?(chosen_color)
        puts "Invalid color. Please choose one of the available colors: #{colors.join(', ')}"
        chosen_color = gets.chomp.downcase
      end

      selected_colors << chosen_color
    end

    selected_colors
  end
end

# Run the game
Main.run


