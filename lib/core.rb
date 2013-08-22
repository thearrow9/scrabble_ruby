class Tile
  attr_reader :points, :char
  def initialize(char, points)
    @char, @points = char, points
  end
end


module ScrabbleRules
  BOARD_WIDTH = BOARD_HEIGHT = 15.freeze
  BONUSES = { '3W' => [[1, 1], [1, 4]] }.freeze
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

class Storage < Tile
  include ScrabbleRules

  attr_reader :list

  def initialize
    @list = []
    ALPHABET.each do |letter, (points, quantity)|
      quantity.times { @list << super(letter, points) }
    end
  end
end
