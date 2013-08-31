require 'sqlite3'

class DB
  def initialize
    @db = SQLite3::Database.open('db/dbase.db')
  end

  def create_table
    @db.execute('CREATE TABLE IF NOT EXISTS `scrabble` (
                `word` varchar(50) NOT NULL,
                `exists` INTEGER(1) NOT NULL,
                 PRIMARY KEY (`word`)
                )')
  end

  def find_word(word)

  end

  def close
    @db.close
  end
end

db = DB.new
db.create_table
