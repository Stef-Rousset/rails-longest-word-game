require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
      if english(@word) == false
        @result = "Sorry but #{@word} does not seem to be a valid English word"
      elsif english(@word) == true && include?
        @result = "Congratulations, #{@word} is a valid word"
      else
        @result = "Sorry but #{@word} can't be build out of #{@letters}"
      end
  end

  private

  def english(word)
    english_word = open("https://wagon-dictionary.herokuapp.com/#{word}")
    valid_word = JSON.parse(english_word.read)
    if valid_word['found'] == false
      return false
    else
      return true
    end
  end

  def include?
    @word.chars.sort.all? do |letter|
    @letters.include?(letter)
    end
  end
end
