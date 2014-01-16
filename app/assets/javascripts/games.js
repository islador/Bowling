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
});
