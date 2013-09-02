require 'sqlite3'

class DB
  def initialize
    @db = SQLite3::Database.open('db/dbase.db')
  end

  def create_table
    @db.execute('CREATE TABLE IF NOT EXISTS `scrabble` (
                `word` VARCHAR(20) NOT NULL,
                `exists` INTEGER(1) NOT NULL,
                 PRIMARY KEY (`word`)
                )')
  end

  def find_word(word)
    row = @db.get_first_row("SELECT * FROM scrabble WHERE word = ?", word)
    row.nil? ? -1 : row[1]
  end

  def close
    @db.close
  end
end

db = DB.new
db.create_table
