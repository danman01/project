// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
 
$(function(){ 
		$("#flashy").click(function(event){
			$(this).animate(
				{right:-5000},
				/*was right -390*/
				{duration: 600,
				easing: "easeInBack"}
				)
		});
			
			var c = $("#flashy");  
			c.length&&setTimeout(function(event){
			c.animate(
			{right:-5000},
			{duration: 600,
			easing: "easeInBack"}
			)},6000);
			
});

