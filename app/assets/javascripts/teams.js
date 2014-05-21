// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
	$(".addChild").each(function(){
		$(this).click(function(){
			$(this).children().removeClass("glyphicon-plus");
			$(this).removeClass("btn-success").addClass("btn-info");
			$(this).children().addClass("glyphicon-ok");
		});
	});
});
	