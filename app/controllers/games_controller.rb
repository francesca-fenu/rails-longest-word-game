require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    # The new action will be used to display a new random grid and a form.
    @letters = 10.times.map { [*"A".."Z"].sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dict_serialized = URI.open(url).read
    parsed = JSON.parse(dict_serialized)

    if !@word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
      @answer = "Sorry but #{@word} can't be build out of #{@letters.flatten}"
    elsif parsed['found'] == false
      @answer = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @answer = "Congratulations! #{@word} is a valid English word!"
    end
    @answer
  end
end
