
class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if letter == nil
      raise ArgumentError.new('nil')
    end

    if letter.length == 0
      raise ArgumentError.new('empty')
    end
    
    if letter =~ /^((?![a-zA-Z]).)*$/
      raise ArgumentError.new('not a letter')
    end
 
    @guesses.chars do |ltr|
      if ltr.downcase == letter.downcase
        return false
      end
    end
   
    @wrong_guesses.chars do |ltr|
      if ltr.downcase == letter.downcase
        return false
      end
    end

    if @word.downcase.include? letter.downcase
      @guesses += letter.downcase
      return true
    else
      @wrong_guesses += letter.downcase
      return true
    end
  end

  def word_with_guesses
    result = ''
    @word.chars do |w|
      count = result.length
      @guesses.chars do |g|
        if w == g
          result += w
          break
        end
      end
      if result.length == count
        result += '-'
      end
    end
    return result
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
