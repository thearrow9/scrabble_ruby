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
               '_' => [2, 2]
  }.freeze
end

module ScrabbleRules
  MAX_PLAYERS = 4
  TILES_IN_RACK = 7
end

module ScrabbleBoard
  BOARD_SIZE = 15
  BONUSES = { '3W' => [[1, 1], [1, 4]] }.freeze
  START_POSITION = [8, 8]

  BOARD_FIELDS = BOARD_SIZE ** 2.freeze

  def id_to_coords(id)
    [id / BOARD_SIZE, id % BOARD_SIZE ].map { |x| x + 1 }
  end
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
  def initialize(id, bonus)
    @id, @bonus, @occupied = id, bonus, false
  end
end

class Board < Field
  include ScrabbleBoard

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

class SingleMove
  def write_word

  end
end

class Game < SingleMove
  include ScrabbleRules

  attr_reader :storage

  def initialize(players = 1, time_per_move = 60)
    @players, @time_per_move = players, time_per_move
    @board, @storage = Board.new, Storage.new
    @storage.list.shuffle!
    @rack = []
  end

  def start_game
    draw(tiles_needed)
    write_word
  end

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

  def give_up

  end

  private

  def game_over

  end
end

#first_game = Game.new
