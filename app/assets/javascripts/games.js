$(document).ready(function(){

	$("#add_player_submit").on("click", function(){
		//On change, trigger this function
		//$("#airline_select, #origin_select, #dest_select, #price_select, #select_date, #min_seats").on("change",function(){
			//Load all select's values into variables
			var name = $("#player_name").val();
			var team = $('input[name=team]:checked', '#add_player').val();
			var game_id = $("#add_player").attr("data-game-id");
			
			//Fire an AJAX call to flights/filter
		    $.ajax({
		    	url: "/add_player", type: "POST",
		    	//Pass in each variable as a parameter.
		    	data: { name: name, 
		    		team: team, 
		    		game_id: game_id},
		    	success: clear_name
		    });
		//});
		//alert("meow");
	});

	function clear_name(){
		//alert("meow");
		$("#player_name").val("");
	}

	$("#load").on("click", function(){
		var game_id = $("#game_id").val();

		var response = "";
		$.ajax({
		    	url: "/games/game_exists", type: "GET",
		    	//Pass in each variable as a parameter.
		    	data: {game_id: game_id},
		    	//On complete, execute check_game
		    	complete: check_game
		});
	});

	function check_game(event, xhr){
		//event is a passed in variable from jquery .ajax, defined under complete: http://api.jquery.com/ajaxcomplete/
		var game_valid = event.responseText;

		//Extract the game_id from the input text box
		var game_id = $("#game_id").val();

		// If the response is 'valid'
		if (game_valid === "valid") {
			//Execute fetch_game
			fetch_game(game_id)
		}
		else {
			// Otherwise, update the dom with a notice
			$('#game_exists').empty().append("<h3> Game not Found, Try Again </h3>");
			// And clear the game_id input
			$("#game_id").val("");
		}
	}

	function fetch_game(game_id){
		// Link the user to the play page with the proper game_id
		window.location.href = "/games/play?game_id=" + game_id
	}
});
