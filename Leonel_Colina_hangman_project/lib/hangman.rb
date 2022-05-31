class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end
  attr_reader :attempted_chars, :guess_word, :attempted_chars, :remaining_incorrect_guesses
    def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length,"_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    @secret_word.split("").each_with_index.select{|letter,index| char==letter}.map{|pair| pair[1]}
  end

  def fill_indices(char, arr)
    arr.each {|idx| @guess_word[idx]=char}
  end

  def try_guess(char)
    if get_matching_indices(char).length ==0
      @remaining_incorrect_guesses -=1
    else
      fill_indices(char, get_matching_indices(char))
    end

    if already_attempted?(char)
      print "that has already been attempted"
      return false
    else
      @attempted_chars << char
      return true 
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    return try_guess(gets.chomp)
  end

  def win?
    if @secret_word == @guess_word.join("")
      print "WIN"
      return true
    end
    false
  end

  def lose?
    if @remaining_incorrect_guesses ==0
      print "LOSE"
      return true
    end
    false
  end 

  def game_over?
    if win? || lose?
      print @secret_word
      return true
    end
    false
  end

end
