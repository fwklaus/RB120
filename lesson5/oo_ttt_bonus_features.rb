require 'pry'
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals
  attr_accessor :critical_placement

  def initialize
    @squares = {}
    @critical_placement = nil
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def [](key)
    @squares[key]
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # return winning marker or nil
  def count_marker(squares)
    return squares.first.marker if squares.all? { |sq| sq.marker == 'O' }
    return squares.first.marker if squares.all? { |sq| sq.marker == 'X' }
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def draw(human, computer)
    puts "#{human.name}, you're an #{human.marker}.
          #{computer.name}, a computer, is an #{computer.marker}..."
    puts ""
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts ""
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # returns winning marker or nil
  def winning_marker
    winner = nil
    WINNING_LINES.each do |line|
      if count_marker(@squares.values_at(*line))
        winner = count_marker(@squares.values_at(*line))
      end
    end
    winner
  end

  def threat?(human, empty, computer, move)
    case move
    when :attack
      computer == 2 && empty == 1
    when :defend
      human == 2 && empty == 1
    end
  end

  def threat_position(line, move)
    # rubocop:disable Style/ParallelAssignment
    human_markers, empty_markers, computer_markers = 0, 0, 0
    # rubocop:enable Style/ParallelAssignment

    line.each do |sq|
      human_markers += 1 if sq.marker == TTTGame::X_MARKER
      empty_markers += 1 if sq.marker == Square::INITIAL_MARKER
      computer_markers += 1 if sq.marker == TTTGame::O_MARKER
    end

    threat?(human_markers, empty_markers, computer_markers, move)
  end

  def cover_position(line)
    line.each do |key|
      self.critical_placement = key if @squares[key].marker == ' '
    end
  end

  def detect_attack_or_defense
    WINNING_LINES.each do |line|
      if threat_position(@squares.values_at(*line), :attack)
        cover_position(line)
        return true
      elsif threat_position(@squares.values_at(*line), :defend)
        cover_position(line)
        return true
      end
    end
    nil
  end
end

class Square
  INITIAL_MARKER = " "
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score, :current_player, :first_player, :name

  COMPUTER_NAMES = ["Alan", "Steve", "Matias", "Simón", "Xian"]

  def initialize(name, marker, current_player, first_player = @@first_player)
    @name = name
    @marker = marker
    @current_player = current_player
    @@first_player = first_player
    @score = 0
  end

  def self.goes_first
    @@first_player
  end
end

class TTTGame
  X_MARKER = "X"
  O_MARKER = "O"
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = nil
    @computer = nil
  end

  def play
    loop do
      clear
      display_welcome_message
      set_up_game
      main_game
      break unless play_again?
      reset(:new_game)
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def main_game
    loop do
      board.draw(human, computer)
      player_move
      display_result
      round_over_message
      break if game_over
      reset
    end
  end

  def player_move
    loop do
      current_player_moves
      increment_score if board.someone_won?
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def set_up_game
    set_up_player_attributes
    set_up_computer_attributes
  end

  def set_up_player_attributes
    marker = select_player_marker
    selection = select_first_move
    current_player = human_moves_first?(selection)
    first_player = first_player(selection, current_player)
    name = select_human_name

    @human = Player.new(name, marker, current_player, first_player)
  end

  def set_up_computer_attributes
    marker = human.marker == O_MARKER ? X_MARKER : O_MARKER
    current_player = !human.current_player
    name = select_computer_name

    @computer = Player.new(name, marker, current_player)
  end

  def select_human_name
    name = nil
    loop do
      puts "Enter a name:"
      name = gets.chomp
      break if name
      puts "Sorry, I didn't get that..."
    end
    name
  end

  def select_computer_name
    Player::COMPUTER_NAMES.sample
  end

  def select_player_marker
    marker = nil
    loop do
      puts "Select marker(X/O):"
      marker = gets.chomp
      break if marker == X_MARKER || marker == O_MARKER
      puts "Sorry, please select 'X' or 'O'..."
    end
    marker
  end

  def select_first_move
    first_move = nil
    loop do
      puts "Select first player (player/computer/random):"
      first_move = gets.chomp
      break if first_move == "player" || first_move == "computer" ||
               first_move == "random"
      puts "Sorry, please enter 'player', 'computer', or 'random':"
    end
    first_move
  end

  def human_moves_first?(selection)
    case selection
    when "player"
      true
    when "computer"
      false
    when "random"
      [true, false].sample
    end
  end

  def first_player(selection, current_player)
    case selection
    when :player then "player"
    when :computer then "computer"
    else
      current_player == true ? "player" : "computer"
    end
  end

  def current_player_moves
    human.current_player ? human_moves : computer_moves
    switch_current_player
  end

  def switch_current_player
    human.current_player = !human.current_player
    computer.current_player = !computer.current_player
  end

  def human_moves
    puts "Choose a square: #{joinor}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if board.detect_attack_or_defense
      board[board.critical_placement] = computer.marker
      board.critical_placement = nil
    else
      random_pick
    end
  end

  def random_pick
    if board[5].marker == ' '
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def human_turn?
    human.current_player
  end

  def game_over
    computer.score == 5 || human.score == 5
  end

  def increment_score
    human.score += 1 if human.marker == board.winning_marker
    computer.score += 1 if computer.marker == board.winning_marker
  end

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts
  end

  def round_over_message
    puts "Player score: #{human.score}"
    puts "Computer score: #{computer.score}"
    puts "Game over! #{winner_name} wins!" if game_over
    puts "Press enter to continue..."
    STDIN.gets
  end

  def winner_name
    human.name if human.marker == board.winning_marker
    computer.name if computer.marker == board.winning_marker
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def display_board
    board.draw(human, computer)
  end

  def clear_screen_and_display_board
    clear
    board.draw(human, computer)
  end

  def joinor
    case board.unmarked_keys.size
    when 2
      board.unmarked_keys.join(' or ')
    when 1
      board.unmarked_keys.join
    else
      board.unmarked_keys[0...-1].join(', ') +
        ", or #{board.unmarked_keys.last}"
    end
  end

  def winner_message
    case board.winning_marker
    when human.marker     then puts "You won, #{human.name}!"
    when computer.marker  then puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_result
    clear
    board.draw(human, computer)
    winner_message
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or no"
    end

    answer == 'y'
  end

  def reset(new_game = false)
    board.reset
    switch_current_player if Player.goes_first == "player" &&
                             human.current_player == false
    if new_game
      @first_player = nil
      @human = nil
      @computer = nil
    end
    clear
  end
end

# we'll begin the game like this
game = TTTGame.new
game.play
