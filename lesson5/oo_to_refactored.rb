require "pry"
module Deck
  def shuffle
    cards = []
    Card::VALUES.each do |value|
      Card::SUITS.each do |suit|
        cards << Card.new(value, suit)
      end
    end
    cards
  end

  def deal_card
    deck.slice!(0,1)
  end
end

class Participant
  include Deck
  attr_accessor :hand
  attr_reader :name

  def initialize(name)
    @name = name
    @hand = []
  end

  def prompt
    reply = ''
    loop do 
      puts "#{name}, would you like to hit or stay?"
      reply = gets.chomp
      break if ["hit", "stay", "h", "s"].include?(reply)
      puts "Sorry, please enter hit, stay (h, or s, for short)"
    end
    decision(reply)
  end

  def decision(reply)
    ["hit", "h"].include?(reply) ? hit : stay
  end

  def hit
    
    binding.pry
  end

  def stay

    binding.pry
  end

  def busted?
  end

  def <<(card) 
    self.hand << card
  end

  def show_hand
    output = hand.map do |card|
      "#{card.value} of #{card.suit}"
    end
    puts "#{name} is holding #{joinor(output)}."
  end

  def joinor(output)
    case output.size
    when 2 then output.join(' and ')
    else
      output[-1] = ", and #{output.last}"
      output.join(', ')
    end
  end

  def total
  end
end

class Dealer < Participant
  def show_hidden_hand
    hidden = Game.over? ? false : true 

    output = hand.map do |card|
      "#{card.value} of #{card.suit}"
    end

    puts "#{name} is holding #{ hidden_hand(output, hidden)}."
  end

  def hidden_hand(output, hidden)
    output[-1] = hidden ? "unknown card" : output.last
    joinor(output)
  end
end

class Card
  SUITS = ["Hearts", "Clubs", "Diamonds", "Spades"]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
  attr_reader :value, :suit
  
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end


class Game
  include Deck
  attr_accessor :player, :dealer, :deck
  @@game_over = false

  def initialize
    @player = Participant.new("Player")
    @dealer = Dealer.new("Dealer")
    @deck = shuffle
  end

  def self.over?
    @@game_over
  end

  def self.game_over=(bool)
    @@game_over = bool
  end

  def start
    welcome_message
    deal_cards
    show_initial_cards
    player_turn

    binding.pry
    dealer_turn
    show_result
  end

  def deal_cards
    2.times do |_|
      player << deal_card
      dealer << deal_card
    end
    
    player.hand = player.hand.flatten
    dealer.hand = dealer.hand.flatten
  end

  def show_initial_cards
    dealer.show_hidden_hand
    player.show_hand    
    puts 
  end

  def player_turn
    player.prompt

    binding.pry
  end

  def welcome_message
    clear
    puts "Welcome to Twenty one!"
    puts 
  end

  def clear
    system 'clear'
  end
end

Game.new.start