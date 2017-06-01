//生成x数据，x=“准数据or核心数据”

//生成准数据
function sczsj() {
	var issueType = "standard";
	scxsj(issueType);
}

//生成x数据
function scxsj(issueType){
	$.ajax({
		type : "post",
		url : "/issue/createIssueWithLink",
		data : {
			issueType : issueType
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

function getCookie(name) {
	var arr = document.cookie
			.match(new RegExp("(^|)" + name + "=([^;]*)(;|$)"));
	if (arr != null)
		return unescape(arr[2]);
	return null;
}