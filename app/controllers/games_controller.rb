class GamesController < ApplicationController
  def home
  end

  def new
  	@game = Game.create(date: Date.today, start_time: Time.now)

  	render 'new'
  end

  def add_player
  	game = Game.where("id = ?", params[:game_id])[0]
  	@player = game.players.create(name: params[:name], team: params[:team])
  end

  def load
  end

  def play
  end
end
