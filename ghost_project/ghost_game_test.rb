require_relative "game"

player1_name = "Maria"
player2_name = "Akshay"


player1 = Player.new(player1_name)
player2 = Player.new(player2_name)

players = [player1, player2]

game = Game.new(players, "z")

p game.current_player
p game.previous_player
p game.next_player!
p game.current_player
p game.previous_player

game.take_turn(player1)