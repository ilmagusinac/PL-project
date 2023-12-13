# frozen_string_literal: true

class Main
  game = Game.new

  # Add a loop for the game turns (you can customize the exit condition)
  while true
    game.play_turn
  end

end


