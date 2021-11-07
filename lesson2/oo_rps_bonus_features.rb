require 'pry'
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

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
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
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game orhchestration engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
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

  def tally_score
    if human.move > computer.move
      human.score += 1
    elsif computer.move > human.move
      computer.score += 1
    end
  end

  def display_winner(game_over = false)
    puts "Game over..." if game_over
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif computer.move > human.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie"
    end
  end

  def display_score
    puts "Player score #{human.score}"
    puts "Computer score #{computer.score}"
  end

  def insert_space
    4.times{ puts }
  end

  def play
    display_welcome_message
    game_over = false

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      tally_score
      if we_have_a_winner?
        game_over = true
        break
      end
      display_score
      insert_space
      sleep(3)
    end
    display_winner(game_over)
    display_goodbye_message
  end


  private 

  def we_have_a_winner?
    human.score >= 5 || computer.score >= 5
  end
end

# instantiate an object and call method play
RPSGame.new.play
