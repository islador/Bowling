$(document).ready(function(){

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
		    	success: hide_id(this.id)
		    });
		//});
		//#alert(score + player_id + throw_id);
	});

	function hide_id(id){
		element = $("#"+id)

		target_id = "score_select_" + (parseInt(element.attr("data-throw-id"))+1) + "_p" + element.attr("data-player-id")

		previous_select = "score_select_" + (parseInt(element.attr("data-throw-id"))-1) + "_p" + element.attr("data-player-id")

		if((parseInt(element.attr("data-throw-id"))+1) <= 18) {
			if(parseInt(element.attr("data-throw-id")) % 2 == 1) {
				if(parseInt(element.val()) == 10) {
					$("#" + target_id).hide();
				}
			}
		}

		if(parseInt(element.attr("data-throw-id")) == 20) {
			if(parseInt(element.val()) + parseInt($("#" + previous_select).val()) < 10) {
				$("#"+ target_id).hide();
			}
		}	
	}
});
