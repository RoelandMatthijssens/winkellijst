// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.ui.touch-punch.min
//= require jquery.contextMenu
//= require chosen-jquery
//= require_tree .

$(function(){
	$(document).on("click", "#item_table thead th a, #item_table .pagination a", function(){
		$.getScript(this.href);
		return false;
	});
	$('#item_search input').keyup(function () {
		$.ajax({
			url:$('#item_search').attr('action'),
			data:$('#item_search').serialize(),
			success:null,
			dataType:'script'
		});
		return false;
	});
	$('.chosen').chosen();
	$('.draggable').draggable({
		appendTo:"body",
		helper:"clone"
	});
	$('.droppable').droppable({
		activeClass:"droppable-active",
		hoverClass:"droppable-hover",
		drop:function(event, ui){
			var list_id = $(this).attr('id');
			var item_id = ui.draggable.attr('id').substr(5);
			$.ajax({
				type:"PUT",
				dataType: 'script',
				url:"/shopping_lists/"+list_id+"/drop",
				success:function(data){console.log("success");},
				data: "item_id="+item_id
			});
		}
	});
	$(".accordion").accordion();
	$.contextMenu({
		selector: ".contextMenu",
		items: {
			"lock":{name:"", icon:"lock"},
			"unlock":{name:"", icon:"unlock"}
		},
		callback:function(key, options){
			var id = $(this).attr('id').substr(16);
			if (key == "lock"){
				$.ajax({
					type:"PUT",
					dataType:"script",
					url:"/shopping_lists/"+id+"/lock"
				});
			} else {
				$.ajax({
					type:"PUT",
					dataType:"script",
					url:"/shopping_lists/"+id+"/unlock"
				});
			}
		}
	});
});
