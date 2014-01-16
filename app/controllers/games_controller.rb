class GamesController < ApplicationController
  def home
  end

  def new
  	@game = Game.create(date: Date.today, start_time: Time.now)

  	render 'new'
  end

  def load
  end

  def play
  end
end
