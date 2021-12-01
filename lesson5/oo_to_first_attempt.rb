module Deck
  FACE_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
  SUITS = ["clubs", "hearts", "spades", "diamonds"]
  # deck should be assembled here
  # should be an instance of the game, not the dealer

  # how do I put the deck in here?
end

class Participant
  attr_accessor :name, :hand, :total, :stays, :busts, :dealer

  def initialize(name, dealer = false)
    @hand = Hand.new
    @name = name
    @stays = false
    @busts = false
    @dealer = dealer
  end

  def pause_turn
    puts "Hit enter to continue..."
    STDIN.gets
  end

  def display_cards(game_over = false)
    puts "#{name} is holding #{hand.display(hidden: display?(game_over))}"

    if dealer && game_over
      display_hand_value
    else
      display_hand_value unless dealer
    end
    puts
  end

  def display?(game_over)
    if game_over
      false
    else
      is_a?(Player) ? false : true
    end
  end

  def stay
    puts "#{name} stays..."
    self.stays = true
  end

  def hit(deck)
    puts "#{name} hits"
    Dealer.deal_card(self, deck)

    dealer ? display_cards : display_hand_value
  end

  def busted?
    if hand.total > 21
      self.busts = true
      return true
    end
    false
  end

  def dealer_prompt(deck)
    case hit_or_stay
    when "hit", 'h'  then hit(deck)
    when "stay", 's' then stay
    end
  end

  def hit_or_stay
    reply = ''
    loop do
      puts "Would you like to hit or stay?"
      reply = gets.chomp
      puts
      break if ["hit", "stay", "h", "s"].include?(reply)
      puts "Please enter hit or stay (h, or s, for short)..."
    end
    reply
  end

  def bust_message
    puts "#{name} busts..."
  end

  def display_hand_value
    puts "#{name} #{hand.display_total}"
  end
end

class Dealer < Participant
  include Deck

  def stay
    self.stays = true if hand.total >= 17
  end

  def self.deals_hands(deck, dealer, player)
    [dealer, player].each do |participant|
      participant.hand.cards << deck.slice!(0, 2)
      participant.hand.cards = participant.hand.cards.flatten
      participant.hand.total_hand
      participant.hand.determine_value
    end
  end

  def self.deal_card(participant, deck)
    participant.hand.cards << deck.slice!(0, 1)
    participant.hand.cards = participant.hand.cards.flatten
    participant.hand.total_hand
  end

  def shuffle_cards
    deck = Hash.new
    FACE_VALUES.each do |value|
      deck[value] = []
      SUITS.each do |suit|
        deck[value] << Card.new(value, suit)
      end
    end
    deck.values.flatten.shuffle
  end

  def dealer_decision(deck)
    hand.total < 17 ? hit(deck) : stay
  end

  def turn(deck)
    loop do
      display_cards
      dealer_decision(deck)
      break if busted? || stay
      pause_turn
    end
  end

  def pass_message
    puts "Dealer stays..."
    puts "Players show their hands."
  end
end

class Player < Participant
  def turn(deck)
    loop do
      dealer_prompt(deck)
      break if busted? || stays
    end
  end

  def pass_message
    puts "#{name} passes turn to dealer."
  end
end

class Hand
  attr_accessor :cards, :total

  def initialize
    @cards = Array.new
    @total = 0
  end

  # prefer to_s over string interpolation
  # rubocop:disable Style/RedundantInterpolation
  def display(hidden: false)
    case hidden
    when true  then "#{show(cards, hidden)}"
    when false then "#{show(cards)}."
    end
  end
  # rubocop:enable Style/RedundantInterpolation

  def show(cards, hidden = false)
    hand = cards.map do |card|
      "#{card.value} of #{card.suit}"
    end

    hidden ? dealer_joinor(hand) : joinor(hand)
  end

  def dealer_joinor(hand)
    hand[-1] = "unknown."
    joinor(hand)
  end

  def joinor(hand)
    case hand.size
    when 2 then hand.join(', and ')
    when 1 then hand.join
    else
      hand[-1] = "and #{hand.last}"
      hand.join(', ')
    end
  end

  def determine_value
    aces = number_of_aces
    subtract_value_from_total(aces) if aces > 0 && total >= 21
  end

  def number_of_aces
    aces = 0

    cards.each do |card|
      aces += 1 if card.value == "Ace"
    end
    aces
  end

  def subtract_value_from_total(aces)
    loop do
      self.total -= 10
      aces -= 1
      break if total <= 21 || aces == 0
    end
  end

  # this needs to be my getter method
  def total_hand
    self.total = cards.map do |card|
      case card.value
      when "Jack", "Queen", "King"
        10
      when "Ace"
        11
      else
        card.value
      end
    end.sum
  end

  def display_total
    "has #{self.total}..."
  end
end

class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end

class Game
  include Deck
  attr_reader :dealer, :player
  attr_accessor :deck

  def initialize
    @dealer = Dealer.new("Dealer", true)
    @player = Player.new("Player")
    @deck = dealer.shuffle_cards
  end

  # game sequence
  def start
    welcome_message
    loop do
      reset_game
      pause_turn
      main_game
      break unless play_again?
    end

    goodbye_message
  end

  def main_game
    loop do
      clear
      dealer_deals_cards
      player_turn
      break if player.busts
      clear
      dealer_turn
      break
    end
    display_outcome
  end

  def dealer_deals_cards
    Dealer.deals_hands(deck, dealer, player)
    players_display_cards
  end

  def player_turn
    player.turn(deck)
    player_turn_results
  end

  def dealer_turn
    dealer.turn(deck)
    dealer_turn_results
  end

  def reset_game
    [player, dealer].each do |participant|
      participant.busts = false
      participant.stays = false
      participant.hand = Hand.new
      self.deck = dealer.shuffle_cards if dealer
    end
  end

  def players_display_cards(game_over: false)
    dealer.display_cards(game_over)
    player.display_cards(game_over)
  end

  def dealer_turn_results
    dealer.bust_message if dealer.busts
    dealer.pass_message if dealer.stays
  end

  def player_turn_results
    player.busts ? player.bust_message : player.pass_message
  end

  def pause_turn
    puts
    puts "Hit enter to continue..."
    STDIN.gets
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp
      break if ["y", "yes", "n", "no"].include?(answer)
      puts "Sorry, please enter the following:"
      puts "To play again, enter 'y', or 'yes'..."
      puts "Otherwise, enter 'n', or 'no'..."
    end
    ["y", "yes"].include?(answer)
  end

  def players_show_hands
    players_display_cards(game_over: true)
  end

  def clear
    system 'clear'
  end

  def welcome_message
    clear
    puts "Welcome to Twenty one!"
    puts
  end

  def goodbye_message
    puts "Thanks for playing Twenty one! Goodbye"
    puts
  end

  def display_outcome
    pause_turn
    clear
    players_show_hands
    determine_winner
  end

  def player_win_conditions
    (player.hand.total > dealer.hand.total || dealer.busted?) &&
      player.hand.total <= 21
  end

  def dealer_win_conditions
    (player.hand.total < dealer.hand.total || player.busted?) &&
      dealer.hand.total <= 21
  end

  def determine_winner
    if player_win_conditions
      puts "#{player.name} wins round"
    elsif dealer_win_conditions
      puts "#{dealer.name} wins round"
    else
      puts "It's a tie"
    end
  end
end

Game.new.start
