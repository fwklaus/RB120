require 'pry'

module Personable
  def r2d2_choose
    ["lizard"].sample
  end

  def hal_choose
    ["rock", "spock"].sample
  end

  def chappie_choose
    Move::VALUES.sample
  end

  def sonny_choose
    Move::VALUES.sample
  end

  def number5_choose
    ["paper"].sample
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def >(other_move)
    rock? && other_move.scissors? ||
      paper? && other_move.rock? ||
      scissors? && other_move.paper? ||
      rock? && other_move.lizard? ||
      lizard? && other_move.spock? ||
      spock? && other_move.scissors? ||
      scissors? && other_move.lizard? ||
      lizard? && other_move.paper? ||
      paper? && other_move.spock? ||
      spock? && other_move.rock?
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def <(other_move)
    rock? && other_move.paper? ||
      paper? && other_move.scissors? ||
      scissors? && other_move.rock? ||
      lizard? && other_move.rock? ||
      spock? && other_move.lizard? ||
      scissors? && other_move.spock? ||
      lizard? && other_move.scissors? ||
      paper? && other_move.lizard? ||
      spock? && other_move.paper? ||
      rock? && other_move.spock?
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def to_s
    @value
  end
end

class Rock < Move; end
class Paper < Move; end
class Scissors < Move; end
class Lizard < Move; end
class Spock < Move; end

class Player
  attr_accessor :move, :name, :score

  @@move_history = []

  def initialize
    set_name
    @score = 0
  end

  def self.moves
    @@move_history
  end

  private

  def record_move(choice)
    case choice
      # these are setter method invocations
    when "rock"     then self.move = Rock.new(choice)
    when "paper"    then self.move = Paper.new(choice)
    when "scissors" then self.move = Scissors.new(choice)
    when "lizard"   then self.move = Lizard.new(choice)
    when "spock"    then self.move = Spock.new(choice)
    end

    @@move_history << "#{name} threw #{choice}"
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    record_move(choice)
  end
end

class Computer < Player
  include Personable

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = case name
             when "R2D2"     then r2d2_choose
             when "Hal"      then hal_choose
             when "Chappie"  then chappie_choose
             when "Sonny"    then sonny_choose
             when "Number 5" then number5_choose
             end
    record_move(choice)
  end
end

# Game orhchestration engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play
    display_welcome_message
    gameplay
    sleep(5)
    insert_space(2, '╪')
    display_move_history
    display_goodbye_message
  end

  private

  def play_round
    human.choose
    computer.choose
    insert_space(2, '²')
    display_moves
    display_winner
  end

  def gameplay
    loop do
      play_round
      insert_space(1, '╕')
      tally_score
      break if we_have_a_winner?
      display_score
      insert_space(3, '☻')
      sleep(3)
    end
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_score
    puts "Player score #{human.score}"
    puts "Computer score #{computer.score}"
  end

  def insert_space(x, sym)
    x.times { puts sym * 20 }
  end

  def we_have_a_winner?
    human.score >= 5 || computer.score >= 5
  end

  def tabulate_move_record
    moves = Player.moves
    new_arr = []

    idx = 0
    (moves.size / 2).times do |_|
      start = idx
      stop = start + 2

      new_arr << moves[start...stop]
      idx += 2
    end
    new_arr
  end

  def display_move_history
    record = tabulate_move_record

    puts "Results..."
    insert_space(1, '-')
    record.each_with_index do |(player, cpu), idx|
      puts "Round #{idx + 1}"
      puts "#{player}..."
      puts "#{cpu}..."
      puts "----------------------------------"
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif computer.move > human.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie"
    end
  end

  def tally_score
    if human.move > computer.move
      human.score += 1
    elsif computer.move > human.move
      computer.score += 1
    end
  end
end

# instantiate an object and call method play
RPSGame.new.play
