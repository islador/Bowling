class PlayersController < ApplicationController
  def add_score
  	player = Player.where("id = ?", params[:player_id])[0]

  	player.score_card.send("throw#{params[:throw_id]}=", params[:score])
  	player.score_card.save

  	@score = player.score_card.send("throw#{params[:throw_id]}")
  end
end
