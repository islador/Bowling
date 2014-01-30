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

		//alert("Previous: " + previous_select + ", Current: " + id + ", Target: " + target_id)
		if(parseInt(element.attr("data-throw-id")) != 20) {
			if(parseInt(element.val()) != 10) {
				remove_invalid_options(target_id, id)
			}
		}

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

	function remove_invalid_options(target_id, current_id){
		var target = "#" + target_id;
		var current = "#" + current_id;
		element = $(target);
		//alert(target);
		//$(target + " option[value='10']").remove();
		//$("#" + target_id + " option[value='10']").remove();
		//alert(element.attr("data-throw-id"));
		//alert(element.attr("data-throw-id"));

		if(parseInt(element.attr("data-throw-id")) % 2 == 0) {
			//alert(element.attr("data-throw-id"));
			
			$(target + " option").each(function()
				{
					//alert("hai")
					option = $(this).val();
					past_score = $(current).val();
					//alert(option)
					//alert(this.val());
				    if(parseInt(option) + parseInt(past_score) > 10){
				    //	
				    	//alert("more")
				    	$(this).remove();
				    }
				    
				});
			//$(target + " option[value='10']").remove();
		}
	}
});
