/**
 * Created by Administrator on 2016/12/18.
 */
// document.write('<script type="text/javascript"
// src="js/cluster_details.js"></script>');
function historyRecord() {
	$.ajax({
		type : "post",
		url : "/result/queryResultList",
		success : function(msg) {
			$('.summary_up table tr:not(:first)').html('');
			if (msg.status === 'OK') {
				var items = msg.result;
				$.each(items, function(i, item) {
					rows = '<tr><td height="32" align="center"><a href="javascript:;" onclick="historyData(\'' + item.rid + '\')">' + item.comment + '</a></td><td height="32" align="center">'
						+ item.creator + '</td><td height="32" align="center">' + new Date(item.createTime.time).format('yyyy-MM-dd hh:mm:ss')
						+ '</td><td height="32" align="center"><img src="images/reset.png" id="' + item.rid + '" onclick="historyReset()" /> <img src="images/delete.png" id="' + item.rid
						+ '" onclick="historyDel()" /></td></tr>'
					$('.summary_up table').append(rows);
				});
			}
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
					rows = '<tr><td height="32" align="center"><input type="checkbox" style="width:20px;height:20px" class="' + i
						+ '"/></td><td height="32" align="center"><a href="javascript:;" onclick="showClusterDetails('
						// + item[indexOfUrl]
						// + '
						+ i + ',\''
						// + item[indexOfUrl]
						+ rid + '\',' + item[0] + ')">' + item[indexOfTitle] + '</a></td><td height="32" align="center">' + item[indexOfTime] + '</td><td height="32" align="center">'
						+ '<a href="javascript:;" onclick="toPaint(' + i + ',\'' + item[indexOfTitle].replace(/\"/g, " ").replace(/\'/g, " ") + '\')">' + item[0] + '</a>' + '</td></tr>';
					$('.summary_tab table').append(rows);

				}
			} else {
				alert(msg.result);
			}
		},
		error : function(msg) {
			alert(msg.result);
		}
	})
}

function buildStandardData() {
	$.ajax({
		type : "post",
		url : "/issue/create"
	});
}

/* 删除历史记录 */
function historyDel() {
	$(".summary_up table tr").unbind('click').on("click", "img", function() {
		var result_id = $(this).attr("id");
		
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
	baseAjax("data_results");
}

function historyReset() {
	$(".summary_up table tr").unbind('click').on("click", "img", function() {
		var result_id = $(this).attr("id");
		
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
			error : function(msg) {
				alert(msg.result);
			}
		})
	})
}

/* 合并类簇 */
function addLayData() {
	var sets = [];
	$(".summary_tab input:checked").each(function(i) {
		sets.push($(this).attr('class'));
	});
	
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
		error : function(msg) {
			alert(msg.result);
		}
	});
}

function freshData() {
	$.ajax({
		type : "post",
		url : "/result/getCountResult",
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
					//console.log(item);
					rows = '<tr><td height="32" align="center"><input type="checkbox" style="width:20px;height:20px" class="' + i
						+ '"/></td><td height="32" align="center"><a href="javascript:;" onclick="showClusterDetails(' + i + ',\'' + $('.summary_up table tr img').attr("id") + '\',' + item[0] + ')">'
						+ item[indexOfTitle] + '</a></td><td height="32" align="center">' + item[indexOfTime] + '</td><td height="32" align="center">' + '<a href="javascript:;" onclick="toPaint(' + i
						+ ',\'' + item[indexOfTitle].replace(/\"/g, " ").replace(/\'/g, " ") + '\')">' + item[0] + '</a>' + '</td></tr>';
					$('.summary_tab table').append(rows);

				}
			} else {
				alert(msg.result);
			}
		},
		error : function(msg) {
			alert(msg.result);
		}
	});
}

/* 删除选中类簇 */
function deleteLayData() {
	var sets = [];
	$(".summary_tab input:checked").each(function(i) {
		sets.push($(this).attr('class'));
	});
	
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
		error : function(msg) {
			alert(msg.result);
		}
	});
}

// 全选所有聚类历史结果
$(function() {
	$("#historyAll").click(function() {
		if (this.checked) {
			$(".summary_tab tr :checkbox").prop("checked", true);
		} else {
			$(".summary_tab tr :checkbox").prop("checked", false);
		}
	})
})