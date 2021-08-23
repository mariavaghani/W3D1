class Player
  attr_reader :name
  def initialize(name)
    # p "program Name"
    # p $PROGRAM_NAME
    # p "p __FILE__"
    # p __FILE__
    @name = name.capitalize
  end

  def guess
    
  end
end

if __FILE__ == $PROGRAM_NAME
  p $PROGRAM_NAME

  p __FILE__
  player1_name = "Maria"
  player2_name = "Akshay"
  p player1 = Player.new(player1_name)
  p player2 = Player.new(player2_name)

end


