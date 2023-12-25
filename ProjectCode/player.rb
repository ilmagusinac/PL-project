class Player
  attr_accessor :color, :pieces
  def initialize(color)
    @color = color
    @pieces = ["#{color}1", "#{color}2", "#{color}3", "#{color}4"]
  end

end

