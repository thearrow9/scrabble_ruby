require_relative './constants.rb'
require_relative './commands.rb'
require_relative './notation.rb'
require_relative './storage.rb'
require_relative './board.rb'
require_relative './output.rb'
require_relative '../drivers/sqlite3.rb'

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

    true
  end
end


class ScrabbleValidation < ScrabbleCore

  private


  def validate_used_tiles(letters)

  end

  def collect_all_words
    @move.words = [try_to_concat]
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

  def concat_after
    position = @move.temp_tiles.first[1]
    prefix = ''
    while position > 0 and position % Constant.size != 0 and ! free? position do
      prefix += get_letter_at(position)
      position -= @move.direction
    end
    prefix
  end

  def concat_before
    position = @move.temp_tiles.last[1]
    suffix = ''
    while position < Constant.all_fields and (position - 1) % Constant.size != 0 and ! free? position do
      suffix += get_letter_at(position)
      position += @move.direction
    end
    suffix
  end

  def look_opposite_direction
    @move.temp_tiles.each
  end

  def verify_words
    p @move.words
    @move.words.each
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
    @move.temp_tiles = word_coords(start_id, letters)
    place_new_tiles
    original_word = find_before(start_id - @move.direction, @move.direction) + find_after(start_id, @move.direction)
    p original_word
    p @move
    #validate_used_tiles(letters)
    #validate_writing(start_id.to_i, letters, direction)
    ##collect_all_words
    ##try_to_concat(word)
    #look_opposite_direction
    #verify_words
  end

  def place_new_tiles
    @move.temp_tiles.each { |row| @board.fields[row[0]].label = row[1] }
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

  def exec
    to_call = Command.execute(prompt)
    send(*to_call)
  end

  private

  def save_game
    true
  end

  def not_found
  end

end

class Word
  def self.exists? word
    true
  end
end

game = Scrabble.new
game.start_game
