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
  describe '.id_to_coords' do
    it 'returns coordinates by id' do
      Notation.id_to_coords(0).should == ([1, 1])
      Notation.id_to_coords(1).should == ([1, 2])
      Notation.id_to_coords(15).should == ([2, 1])
      Notation.id_to_coords(16).should == ([2, 2])
      Notation.id_to_coords(224).should == ([15, 15])
    end
  end
end

describe ScrabbleCore do
  before :all do
    @core = ScrabbleCore.new
  end

  describe '#tiles_needed' do
    it 'returns amount of needed tiles' do
      @core.send(:tiles_needed).should be Constant.tiles_in_rack
    end

    it 'returns remaining tiles' do
      tiles = @core.storage.list.size
      @core.send(:draw, @core.send(:tiles_needed))
      @core.storage.list.size.should be tiles - Constant.tiles_in_rack
      @core.instance_variable_get(:@rack).size.should be Constant.tiles_in_rack
    end
  end
end

describe Constant do
  describe '.all_fields' do
    it 'counts all fields' do
      size = Constant.size
      Constant.all_fields.should be size * size
    end
  end
end

describe Command do
  describe '.execute' do
    it 'executes the correct command' do
      Command.execute('8,8 v ').should be_member('print_error')
      Command.execute('t').should be_member('print_all_tiles')
      Command.execute('q').should be_member('force_game_over')
      Command.execute('hdkske').should be_member('print_help')
      Command.execute('16,90 h word ').should be_member('print_error')
      Command.execute('8,8 v start').should be_member('word_controller')
      Command.execute('s').should be_member('print_error')
      Command.execute('s a').should be_member('swap_tiles')
    end
  end
end

describe ScrabbleValidation do
  before :all do
    @sv = ScrabbleValidation
  end

  describe '#first_move?' do
    it 'should have no moves' do
      @sv.instance_variable_get(:@moves).should be_nil
    end
  end
end
