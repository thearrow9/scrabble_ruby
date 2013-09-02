require_relative './languages.rb'

module ScrabbleRules
  BOARD_SIZE = 15
  BONUSES = { '3W' => [[1, 1], [1, 4]], '*' => [[8, 8]] }
  START_POSITION = [8, 8]
  BOARD_FIELDS = BOARD_SIZE ** 2

  TILES_IN_RACK = 7
  FIELD_SIZE = 6
end

class Constant
  include ScrabbleRules, EnglishPack

  def self.set
    ALPHABET
  end

  def self.cmd_regex
    CMD_REGEX
  end

  def self.main_regex
    MAIN_REGEX
  end

  def self.lang
    LABEL
  end

  def self.server
    SERVER_URL
  end

  def self.pattern
    NOT_FOUND_REGEX
  end

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

