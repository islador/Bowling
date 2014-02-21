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
    
    #Assign turn_order
    player_count = game.players.where("team = ?", params[:team])

    if params[:team].to_i == 1 and player_count.empty? == true
      @turn_order = 0
    end

    if params[:team].to_i == 2 and player_count.empty? == true
      @turn_order = 1
    end

    if player_count.empty? == false
      @turn_order = 2 + player_count.last.turn_order
    end

    #Assign start_turn
    @start_turn = @turn_order * 10

  	@player = game.players.create(name: params[:name], team: params[:team], turn_order: @turn_order, start_turn: @start_turn)
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

  private
  def define_turn_order(player)

  end
end
