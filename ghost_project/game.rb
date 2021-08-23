require_relative "player"
require "byebug"
class Game

  attr_reader :current_player, :previous_player

  # def self.substrings(string)
  #   substrings_arr = []
  #   (0...string.length).each do |idx_start|
  #     (idx_start...string.length).each do |idx_end|
  #       substrings_arr << string[idx_start..idx_end]
  #     end
  #   end
  #   substrings_arr.uniq
  # end

  ALPHA = ("a".."z").to_a
  DICTIONARY = {}
  
  File.open("dictionary.txt") do |fp|
    # debugger
    fp.each do |line|
      word = line.chomp
      # possible_fragments = Game.substrings(word)
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
    str.split("").all? { |letter| ALPHA.include?(letter)} && DICTIONARY.keys.include?(str) && str.include?(@fragment)
      
  end

  def play_round
    
  end
end