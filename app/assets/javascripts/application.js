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
	$.contextMenu({
		selector: ".contextMenu",
		items: {
			"lock":{name:"", icon:"lock"},
			"unlock":{name:"", icon:"unlock"},
			"remove":{name:"", icon:"trash"}
		},
		callback:function(key, options){
			var id = $(this).attr('id').substr(16);
			if (key == "lock"){
				$.ajax({
					type:"PUT",
					dataType:"script",
					url:"/shopping_lists/"+id+"/lock"
				});
			} else if (key == "unlock"){
				$.ajax({
					type:"PUT",
					dataType:"script",
					url:"/shopping_lists/"+id+"/unlock"
					});
			} else if (key == "remove"){
				$.ajax({
					type:"DELETE",
					dataType:"script",
					data: {'action':'delete'},
					url:"/shopping_lists/"+id
				});
			} else {
			}
		}
	});
	$.event.special.hoverintent = {
		setup: function() {
			$( this ).bind( "mouseover", jQuery.event.special.hoverintent.handler );
		},
		teardown: function() {
			$( this ).unbind( "mouseover", jQuery.event.special.hoverintent.handler );
		},
		handler: function( event ) {
			var currentX, currentY, timeout,
				args = arguments,
				target = $( event.target ),
				previousX = event.pageX,
				previousY = event.pageY;
 
			function track( event ) {
				currentX = event.pageX;
				currentY = event.pageY;
			};
 
			function clear() {
				target
					.unbind( "mousemove", track )
					.unbind( "mouseout", clear );
				clearTimeout( timeout );
			}
 
			function handler() {
				var prop,
					orig = event;
 
				if ( ( Math.abs( previousX - currentX ) +
						Math.abs( previousY - currentY ) ) < 7 ) {
					clear();
 
					event = $.Event( "hoverintent" );
					for ( prop in orig ) {
						if ( !( prop in event ) ) {
							event[ prop ] = orig[ prop ];
						}
					}
					// Prevent accessing the original event since the new event
					// is fired asynchronously and the old event is no longer
					// usable (#6028)
					delete event.originalEvent;
 
					target.trigger( event );
				} else {
					previousX = currentX;
					previousY = currentY;
					timeout = setTimeout( handler, 300 );
				}
			}
 
			timeout = setTimeout( handler, 300 );
			target.bind({
				mousemove: track,
				mouseout: clear
			});
		}
	};

	$(".accordion").accordion({
		event: "click hoverintent"
	});
});
