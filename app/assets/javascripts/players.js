$(document).ready(function(){

	$("select[id^=score_select_").on("change", function(){
		//On change, trigger this function
		//$("#airline_select, #origin_select, #dest_select, #price_select, #select_date, #min_seats").on("change",function(){
			//Load all select's values into variables
			var score = $("#" + this.id).val();
			var player_id = $("#" + this.id).attr("data-player-id");
			var throw_id = $("#" + this.id).attr("data-throw-id");
			
			//Fire an AJAX call to flights/filter
		    $.ajax({
		    	url: "/add_score", type: "POST",
		    	//Pass in each variable as a parameter.
		    	data: { player_id: player_id, 
		    		throw_id: throw_id, 
		    		score: score},
		    	success: special_check(this.id)
		    });
		//});
		//#alert(score + player_id + throw_id);
	});

	function special_check(id){
		element = $("#"+id)

		if((element.attr("data-throw-id") % 2 === 1) && (element.attr("data-throw-id") < 19) && (element.val() == 10)) {
			
			target_id = "score_select_" + (parseInt(element.attr("data-throw-id"))+1) + "_p" + id.slice(id.length-2, id.length)
			$("#" + target_id).hide()

			//alert(id + " Odd! Strike! " + id.charAt(13) + " " + target_id);
			//alert(id + " Odd! Strike! " + id.charAt(13) + " " + target_id);
		}
		//alert(element.attr("data-throw-id"));
		//$("#player_name").val("");
	}
	function spare_check(){
		alert("bark");
		//$("#player_name").val("");
	}
});
