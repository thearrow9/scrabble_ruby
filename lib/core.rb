class Tile
  attr_reader :points, :char
  def initialize(char, points)
    @char, @points = char, points
  end
end

module ScrabbleSet
  ALPHABET = { 'А' => [1, 17],
               'Б' => [2, 1],
               'В' => [2, 1],
               'Г' => [3, 1],
               'Д' => [2, 1],
               'Е' => [1, 1],
               'Ж' => [4, 1],
               'З' => [4, 1],
               'И' => [1, 1],
               'Й' => [5, 1],
               'К' => [2, 1],
               'Л' => [2, 1],
               'М' => [2, 1],
               'Н' => [1, 1],
               'О' => [1, 1],
               'П' => [1, 1],
               'Р' => [1, 1],
               'С' => [1, 1],
               'Т' => [1, 1],
               'У' => [5, 1],
               'Ф' => [10, 1],
               'Х' => [5, 4],
               'Ц' => [8, 1],
               'Ч' => [5, 4],
               'Ш' => [8, 4],
               'Щ' => [10, 2],
               'Ъ' => [3, 4],
               'Ь' => [10, 1],
               'Ю' => [8, 1],
               'Я' => [5, 4],
               '_' => [0, 0]
  }.freeze
end

module ScrabbleRules
  #MAX_PLAYERS = 4
  TILES_IN_RACK = 7
end

module ScrabbleBoard
  BOARD_SIZE = 15
  BONUSES = { '3W' => [[1, 1], [1, 4]], '*' => [[8, 8]] }.freeze
  START_POSITION = [8, 8]

  BOARD_FIELDS = BOARD_SIZE ** 2.freeze

  def id_to_coords(id)
    [id / BOARD_SIZE, id % BOARD_SIZE ].map { |x| x + 1 }
  end
end

module PrintSettings
  FIELD_SIZE = 6
  ROW_NAMES = Array('A'..'Z')
end

class Storage < Tile
  include ScrabbleSet

  attr_reader :list

  def initialize
    @list = []
    ALPHABET.each do |letter, (points, quantity)|
      quantity.times { @list << super(letter, points) }
    end
  end
end

class Field

  attr_reader :bonus

  def initialize(id, bonus)
    @id, @bonus, @occupied = id, bonus, false
  end
end

class Board < Field
  include ScrabbleBoard

  attr_reader :fields

  def initialize
    @fields = []
    (BOARD_FIELDS).times do |id|
      @fields << super(id, field_bonus(id))
    end
  end

  private

  def field_bonus(id)
    coords = id_to_coords(id)
    BONUSES.each { |label, value| return label if value.member? coords }
    nil
  end
end

class GameOutput
  include PrintSettings

  def start_game
    print File.read('help/welcome.txt')
  end

  private

  def print_help
    print File.read('help/help.txt')
  end

  def prompt
    print '>>>> '
    gets.chomp
  end

  def print_tiles(rack)
    print 'Your tiles: '
    rack.each { |char, points| print "#{char}(#{points}) " }
    print "\n"
  end

  def print_board(board)
    size = ScrabbleBoard::BOARD_SIZE
    (1..size).each { |b| print b.to_s.center(6) }
    print "c/r\n"

    board.fields.each_slice(size) do |row|
      row.each { |field| print field[1].nil? ? '.'.to_s.center(6) : field[1] .to_s.center(6) }
      print ROW_NAMES[row.last[0] / size] + "\n"
    end
  end
end

class ScrabbleCore < GameOutput
  include ScrabbleRules

  attr_reader :storage

  def initialize
    @board, @storage = Board.new, Storage.new
    @storage.list.shuffle!
    @rack = []
  end

  private

  def tiles_needed
    if @storage.list.empty?
      game_over
    else
      needed, available = TILES_IN_RACK - @rack.size, @storage.list.size
    end
    needed > available ? available : needed
  end

  def draw(amount)
    amount.times { @rack << @storage.list.pop }
  end

  def print_tiles
    super(@rack)
  end

  def print_board
    super(@board)
  end

  def game_over

  end
end

module GameCommand
end

class Scrabble < ScrabbleCore
  include GameCommand

  def initialize
    super
  end

  def start_game
    super
    loop do
      draw(tiles_needed)
      print_board
      print_tiles
      exec
      break if game_over
    end
  end

  private

  def exec
    to_call = Commander.execute(prompt)
    #send(to_call[0], to_call[1])
    send(*to_call)
  end

  def save_game
    p 'save game'
  end

  def print_help
    super
  end

  def write_word(word)
    p 'write word' + word
  end

  def not_found
    p 'not found'
  end

end

class Notation
  def self.save_game(game)

  end
end

class Word
  def self.check(word)
  end
end

class Commander
  def self.execute(command)
    case
    when command[0] == 'h'
      ['print_help']
    when command[0] == 's'
      ['save_game']
    when /([1[0-5]|[1-9]][A-O])\s(v|h)\s(\p{Cyrillic})+/i =~ command
      ["write_word", command]
    else
      ['not_found']
    end
  end
end



game = Scrabble.new
game.start_game
