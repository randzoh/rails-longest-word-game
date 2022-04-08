require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = [*'A'..'Z'].sample(10)
  end

  def score
    @letters = params[:letters]
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @english_word = valid?(@word)
  end

  private

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json_string = URI.open(url).read
    result = JSON.parse(json_string)
    result['found']
  end

  def included?(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end
end
