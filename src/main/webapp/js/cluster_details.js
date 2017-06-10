//全选类中所有元素
$(function() {
	$("#clusterItemAll").click(function() {
		if (this.checked) {
			$(".details_tab tr :checkbox").prop("checked", true);
		} else {
			$(".details_tab tr :checkbox").prop("checked", false);
		}
	})
})

/* 重置某类元素*/
function clusterItemsReset() {
	
	$.ajax({
		type : "post",
		url : "/result/deleteClusterItems",
		data : {
			clusterIndex: $('.details_tab table').attr('id'),
			ItemIdSets: sets,
		},
		dataType : "json",
		contentType : "application/json",
		success : function(msg) {
			if (msg.status == "OK") {
				freshData();
			} else {
				alert(msg.result);
			}
		},
		error : function(msg) {
			alert(msg.result);
		}
	});
}

function freshClusterData(clusterIndex){
	alert('刷');
}


//弹出框的样式
$(function() {
    // alert($(window).height());
    $('#closebt').click(function() {
        $('#code').hide();
        $('#goodcover').hide();
    });
	$('#goodcover').click(function() {
        $('#code').hide();
        $('#goodcover').hide();
    });
    /*
	 * var val=$(window).height(); var codeheight=$("#code").height(); var
	 * topheight=(val-codeheight)/2; $('#code').css('top',topheight);
	 */
    jQuery.fn.center = function(loaded) {
        var obj = this;
        body_width = parseInt($(window).width());
        body_height = parseInt($(window).height());
        block_width = parseInt(obj.width());
        block_height = parseInt(obj.height());

        left_position = parseInt((body_width / 2) - (block_width / 2) + $(window).scrollLeft());
        if (body_width < block_width) {
            left_position = 0 + $(window).scrollLeft();
        };

        top_position = parseInt((body_height / 2) - (block_height / 2));// +
																		// $(window).scrollTop());
        if (body_height < block_height) {
            top_position = 0 + $(window).scrollTop();
        };

        if (!loaded) {

            obj.css({
                'position': 'fixed'
            });
            obj.css({
                'top': ($(window).height() - $('#code').height()) * 0.5,
                'left': left_position
            });
            $(window).bind('resize', function() {
                obj.center(!loaded);
            });
            $(window).bind('scroll', function() {
                obj.center(!loaded);
            });

        } else {
            obj.stop();
            obj.css({
                'position': 'fixed'
            });
            obj.animate({
                'top': top_position
            }, 200, 'linear');
        }
    }

})