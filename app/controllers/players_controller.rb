class PlayersController < ApplicationController
  def add_score
  	@player = Player.where("id = ?", params[:player_id])[0]

  	@player.score_card.send("throw#{params[:throw_id]}=", params[:score])
  	#Calculate total score
  	@total = total_score(@player)
  	@player.score_card.total = @total
  	#update record
  	@player.score_card.save

  	@score = @player.score_card.send("throw#{params[:throw_id]}")
  end

  private

  def total_score(player)
  	total = 0
  	(1..21).each do |t|
  		response = player.score_card.send("throw#{t}")
  		if response.nil? == false
  			total = total + response
  		end
  	end
  	
  	return total
  end
end
