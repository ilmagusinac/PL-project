class Player
  attr_accessor :pieces

  def initialize(name)
    @name = name
    @pieces = ['r1', 'r2', 'r3', 'r4']
  end
end
