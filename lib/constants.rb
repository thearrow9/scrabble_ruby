require_relative './languages.rb'

module ScrabbleRules
  BOARD_SIZE = 15
  #TODO
  BONUSES = { '3W' => [[1, 1], [1, 4]], '*' => [[8, 8]] }
  #END TODO
  START_POSITION = [8, 8]
  BOARD_FIELDS = BOARD_SIZE ** 2

  TILES_IN_RACK = 7
  FIELD_SIZE = 6
end

class Constant
  include ScrabbleRules, EnglishPack

  METHODS = {'set'           => ALPHABET,
             'writing_regex' => CMD_REGEX,
             'main_regex'    => MAIN_REGEX,
             'lang'          => LABEL,
             'server'        => SERVER_URL,
             'pattern'       => NOT_FOUND_REGEX,
             'size'          => BOARD_SIZE,
             'all_fields'    => BOARD_FIELDS,
             'field_size'    => FIELD_SIZE,
             'start_coord'   => START_POSITION,
             'bonuses'       => BONUSES,
             'tiles_in_rack' => TILES_IN_RACK
  }

  METHODS.each do |key, value|
    define_singleton_method key do
      value
    end
  end
end

