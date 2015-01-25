require 'set'

class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}

    until @current_words.empty?
      new_current_words = explore_current_words(@current_words)
      @current_words = new_current_words
    end
  end

  private

  def explore_current_words(current_words)
    [].tap do |new_current_words|
      @current_words.each do |word|
        adjacent_words(word).each do |adj_word|
          next if @all_seen_words.include?(adj_word)
          new_current_words << adj_word
          @all_seen_words[adj_word] = word
        end
      end
    end.each do |word|
      puts "#{word} came from #{@all_seen_words[word]}"
    end

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
