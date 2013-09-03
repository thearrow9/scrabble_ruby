require 'sqlite3'

class DB
  def initialize
    @db = SQLite3::Database.open('db/dbase.db')
  end

  def create_table
    print 'Базата данни'
    print 'не' unless
    @db.execute('CREATE TABLE IF NOT EXISTS `scrabble` (
                `word` VARCHAR(20) NOT NULL,
                `exists` INTEGER(1) NOT NULL,
                `lang` CHAR(2) NOT NULL,
                 PRIMARY KEY (`word`)
                )')
    print " e създадена.\n"
  end

  def find_word(word, lang)
    row = @db.get_first_row("SELECT * FROM scrabble WHERE word = ? AND lang = ?", word, lang)
    row.nil? ? -1 : row[1]
  end

  def insert_word(word, flag, lang)
    @db.execute("INSERT INTO scrabble VALUES(?, ?, ?)", word, flag, lang)
  end

  def close
    @db.close
  end
end
