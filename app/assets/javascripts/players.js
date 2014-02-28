$(document).ready(function(){

	var player_count = $(".game_id").attr("data-player-count");
	var turn_counter = 0;
	var select_active = 6;
	var loaded_game = false;

	if ($(".game_id").attr("data-select-active") == ""){
		select_active = 0;
	}
	else {
		select_active = $(".game_id").attr("data-select-active")
		loaded_game = true;
	}
	var target = $("#turn_number_" + turn_counter.toString());

	$("div[id^='turn_number_']").hide()
	$("select[id^='score_select_']").hide()

	setTimeout(function(){
		iterate_turn(turn_counter)

	},0);

	function iterate_turn(i) {
		if (i < (player_count * 10)){
			target = $("div#turn_number_" + i.toString());

			if (target.find("select").length > 0){
				
				target.show();
				count_selects(target);
			}else if (target.find("select").length == 0){

				target.show();
				turn_counter++;
				
				iterate_turn(turn_counter);
			}	
		}	
	};

	function count_selects(target_frame) {
		var select_count = target.find('select').length;

		if (select_count != 0){
			reveal_select();
			select_active++;
		}else if (select_count == 0){
			select_active = 0;
			turn_counter++;
			iterate_turn(turn_counter);
		};
		
	};

	function reveal_select() {
		current = target.find("select[data-select-order='"+ select_active.toString() +"']")
		current.show();

		if (loaded_game == true) {
			loaded_game = false
			previous_select = "score_select_" + (parseInt(current.attr("data-throw-id"))-1) + "_p" + current.attr("data-player-id")

			remove_invalid_options(current.attr('id'), previous_select)
		}
		
	};

	

	$("select[id^='score_select_']").on("change", function(){
		var score = $("#" + this.id).val();
		var player_id = $("#" + this.id).attr("data-player-id");
		var throw_id = $("#" + this.id).attr("data-throw-id");
		
		//Fire an AJAX call to /add_score
	    $.ajax({
	    	url: "/add_score", type: "POST",
	    	//Pass in each variable as a parameter.
	    	data: { player_id: player_id, 
	    		throw_id: throw_id, 
	    		score: score},
	    	complete: hide_id(this.id)
	    });

	    var gameID = $(".game_id").attr("data-game-id");
		$.ajax({
	    	url: "/update_select", type: "POST",
	    	//Pass in each variable as a parameter.
	    	data: { game_id: gameID,
	    		current_select: (select_active-1)}
	    });
	});

	function hide_id(id){
		element = $("#"+id)

		target_id = "score_select_" + (parseInt(element.attr("data-throw-id"))+1) + "_p" + element.attr("data-player-id")

		previous_select = "score_select_" + (parseInt(element.attr("data-throw-id"))-1) + "_p" + element.attr("data-player-id")

		var stop_iteration = false;

		remove_select(id)

		//Remove illegal scores from the second select in a frame if there isn't a strike and current frame isn't frame 20
		if(parseInt(element.attr("data-throw-id")) != 20) {
			if(parseInt(element.val()) != 10) {
				remove_invalid_options(target_id, id)
			}
		}

		if((parseInt(element.attr("data-throw-id"))+1) <= 18) {
			if(parseInt(element.attr("data-throw-id")) % 2 == 1) {
				if(parseInt(element.val()) == 10) {
					select_active = 0;
					turn_counter++;
					iterate_turn(turn_counter);
					stop_iteration = true;
				}
			}
		}

		if(parseInt(element.attr("data-throw-id")) == 20) {
			if(parseInt(element.val()) + parseInt($("#" + previous_select).text()) < 10) {
				select_active = 0;
				turn_counter++;
				iterate_turn(turn_counter);
				stop_iteration = true;
			}
		} 

		
		if (stop_iteration == false){
			count_selects(target);
		}
	}

	function remove_invalid_options(target_id, current_id){
		var target = "#" + target_id;
		var current = "#" + current_id;
		element = $(target);

		if(parseInt(element.attr("data-throw-id")) % 2 == 0) {
			$(target + " option").each(function(){
				option = $(this).val();
				past_score = $(current).attr("data-score-value");

			    if(parseInt(option) + parseInt(past_score) > 10){
			    	$(this).remove();
			    }
			});
		}
	}

	function remove_select(current_id){
		
		var current = "#" + current_id
		var score = $(current).val();
		$("#outer_" + current_id).empty().append("<div id='" + current_id + "' data-score-value='" + score + "'>" + score + "</div>");
	}
});
