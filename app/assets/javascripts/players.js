$(document).ready(function(){

	$("select[id^='score_select_']").on("change", function(){
			var score = $("#" + this.id).val();
			var player_id = $("#" + this.id).attr("data-player-id");
			var throw_id = $("#" + this.id).attr("data-throw-id");

			//alert(throw_id % 2)

			//Double the input score if there was a strike or spare previously
			if(throw_id % 2 != 0){
				var previous_score_id = "score_select_" + (throw_id-1) + "_p" + this.id.slice(this.id.length-1, this.id.length)
				var second_previous_score_id = "score_select_" + (throw_id-2) + "_p" + this.id.slice(this.id.length-1, this.id.length)
				var score1 = $("#" + previous_score_id).val();
				var score2 = $("#"+ second_previous_score_id).val();
				var total = parseInt(score1) + parseInt(score2)
				
				if((score1 != 10) && (total == 10)){
					//alert("Spare");
					score = score*2
					//alert("Spare")
				}
			}

			//Double the input score if their was a strike previously
			if(throw_id % 2 === 0){
				var second_previous_score_id = "score_select_" + (throw_id-3) + "_p" + this.id.slice(this.id.length-1, this.id.length)
				//alert(second_previous_score_id);
				var score2 = $("#"+ second_previous_score_id).val();
				if(parseInt(score2) == 10) {
					score = score * 2
					//alert("Strike Bonus")
				}
			}
			
			//Fire an AJAX call to /add_score
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

		//Check for a strike
		if((element.attr("data-throw-id") % 2 === 1) && (element.attr("data-throw-id") < 19) && (element.val() == 10)) {

			target_id = "score_select_" + (parseInt(element.attr("data-throw-id"))+1) + "_p" + id.slice(id.length-1, id.length)
			//alert(target_id)

			var score = 0;
			var player_id = $(element).attr("data-player-id");
			var throw_id = (parseInt(element.attr("data-throw-id"))+1);

			$.ajax({
		    	url: "/add_score", type: "POST",
		    	//Pass in each variable as a parameter.
		    	data: { player_id: player_id, 
		    		throw_id: throw_id, 
		    		score: score},
		    	success: hide_id(target_id)
		    });
			
			//alert(id + " Odd! Strike! " + id.charAt(13) + " " + target_id);
		}

		
		//alert(element.attr("data-throw-id"));
		//$("#player_name").val("");
	}
	function hide_id(id){
		$("#" + id).hide();
	}
});
