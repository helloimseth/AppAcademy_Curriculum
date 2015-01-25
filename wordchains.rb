require 'set'

class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
  end

  def adjacent_words(word)

    [].tap do |adjacents|

      word.each_char.with_index do |char, index|

        ("a".."z").each do |letter|
          test_word = word.dup

          next if letter == char
          test_word[index] = letter
          
          adjacents << test_word if @dictionary.include?(test_word)
        end

      end

    end

  end

end
