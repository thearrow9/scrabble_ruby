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
    gets.chomp
    #'8,8 v word'
  end

  def print_tiles(rack)
    print 'Твоите плочки: '
    rack.each { |tile| print "#{tile.char}(#{tile.points}) " }
    print "\n"
  end

  def print_header
    (1..Constant.size).each { |col| print col.to_s.center(Constant.field_size) }
    print "c/r\n"
  end

  def print_board(board)
    print_header

    rows = Array(1..Constant.size)
    board.fields.each_slice(Constant.size) do |row|
      row.each do |field|
        letter = field.blank? ? '.' : field.label.upcase
        print letter.center(Constant.field_size)
      end
      print "#{rows.shift}\n"
    end

    print_header
  end

  def print_swap(count)
    print "Получени са #{count} нови букви: "
  end

  def print_all_tiles(storage)
    print "Оставащи букви: #{storage.list.size}\n"
  end

  def print_error(code)
    print "Грешка (#{code}): " +
    case code
    when 0
      'непозната команда'
    when 1
      'използвате букви, които не притежавате!'
    when 2
      'първият ход трябва да минава през центъра!'
    when 3
      'новата дума не докосва плочка от дъската!'
    when 4
      'думата не е публикувана, вижте log-a.'
    end

    print "\n"
  end
end

