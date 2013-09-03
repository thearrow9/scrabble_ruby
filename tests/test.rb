require 'core'

describe Tile do
  before :all do
    @tile = Tile.new('Б', 2)
  end

  describe '#points' do
    it 'points should match its tile' do
      @tile.points.should be 2
    end
  end
end

describe Storage do
  before :all do
    @storage = Storage.new
    @tiles = Constant.set.inject(0) { |sum, value| sum + value[1][1] }
  end

  describe '#list' do
    it 'returns size of alphabet' do
      @storage.list.size.should be @tiles
    end
  end
end

describe Notation do
  describe '#id_to_coords' do
    it 'returns coordinates by id' do
      expect(Notation.id_to_coords(0)).to eq([1, 1])
      expect(Notation.id_to_coords(1)).to eq([1, 2])
      expect(Notation.id_to_coords(15)).to eq([2, 1])
      expect(Notation.id_to_coords(16)).to eq([2, 2])
      expect(Notation.id_to_coords(224)).to eq([15, 15])
    end
  end
end




describe ScrabbleCore do
  before :all do
    @core = ScrabbleCore.new
  end

  describe '#tiles_needed' do
    it 'returns amount of needed tiles' do
      @core.send(:tiles_needed).should be 7
    end

    it 'returns remaining tiles' do
      game.draw(game.tiles_needed)
      expect(game.storage.list.size).to eq(tiles - 7)
    end
  end

end

#describe Scrabble do
#  scr = Scrabble.new
#
#  describe '#exec' do
#    it 'it executes a method' do
#      expect(Command.execute('8,8 h дума').size).to be > 0
#    end
#  end
#end
#
#describe ScrabbleValidation do
#  sc = ScrabbleValidation.new
#
#  describe '#parse_word' do
#    sc.send(:parse_word, '8,8 v олеле')
#  end
#end
