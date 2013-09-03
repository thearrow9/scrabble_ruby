class Word
  def self.verify word
    db = DB.new
    result = db.find_word(word, Constant.lang)
    db.close
    result
  end

  def self.insert(word, flag)
    db = DB.new
    db.insert_word(word, flag, Constant.lang)
    db.close
  end
end
