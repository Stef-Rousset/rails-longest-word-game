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
    # params[:letters] est une string de lettres, on le transfo en array
    @letters = params[:letters].split
      if english(@word) == false
        @result = "Sorry but #{@word} does not seem to be a valid English word"
      elsif english(@word) == true && include?(@word, @letters)
        @result = "Congratulations, #{@word} is a valid word"
      else
        @result = "Sorry but #{@word} can't be build out of #{@letters.join(',')}"
      end
  end

  private

  def english(word)
    english_word = open("https://wagon-dictionary.herokuapp.com/#{word}")
    valid_word = JSON.parse(english_word.read)
    valid_word['found'] ? true : false
  end

  def include?(word, letters)
    # chars transfo le mot en array
    # all? renvoie true si tous les elements repondent true au bloc
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
