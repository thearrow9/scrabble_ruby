class Tile
  attr_reader :points, :char
  def initialize(char, points)
    @char, @points = char, points
  end
end

class Storage
  include ScrabbleSet

  attr_reader :list

  def initialize
    @list = []
    ALPHABET.each do |letter, (points, quantity)|
      quantity.times { @list << Tile.new(letter, points) }
    end
  end
end
