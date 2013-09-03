class ScrabbleLog
  GAME_LOG_PATH = 'logs/scrabble.txt'
  ERROR_LOG_PATH = 'logs/error.txt'

  $stderr.reopen(ERROR_LOG_PATH)
  def self.searching_word(word, code)
    output = "Думата \"#{word}\" " +
    case code
    when 1
      'е намерена в БД и е валидна.'
    when 0
      'е намерена в БД, но е невалидна.'
    else
      'не е намерена в БД, търся в уеб...'
    end
    output += "\n"
    write(output)
  end

  def self.validating_word(word, flag)
    write "Думата \"#{word}\" не съществува в тълковния речник.\n" unless flag
  end

  def self.write(content)
    file = File.new(GAME_LOG_PATH, "a")
    file.write(content)
    file.close
  end
end
