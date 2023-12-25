# frozen_string_literal: true
# main.rb
require_relative 'player'
require_relative 'grid'
require_relative 'game'

class Main
  def self.run
    puts "Welcome to Ludo!"
    puts "================="

    ludo_game = Game.new
    ludo_game.play

    puts "Thanks for playing!"
  end
end

# Run the game
Main.run


