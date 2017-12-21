class WordSearch

  def word_parse(word)
    dic = File.read('/usr/share/dict/words')
      if dic.include?(word)
        "#{word} is a known word"
      else
        "#{word} is not a known word"
      end
  end

end
