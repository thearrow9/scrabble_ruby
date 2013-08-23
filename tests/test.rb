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
    expect(storage.list.size).to be > 31
  end
end

describe Board do
  board = Board.new
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
