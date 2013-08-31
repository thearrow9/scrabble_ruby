require 'core'

describe Tile do
  tile = Tile.new('Б', 2)
  describe '#points' do
    it 'points should match its tile' do
      expect(tile.points).to eq(2)
    end
  end
end

describe Storage do
  storage = Storage.new
  it 'returns size of alphabet' do
    expect(storage.list.size).to be > 0
  end
end

describe Board do
  board = Board.new

  #describe '#field_bonus' do
  #  it 'return bonus label' do
  #    expect(board.field_bonus(0)).to eq('3W')
  #    expect(board.field_bonus(1)).to eq(nil)
  #  end
  #end

  describe '#id_to_coords' do
    it 'returns coordinates by id' do
      expect(board.id_to_coords(0)).to eq([1, 1])
      expect(board.id_to_coords(1)).to eq([1, 2])
      expect(board.id_to_coords(15)).to eq([2, 1])
      expect(board.id_to_coords(16)).to eq([2, 2])
      expect(board.id_to_coords(224)).to eq([15, 15])
    end
  end
end

describe ScrabbleCore do
  game = ScrabbleCore.new
  tiles = game.storage.list.size

  describe '#tiles_needed' do
    it 'returns the amount of needed tiles' do
      expect(game.tiles_needed).to eq(7)
    end

    it 'returns remaining tiles' do
      game.draw(game.tiles_needed)
      expect(game.storage.list.size).to eq(tiles - 7)
    end
  end

end

describe Scrabble do
  scr = Scrabble.new

  describe '#exec' do
    com = Command.execute('8h h дума')
    it 'it executes a method' do
      expect(Command.execute('8h h дума').size).to be > 0
      scr.execute(com)
    end
  end
end
