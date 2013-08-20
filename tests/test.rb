require 'core'

describe Tile do
  tile = Tile.new('Б', 2, 4)
  describe '#points' do
    it 'return the points of tile' do
      expect(tile.points).to eq(2)
    end
  end
end
