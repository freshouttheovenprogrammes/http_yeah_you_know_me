class WordSearch

  def word_parse(word)
    dic = File.read('/usr/share/dict/words')
      if dic.include?(word)
        "WORD is a known word"
      else
        "WORD is not a known word"
      end
  end

end
