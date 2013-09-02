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
  BOARD_SIZE = 15
  BONUSES = { '3W' => [[1, 1], [1, 4]], '*' => [[8, 8]] }
  START_POSITION = [8, 8]
  BOARD_FIELDS = BOARD_SIZE ** 2

  TILES_IN_RACK = 7
  FIELD_SIZE = 6
end

class Constant
  include ScrabbleRules

  def self.size
    BOARD_SIZE
  end

  def self.all_fields
    BOARD_FIELDS
  end

  def self.field_size
    FIELD_SIZE
  end

  def self.bonuses
    BONUSES
  end

  def self.tiles_in_rack
    TILES_IN_RACK
  end
end

