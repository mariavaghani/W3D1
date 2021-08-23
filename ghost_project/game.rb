require_relative "player"
require "byebug"
class Game

  attr_reader :current_player, :previous_player

  ALPHA = ("a".."z").to_a
  DICTIONARY = {}
  


  File.open("dictionary.txt") do |fp|
    # debugger
    fp.each do |line|
      word = line.chomp
      DICTIONARY[word] = true #possible_fragments
    end
  end
  
  def initialize(players, fragment)
    @fragment = fragment
    @players = players
    @current_player = @players[0]
    @previous_player = @players[1]
  end
  def next_player!
    @players.rotate!
    @current_player = @players[0]
    @previous_player = @players[1]
  end

  def take_turn(player)
    puts "Player #{player.name}, make your turn!"
    play = gets.chomp.downcase
    while !valid_play?(play)
      puts "I am sorry, #{player.name}, this move is invalid. Please, try again"
      play = gets.chomp.downcase
    end
    @fragment = play
  end

  def valid_play?(str)
    all_letters = str.split("").all? { |letter| ALPHA.include?(letter)}
    # p all_letters

    could_make_a_word = DICTIONARY.keys.any? { |key| key.include?(str) }
    # p could_make_a_word

    addition_to_fragment = str.include?(@fragment) && str != @fragment 
    # p addition_to_fragment

    all_letters && could_make_a_word && addition_to_fragment 
      
  end

  def play_round
    take_turn(@current_player)
    if DICTIONARY.keys.any? { |key| key == @fragment }
      puts "Player #{@previous_player.name} lost. The word is #{@fragment}"
    else
      next_player!
    end
  end

  def run
    
  end
end

if __FILE__ == $PROGRAM_NAME
  
  player1_name = "Maria"
  player2_name = "Akshay"
  player1 = Player.new(player1_name)
  player2 = Player.new(player2_name)

  players = [player1, player2]

  game = Game.new(players, "")

  p game.valid_play?("zo")
  game.play_round
  game.play_round
  game.play_round

end