require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    # time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("http://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
