require_relative './commands.rb'
require_relative './notation.rb'
require_relative './storage.rb'
require_relative './board.rb'
require_relative './output.rb'
require_relative './log.rb'
require_relative './online_checker.rb'
require_relative '../drivers/sqlite3.rb'
require_relative './constants.rb'

class ScrabbleMove
  attr_accessor :direction, :words, :temp_tiles

  def initialize
    reset
  end

  def place_temp(char, position)
    @temp_tiles.push([char, position])
  end

  def reset
    @temp_tiles, @words = [], []
    @direction = 1
  end
end

class ScrabbleCore < ScrabbleOutput
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
      needed, available = Constant.tiles_in_rack - @rack.size, @storage.list.size
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

  private


  def validate_used_tiles(letters)

  end

  def word_coords(start_id, letters)
    tiles = []
    position = start_id.to_i
    until letters.empty? do
      if free? position
        tiles << [position, letters.shift, @board.fields[position].label]
      end
      position += @move.direction
      return [] if position > Constant.all_fields || position % Constant.size == 0
    end
    return tiles
  end

  def verify_words
    is_ok = true
    @move.words.each do |word|
      code = Word.verify(word)
      ScrabbleLog.searching_word(word, code)
      is_ok = false if code == 0
      if code < 0
        result = ScrabbleOnlineCheck.verify? word, Constant.server, Constant.pattern
        flag = result ? 1 : 0
        Word.insert(word, flag)
        ScrabbleLog.validating_word(word, result)
        is_ok = false unless result
      end
    end
    is_ok
  end
end

class ScrabbleWordDetector < ScrabbleValidation
  def initialize
    super
    @moves = []
    @move = ScrabbleMove.new
  end

  def word_controller(command)
    start_id, letters, @move.direction = Command.parse(command)
    p @move
    @move.temp_tiles = word_coords(start_id, letters)
    place_new_tiles
    @move.words << get_word(start_id, @move.direction)
    find_more_words
    undo_move unless verify_words
  end

  def place_new_tiles
    @move.temp_tiles.each { |row| @board.fields[row[0]].label = row[1] }
  end

  def get_word(start_id, direction)
    find_before(start_id - direction, direction) + find_after(start_id, direction)
  end

  def find_more_words
    direction = Notation.other_direction(@move.direction)
    @move.temp_tiles.each do |letter|
      position = letter[0]
      @move.words << get_word(position, direction)
    end
    reject_non_words
  end

  def reject_non_words
    @move.words.reject! { |word| word.size < 2 }
  end

  def find_before(id, step)
    prefix = ''
    while id > -1 and (id + 1) % Constant.size != 0 do
      break if free? id
      prefix = get_letter_at(id) + prefix
      id -= step
    end
    prefix
  end

  def find_after(id, step)
    suffix = ''
    while id < Constant.all_fields and id % Constant.size != 0  do
      break if free? id
      suffix += get_letter_at(id)
      id += step
    end
    suffix
  end

  def free? id
    ! @board.fields[id].occuppied?
  end

  def undo_move
    @move.temp_tiles.each { |row| @board.fields[row[0]].label = row[2] }
    @move.reset
  end

  def get_letter_at(id)
    return @board.fields[id].label if @board.fields[id].occuppied?
    @move.temp_tiles.select { |char| char[0] == id }.first
  end
end

class Scrabble < ScrabbleWordDetector
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
    to_call = Command.execute(prompt)
    send(*to_call)
  end

  def save_game
    true
  end

  def not_found
  end

end

class Word
  def self.verify word
    db = DB.new
    result = db.find_word(word, Constant.lang)
    db.close
    result
  end

  def self.insert(word, flag)
    db = DB.new
    db.insert_word(word, flag, Constant.lang)
    db.close
  end
end

game = Scrabble.new
game.start_game
