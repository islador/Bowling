class GamesController < ApplicationController
  def home
  end

  def new
  	@game = Game.create(date: Date.today, start_time: Time.now)
  	@players = @game.players

  	render 'new'
  end

  def add_player
  	game = Game.where("id = ?", params[:game_id])[0]
  	@player = game.players.create(name: params[:name], team: params[:team])
  	@players = game.players

  	respond_to do |format|
  		format.js
  	end
  end

  def load
  end

  def play
  	@game = Game.where("id = ?", params[:game_id])[0]
  	render 'play'
  end

  def game_exists
    if (/^[0-9]{0,45}$/ === params[:game_id]) == false
      render :json => "invalid"
    else
      @game = Game.where("id = ?", params[:game_id])[0]

      if @game.nil? == true
        render :json => "invalid"
      else
        render :json => "valid"
      end
    end
  end
end
