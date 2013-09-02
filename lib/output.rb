class ScrabbleOutput
  def start_game
    print File.read('help/welcome.txt')
  end

  private

  def print_help
    print File.read('help/help.txt')
  end

  def prompt
    print '>>>> '
    #gets.chomp
    '8,8 v дума'
  end

  def print_tiles(rack)
    print 'Твоите плочки: '
    rack.each { |tile| print "#{tile.char}(#{tile.points}) " }
    print "\n"
  end

  def print_board(board)
    size = Constant.size
    (1..size).each { |b| print b.to_s.center(Constant.field_size) }
    print "c/r\n"
    rows = Array(1..size)

    board.fields.each_slice(size) do |row|
      row.each do |field|
        letter = field.blank? ? '.' : field.label
        print letter.center(Constant.field_size)
      end
      print "#{rows.shift}\n"
    end
  end

end

