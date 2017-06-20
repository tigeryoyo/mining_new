// JavaScript Document
//3.1任务详情展示

issueType = "";
function dataShow() {
	var issueId = getCookie("issueId");
	issueType = getCookie("issueType");
	if (issueType == "extensive") {
		showExtensiveIssueDetails(issueId);
	} else if (issueType == "standard") {
		showStandardIssueDetails(issueId);
	} else if (issueType == "core") {
		showCoreIssueDetails(issueId);
	} else {
		alert("error:dataShow.js-->dataShow()")
	}
}
dataShow();

function showExtensiveIssueDetails(issueId) {
	$.ajax({
		type : "post",
		url : "/file/queryIssueFiles",
		data : {
			issueId : issueId
		},
		dataType : "json",
		success : function(msg) {
			if (msg.status == "OK") {
				var items = msg.result.issue;
				$('.issueName').text("任务名称：" + items.issueName);
				var tabs = msg.result.list;
				$('.up_list tr:not(:first)').html("");
				$.each(tabs, function(i, item) {
					row = '<tr><td height="40" align="center" valign="middle">' + (i + 1) + '</td><td align="center" valign="middle">' + item.fileName + '</td><td align="center" valign="middle">'
						+ item.creator + '</td><td align="center" valign="middle">' + new Date(item.uploadTime.time).format('yyyy-MM-dd hh:mm:ss')
						+ '</td><td align="center" valign="middle"><img src="images/julei.png" class="btn_sc" onClick=clusterSingleFile("' + item.fileId + '") />'
						+ '<img src="images/xiazai.png" class="btn_sc" onclick=downloadExtFile("' + item.fileId + '","' + item.fileName + '") /><img class="btn_jl" src="images/delete.png" id="'
						+ item.fileId + '" onclick="bind()" /></td></tr>'
					$('.up_list').append(row);
				});
			} else {
				alert(msg.result);
			}

		},
		error : function() {
			alert("error:datashow.js-->showExtensiveIssueDetails(issueId)")
		}
	});
}

function showStandardIssueDetails(issueId) {
	$.ajax({
		type : "post",
		url : "/standardResult/queryStandardResults",
		data : {
			issueId : issueId
		},
		dataType : "json",
		success : function(msg) {
			if (msg.status == "OK") {
				var items = msg.result.issue;
				$('.issueName').text("任务名称：" + items.issueName);
				var stdResList = msg.result.stdResList;
				$('.up_list tr:not(:first)').html("");
				$.each(stdResList, function(i, item) {
					var stdResId = "'" + item.stdRid + "'";
					if(i==0){
						//把当前的准数据id存入cookie中
						var value = item.stdRid;
						var cookie_name1="stdResId";
						var Days = 1; // 此 cookie 将被保存 1 天
						var exp　= new Date();
						exp.setTime(exp.getTime() +Days*24*60*60*1000);
						document.cookie = cookie_name1 +"="+ escape (value) + ";expires=" + exp.toGMTString();
		     		}
					row = '<tr><td height="40" align="center" valign="middle">' + (i + 1) + '</td><td align="center" valign="middle">' + item.resName + '</td><td align="center" valign="middle">'
						+ item.creator + '</td><td align="center" valign="middle">' + new Date(item.createTime.time).format('yyyy-MM-dd hh:mm:ss')
						+ '</td><td align="center" valign="middle"><img src="images/xiazai.png" class="btn_sc" onclick=downloadStdRes(' + stdResId
						+ ') /><img class="btn_sc" src="images/schxsj.png" onclick=schxsj('+ stdResId
						+ ') /><img class="btn_sc" src="images/delete.png" onclick=deleteStandardResult(' + stdResId + ') /></td></tr>'
					$('.up_list').append(row);
				});
			} else {
				alert("查询失败");
			}

		},
		error : function() {
			alert("error:datashow.js-->showExtensiveIssueDetails(issueId)")
		}
	});
}

function test(test)
{
	console.log("sss");
	}

function getCookie(name) {
	var arr =document.cookie.match(new RegExp("(^|)"+name+"=([^;]*)(;|$)"));
	if(arr !=null) 
		return unescape(arr[2]); 
	return null;
}

function showCoreIssueDetails(issueId) {
	$.ajax({
		type : "post",
		url : "/coreResult/queryCoreResults",
		data : {
			issueId : issueId
		},
		dataType : "json",
		success : function(msg) {
			if (msg.status == "OK") {
				var items = msg.result.issue;
				$('.issueName').text("任务名称：" + items.issueName);
				var coreResList = msg.result.coreResList;
				$('.up_list tr:not(:first)').html("");
				$.each(coreResList, function(i, item) {
					var coreResId = "'" + item.coreRid + "'";
					row = '<tr><td height="40" align="center" valign="middle">' + (i + 1) + '</td><td align="center" valign="middle">' + item.resName + '</td><td align="center" valign="middle">'
						+ item.creator + '</td><td align="center" valign="middle">' + new Date(item.createTime.time).format('yyyy-MM-dd hh:mm:ss')
						+ '</td><td align="center" valign="middle"><img src="images/xiazai.png" class="btn_sc" onclick=downloadCoreRes(' + coreResId
						+ ') /><img class="btn_sc" src="images/delete.png" onclick=deleteCoreResult(' + coreResId + ') /></td></tr>'
					$('.up_list').append(row);
				});

			} else {
				alert("查询失败");
			}

		},
		error : function() {
			alert("error:datashow.js-->showExtensiveIssueDetails(issueId)")
		}
	});
}

function downloadExtFile(fileId, fileName) {
	var form = $('<form method="POST" action="/file/downloadExtFile">');
	form.append($('<input type="hidden" name="fileId" value="' + fileId + '"/>'));
	form.append($('<input type="hidden" name="fileName" value="' + fileName + '"/>'));
	$('body').append(form);
	form.submit(); // 自动提交
}

function deleteStandardResult(stdResId) {
	$.ajax({
		type : "post",
		url : "/standardResult/delete",
		data : {
			stdResId : stdResId
		},
		dataType : "json",
		success : function(msg) {
			if (msg.status == "OK") {
				showStandardIssueDetails(msg.result.issueId);
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
	})
}

function deleteCoreResult(coreResId) {
	$.ajax({
		type : "post",
		url : "/coreResult/delete",
		data : {
			coreResId : coreResId
		},
		dataType : "json",
		success : function(msg) {
			if (msg.status == "OK") {
				showCoreIssueDetails(msg.result.issueId);
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
	})
}

function downloadStdRes(stdResId) {
	var form = $('<form method="POST" action="/standardResult/download">');
	form.append($('<input type="hidden" name="stdResId" value="' + stdResId + '"/>'));
	$('body').append(form);
	form.submit(); // 自动提交
}

function downloadCoreRes(coreResId) {
	var form = $('<form method="POST" action="/coreResult/download">');
	form.append($('<input type="hidden" name="coreResId" value="' + coreResId + '"/>'));
	$('body').append(form);
	form.submit(); // 自动提交
}

//隐藏贴标签按钮
function hidelabel()
{
	$('attach_label').hide();
}

function localRefresh() {
	var newId = getCookie("issueId");
	if (issueType == "extensive") {
		showExtensiveIssueDetails(newId);
	} else if (issueType == "standard") {
		showStandardIssueDetails(newId);
	} else if (issueType == "core") {

	} else {
		alert("error:datashow.js-->localRefresh()")
	}
}
/*
function getCookie(name) {
	var arr = document.cookie.match(new RegExp("(^|)" + name + "=([^;]*)(;|$)"));
	if (arr != null)
		return unescape(arr[2]);
	return null;
}*/

function clusterSingleFile(id) {
	$.ajax({
		type : "post",
		url : "/issue/miningSingleFile",
		data : {
			fileId : id
		},
		dataType : "json",
		beforeSend : function() {
			begin();
		},
		success : function(msg) {
			console.log(msg);
			if (msg.status == "OK") {
				baseAjax("history");
			} else {
				alert(msg.result);
			}
		},
		error : function() {
			alert("请求失败");
		},
		complete : function() {
			stop();
		}
	})
}

function bind() {
	$(".up_list tr").unbind('click').on("click", ".btn_jl", function() {
		var file_id = $(this).attr("id");
		$.ajax({
			type : "post",
			url : "/file/deleteFileById",
			data : {
				fileid : file_id
			},
			dataType : "json",
			success : function(msg) {
				if (msg.status == "OK") {
					localRefresh();
				} else {
					alert(msg.result);
				}
			},
			error : function() {
				alert("数据请求失败");
			}
		})
	})
}