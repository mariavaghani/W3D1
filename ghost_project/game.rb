require "set"
require_relative "player"
require "byebug"
class Game

  attr_reader :current_player, :previous_player

  ALPHA = ("a".."z").to_a

  
  def initialize(players)
    words = File.readlines("dictionary.txt").map(&:chomp)
    @dictionary = Set.new(words)
    @fragment = ""
    @players = players
    @current_player = @players[0]
    @previous_player = @players[1]
    @losses = Hash.new(0)
    @players.each { |player| @losses[player] = 0 }

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
      puts "I am sorry, #{player.name}, this move is invalid. Please, try again. Current fragment is #{@fragment}"
      play = gets.chomp.downcase
    end
    @fragment = play
  end

  def valid_play?(str)
    all_letters = str.split("").all? { |letter| ALPHA.include?(letter)}
    # p all_letters

    could_make_a_word = @dictionary.any? { |key| key.include?(str) }
    # p could_make_a_word

    addition_to_fragment = str.include?(@fragment) && str != @fragment && (str.length - @fragment.length == 1)
    # p addition_to_fragment

    all_letters && could_make_a_word && addition_to_fragment 
      
  end

  def is_word?(str)
    @dictionary.any? { |word| word == str }
  end

  def play_round

    until is_word?(@fragment) do
    
      take_turn(@current_player)
      if @dictionary.any? { |key| key == @fragment }
        puts "Player #{@previous_player.name} lost. The word is #{@fragment}"
        update_losses(@previous_player)
      else
        next_player!
      end
      
    end
    @fragment = ""
    show_stats
  end

  def run
    until @losses.any? { |player, num_losses| num_losses >= 5 }
      play_round
    end
    puts "Player #{@previous_player.name} lost!"
  end

  def update_losses(player)
    @losses[player] += 1 
  end

  def record(player)
    "GHOST"[0...@losses[player]]
  end

  def show_stats
    puts "================================="
    @players.each do |player|
      puts "#{player.name}: #{record(player)}"
    end
    puts "================================="

  end
end

if __FILE__ == $PROGRAM_NAME
  
  player1_name = "Maria"
  player2_name = "Akshay"
  player1 = Player.new(player1_name)
  player2 = Player.new(player2_name)

  players = [player1, player2]

  game = Game.new(players)
  
  game.run

end