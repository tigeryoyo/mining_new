/**
 * Created by Administrator on 2016/12/18.
 */
function historyRecord() {
	$
			.ajax({
				type : "post",
				url : "/result/queryResultList",
				beforeSend : function() {
					begin();
				},
				success : function(msg) {
					$('.summary_up table tr:not(:first)').html('');
					if (msg.status === 'OK') {
						var items = msg.result;
						$
								.each(
										items,
										function(i, item) {
											rows = '<tr><td height="32" align="center"><a href="javascript:;" onclick="historyData(\''
													+ item.rid
													+ '\')">'
													+ item.comment
													+ '</a></td><td height="32" align="center">'
													+ item.creator
													+ '</td><td height="32" align="center">'
													+ new Date(
															item.createTime.time)
															.format('yyyy-MM-dd hh:mm:ss')
													+ '</td><td height="32" align="center"><img src="images/reset.png" id="'
													+ item.rid
													+ '" onclick="historyReset()" /> <img src="images/delete.png" id="'
													+ item.rid
													+ '" onclick="historyDel()" /></td></tr>'
											$('.summary_up table').append(rows);
										});
					}
				},
				complete : function() {
					stop();
				},
				error : function(msg) {
					alert("数据请求失败");
				}
			});
}
historyRecord();

function historyData(rid) {
	$.ajax({
		type : "post",
		url : "/result/getCountResult",
		data : {
			resultId : rid
		},
		dataType : "json",
		beforeSend : function() {
			begin();
		},
		success : function(msg) {
			$('.summary_tab table tr:not(:first)').html('');
			if (msg.status == "OK") {
				// alert("删除成功");
				var items = msg.result;

				var indexOfTitle = parseInt(items[0][0]) + 1;
				var indexOfUrl = parseInt(items[0][1]) + 1;
				var indexOfTime = parseInt(items[0][2]) + 1;
				for (var i = 0; i < items.length - 1; i++) {
					// items第一行存储index，故从i+1读起
					item = items[i + 1];
					rows = '<tr><td height="32" align="center"><input type="checkbox" style="width:20px;height:20px" class="'
							+ i
							+ '"/></td><td height="32" align="center"><a href="javascript:;" onclick="showClusterDetails('
							// + item[indexOfUrl]
							// + '
							+ i
							+ ',\''
							// + item[indexOfUrl]
							+ rid
							+ '\','
							+ item[0]+')">'
							+ item[indexOfTitle]
							+ '</a></td><td height="32" align="center">'
							+ item[indexOfTime]
							+ '</td><td height="32" align="center">'
							+ '<a href="javascript:;" onclick="toPaint('
							+ i
							+ ',\''
							+ item[indexOfTitle]
									.replace(/\"/g, " ").replace(/\'/g,
											" ")
							+ '\')">'
							+ item[0]
							+ '</a>' + '</td></tr>';
					$('.summary_tab table').append(rows);

				}
			} else {
				alert(msg.result);
			}
		},
		complete : function() {
			stop();
		},
		error : function(msg) {
			alert(msg.result);
		}
	})
}

function showClusterDetails(index,rid,count){
	var url = '';
	console.log(rid);
//	var title = '';
//	var time = '';
	$.ajax({
		type : "post",
		url : "/result/getClusterResult",
		data : {
			clusterIndex : index,
			resultId : rid
		},
		dataType : "json",
		async: false,//同步
		beforeSend : function() {
			begin();
		},
		success : function(msg) {
			if (msg.status == "OK") {
				var items = msg.result;
				var indexOfUrl = parseInt(items[0][1]);// + 1
				if(items == null || items.length == 0){
					alert('没有记录');
					return;
				}else if(items.length == 1){
					url = items[i + 1][indexOfUrl];
					return;
				}
				var indexOfTitle = parseInt(items[0][0]) ;//+ 1				
				var indexOfTime = parseInt(items[0][2]) ;//+ 1
				
				$('.details_tab table tr:not(:first)').remove();
				for (var i = 0; i < items.length - 1; i++) {
					// items第一行存储index，故从i+1读起
					item = items[i + 1];
					url = item[indexOfUrl];
					rows = '<tr><td height="32" align="center"><input type="checkbox" style="width:20px;height:20px" class="'
						+ i
						+ '"/></td><td height="32" align="center"><a href="'
						+ item[indexOfUrl]
						+ '" target="blank">'
						+ item[indexOfTitle]
						+ '</a></td><td height="32" align="center">'
						+ item[indexOfTime]
						+ '</td><td height="32" align="center">'
						+ '<img src="images/user_del.png" class="delUser"  id="'
						+item[0]
						+'"  /></td></tr>';
				$('.details_tab table').append(rows);
				//将类的id作为table的id
				$('.details_tab table').attr('id',index);
				}
			}else{
				alert(msg.result);
			}
		},
		complete : function() {
			stop();
		},
		error : function(msg) {
			alert(msg.result);
		}
	});
	//类中只有一个元素直接打开url
	if(url != '' && count == 1){
		window.open(url);
	}else{
		 $('#code').center();
	     $('#goodcover').show();
	     $('#code').fadeIn();
	}
}

function buildStandardData(){
	$.ajax({
		type : "post",
		url: "/issue/create"
	});
}


/* 删除 */
function historyDel() {
	$(".summary_up table tr").unbind('click').on("click", "img", function() {
		var result_id = $(this).attr("id");
		console.log(result_id);
		fileDel(result_id);
		function fileDel(result_id) {

			$.ajax({
				type : "post",
				url : "/result/delResultById",
				data : {
					resultId : result_id
				},
				dataType : "json",
				success : function(msg) {
					console.log(msg);
					if (msg.status == "OK") {
						historyRecord();
					} else {
						alert("fail");
					}
				},
				error : function() {
					alert("数据请求失败")
				}
			})
		}
	})
}

function toPaint(currentSet, title) {
	setCookie('currentSet', currentSet);
	setCookie('title', title);
	window.location.href = "/data_results.html";
}

function historyReset() {
	$(".summary_up table tr").unbind('click').on("click", "img", function() {
		var result_id = $(this).attr("id");
		console.log(result_id);
		$.ajax({
			type : "post",
			url : "/result/resetResultById",
			data : {
				resultId : result_id
			},
			dataType : "json",
			success : function(msg) {
				if (msg.status == "OK") {
					freshData();
				} else {
					alert("合并失败");
				}
			},
			error : function() {
				alert("请求失败");
			}
		})
	})
}

/* 合并 */
function addLayData() {
	var sets = [];
	$(".summary_tab input:checked").each(function(i) {
		sets.push($(this).attr('class'));
	});
	console.log(sets);
	$.ajax({
		type : "post",
		url : "/result/combineSets",
		data : JSON.stringify(sets),
		dataType : "json",
		contentType : "application/json",
		success : function(msg) {
			if (msg.status == "OK") {
				freshData();
			} else {
				alert(msg.result);
			}
		},
		error : function() {
			alert("数据请求失败");
		}
	});
}

function freshData() {
	$.ajax({
		type : "post",
		url : "/result/getCountResult",
		beforeSend : function() {
			begin();
		},
		success : function(msg) {
			$('.summary_tab table tr:not(:first)').html('');
			if (msg.status == "OK") {
				// alert("删除成功");
				var items = msg.result;
				console.log(items);

				var indexOfTitle = parseInt(items[0][0]) + 1;
				var indexOfUrl = parseInt(items[0][1]) + 1;
				var indexOfTime = parseInt(items[0][2]) + 1;
				for (var i = 0; i < items.length - 1; i++) {
					// items第一行存储index，故从i+1读起
					item = items[i + 1];
					console.log(item);
					rows = '<tr><td height="32" align="center"><input type="checkbox" style="width:20px;height:20px" class="'
							+ i
							+ '"/></td><td height="32" align="center"><a href="'
							+ item[indexOfUrl]
							+ '" target="_blank">'
							+ item[indexOfTitle]
							+ '</a></td><td height="32" align="center">'
							+ item[indexOfTime]
							+ '</td><td height="32" align="center">'
							+ '<a href="javascript:;" onclick="toPaint('
							+ i
							+ ',\''
							+ item[indexOfTitle]
									.replace(/\"/g, " ").replace(/\'/g,
											" ")
							+ '\')">'
							+ item[0]
							+ '</a>' + '</td></tr>';
					$('.summary_tab table').append(rows);

				}
			} else {
				alert(msg.result);
			}
		},
		complete : function() {
			stop();
		},
		error : function() {
			alert("数据请求失败");
		}
	});
}

/* 删除 */
function deleteLayData() {
	var sets = [];
	$(".summary_tab input:checked").each(function(i) {
		sets.push($(this).attr('class'));
	});
	console.log(sets);
	$.ajax({
		type : "post",
		url : "/result/deleteSets",
		data : JSON.stringify(sets),
		dataType : "json",
		contentType : "application/json",
		success : function(msg) {
			if (msg.status == "OK") {
				freshData();
			} else {
				alert(msg.result);
			}
		},
		error : function() {
			alert("数据请求失败");
		}
	});
}

/* 删除 类中某些元素*/
function deleteClusterItem() {
	var sets = [];
	$(".details_tab input:checked").each(function(i) {
		sets.push($(this).attr('class'));
	});
	console.log(sets);
	$.ajax({
		type : "post",
		url : "/result/deleteClusterItems",
		data : {
			clusterIndex: $('.details_tab table').attr('id'),
			ItemIdSets: JSON.stringify(sets),
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

//全选所有聚类历史结果
$(function() {
	$("#historyAll").click(function() {
		if (this.checked) {
			$(".summary_tab tr :checkbox").prop("checked", true);
		} else {
			$(".summary_tab tr :checkbox").prop("checked", false);
		}
	})
})

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