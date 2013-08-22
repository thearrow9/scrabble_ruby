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

describe ScrabbleRules do
  context 'constants tests' do
    it 'returns board dimensions' do
      expect(ScrabbleRules::BOARD_HEIGHT).to eq(15)
    end

    it 'board must be a square' do
      expect(ScrabbleRules::BOARD_HEIGHT).to eq(ScrabbleRules::BOARD_WIDTH)
    end
  end
end
