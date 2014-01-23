class PlayersController < ApplicationController
  def add_score
  	@player = Player.where("id = ?", params[:player_id])[0]
    #Determine current frame
    active_frame = current_frame(params[:throw_id].to_i)

    #Extract score_card
    @score_card = @player.score_card

    #Update the proper throw score on the score_card
  	@score_card.send("throw#{params[:throw_id]}=", params[:score])

    #update the proper frame score on the score_card
    @score_card = update_frame_score(@score_card, active_frame, params[:score].to_i)

    #Check for and update the score_card with strikes
    @score_card = strike_spare_check(params[:throw_id].to_i, @score_card, params[:score].to_i)

  	#Calculate total score
  	@score_card = total_score(@player)
  	#update record
  	@score_card.save

  	@score = @player.score_card.send("throw#{params[:throw_id]}")
  end

  private

  def total_score(player)
    score_card = @player.score_card
  	total = 0
  	(1..10).each do |t|
  		response = score_card.send("frame_#{t}")
  		score_card.total = total + response
  	end
  	
  	return score_card
  end

  def current_frame(current_throw)
    active_frame = 0
    if current_throw.odd? == true
      active_frame = (current_throw + 1)/2
    elsif current_throw == 21
      active_frame = 10
    else
      active_frame = current_throw/2
    end

    return active_frame
  end

  def update_frame_score(score_card, active_frame, score)
    frame_score = score_card.send("frame_#{active_frame}")
    frame_score = frame_score + score
    score_card.send("frame_#{active_frame}=", frame_score)

    return score_card
  end

  def strike_spare_check(current_throw, score_card, score)
    #Strike detection and score addition
    #If the current_throw is after a possible double scoring strike.
    if current_throw >= 3 and current_throw <= 20
      #If the current throw is odd
      if current_throw.odd? == true
        #Check if the previous odd frame was a strike
        if score_card.send("throw#{current_throw - 2}") == 10
          #If so, add the current score to that frame's score
          frame_score = score_card.send("frame_#{(current_throw -1)/2}")
          frame_score = frame_score + score
          score_card.send("frame_#{(current_throw - 1)/2}=", frame_score)
          #Also check if the next previous frame had a strike
          if current_throw >= 4
            if score_card.send("throw#{current_throw - 4}") == 10
              #If so, add the current score to that frame's score as well.
              frame_score = score_card.send("frame_#{(current_throw -3)/2}")
              frame_score = frame_score + score
              score_card.send("frame_#{(current_throw - 3)/2}=", frame_score)
            end
          end
        end
      else
        #Else, the throw must be even, check if the previous odd frame was a strike
        if score_card.send("throw#{current_throw - 3}") == 10
          #If so, add the current score that frame's score
          score_card.send("frame_#{currnet_throw - 2}=", score)
          #Also check if the next previous frame had a strike
          if score_card.send("throw#{current_throw - 5}") == 10
            #If so, add the current score to that frame's score as well.
            frame_score = score_card.send("frame_#{current_throw -4}")
            frame_score = frame_score + score
            score_card.send("frame_#{current_throw - 4}=", frame_score)
          end
        end
      end
    end

    #Spare detection and score addition
    #If current throw is odd
    if current_throw.odd? == true
      #If the current throw is after a possible strike
      if current_throw >= 3 and current_throw <= 19
        #If the frame before the current throw did not include a strike
        if score_card.send("throw#{current_throw - 2}") != 10
          #If the two throws before the current throw equal ten, then it is a spare.
          if score_card.send("throw#{current_throw - 1}") + score_card.send("throw#{current_throw - 2}") == 10
            #Add the current throw's score to the previous spare frame's frame score.
            score_card.send("frame_#{current_throw - 1}=", score)
          end
        end
      end
    end

    return score_card
  end

  
end
