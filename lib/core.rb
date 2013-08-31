require_relative '../drivers/sqlite3.rb'

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
end

module PrintSettings
  FIELD_SIZE = 6
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

  attr_reader :id, :bonus, :empty

  def initialize(id, bonus)
    @id, @bonus, @empty = id, bonus, true
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
    coords = Notation.id_to_coords(id)
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
    print 'Твоите плочки: '
    rack.each { |char, points| print "#{char}(#{points}) " }
    print "\n"
  end

  def print_board(board)
    size = ScrabbleBoard::BOARD_SIZE
    (1..size).each { |b| print b.to_s.center(FIELD_SIZE) }
    print "c/r\n"

    board.fields.each_slice(size) do |row|
      row.each { |field| print field[1].nil? ? '.'.to_s.center(FIELD_SIZE) : field[1] .to_s.center(FIELD_SIZE) }
      print "#{row.last[0] / size + 1}\n"
    end
  end
end

class ScrabbleMove
  def initialize
    reset
  end

  def place_temp(char, position)
    @temp_tiles.push([char, position])
  end

  def reset
    @temp_tiles = []
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

class ScrabbleValidation < ScrabbleCore
  def initialize
    super
    @move = ScrabbleMove.new
  end

  private

  def parse_word(word)
    start_position, direction, letters = word.split(' ')
    coords = Notation.coords_to_id(start_position.split(','))
    direction_value = Notation.get_direction(direction.downcase)
    validate_writing(coords, letters.downcase.split(','), direction_value)
  end

  def validate_writing(start_id, letters, direction_value)
    position = start_id
    until letters.empty? do
      @move.place_temp(letters.shift, position) if @board.fields[position][2]
      position += direction_value
      return -2 if position > ScrabbleBoard::BOARD_FIELDS || position % ScrabbleBoard::BOARD_SIZE == 0
    end
  end
end

class Scrabble < ScrabbleValidation
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

  def exec
    to_call = Command.execute(prompt)
    send(*to_call)
  end

  private

  def save_game
  end

  def not_found
  end

end

class Notation
  include ScrabbleBoard

  def self.save_game(game)

  end

  def self.get_direction(char)
    char == 'v' ? BOARD_SIZE : 1
  end

  def self.id_to_coords(id)
    [id / BOARD_SIZE, id % BOARD_SIZE].map { |x| x + 1 }
  end

  def self.coords_to_id(coords)
    (coords[0].to_i - 1) * BOARD_SIZE + coords[1].to_i - 1
  end
end

class Word
  def self.exists? word
    true
  end
end

class Command
  def self.execute(command)
    case
    when command[0] == 'h'
      ['print_help']
    when command[0] == 's'
      ['save_game']
    when /([1[0-5]|[1-9]],[1[0-5]|[1-9]])\s(v|h)\s(\p{Cyrillic})+/i =~ command
      ["parse_word", command]
    else
      ['not_found']
    end
  end
end



game = Scrabble.new
game.start_game
