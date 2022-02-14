require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_checker = JSON.parse(URI.open(url).read)
    @score = params[:word].length**2

    if params[:word].upcase.chars.all? { |letter| params[:word].upcase.count(letter) <= params[:letters].count(letter) }
      if word_checker["found"]
        @result = "Congratulations! #{params[:word].upcase} is a valid English world! Your score is: #{@score}"
      else
        @result = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but #{params[:word].upcase} can't be built out of #{params[:letters]}"
    end
  end
end
