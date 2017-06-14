//生成x数据，x=“准数据or核心数据”

//生成准数据
function sczsj() {
	var issueType = "standard";
	scxsj(issueType);
}

//生成核心数据
function schxsj(stdResId){
	var issueType = "core";
	scxsj(issueType,stdResId);
}

//生成x数据
function scxsj(issueType,stdResId){
	$.ajax({
		type : "post",
		url : "/issue/createIssueWithLink",
		data : {
			issueType : issueType,
			stdResId : stdResId
		},
		dataType : "json",
		beforeSend : function() {
			begin();
		},
		success : function(msg) {
			if (msg.status == "OK") {
				// var value = prompt("请输入准数据名：");
				// return value;
				setCookie_issueType(issueType);
				baseAjax("topic_list");
			} else {
				alert(msg.result);
			}
		},
		complete : function() {
			stop();
		},
		error : function() {
			console.log("ERROR");
		}
	});
}

function setCookie_issueType(value){
	var Days = 1; // 此 cookie 将被保存 1 天
	var exp　= new Date();
	exp.setTime(exp.getTime() +Days*24*60*60*1000);
	document.cookie = "issueType="+ escape (value) + ";expires=" + exp.toGMTString();
}

function ckfsj(issueId){
	alert("查看泛数据");
}

function ckzsj(issueId){
	alert("查看准数据");
}

function ckhxsj(issueId){
	alert("查看核心数据");
}

function ckxsj(issueId){
}