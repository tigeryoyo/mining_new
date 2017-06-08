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
				window.location.href = "/topic_list.html?issueType="
						+ issueType;
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