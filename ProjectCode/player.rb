class Player
  attr_accessor :color, :pieces, :rolled_six
  def initialize(color)
    @color = color
    @pieces = ["#{color}1", "#{color}2", "#{color}3", "#{color}4"]
    @rolled_six = false
  end

  def roll_six
    @rolled_six = true
  end
  def rolled_six?
    @rolled_six
  end
  def reset_rolled_six
    @rolled_six = false
  end

end

