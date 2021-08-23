require_relative "game"
puts "Welcome to the GHOST game"

puts "You probably do not know the rules... Do not worry, neither do I"

puts "Tell me your names, folks!"

player1_name = gets.chomp
player2_name = gets.chomp


player1 = Player.new(player1_name)
player2 = Player.new(player2_name)

players = [player1, player2]

game = Game.new(players, "")