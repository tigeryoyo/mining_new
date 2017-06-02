function addWebsite() {
	$.ajax({
		type : "post",
		url : "/website/insertWebsite",
		data : {
			url : $("#urlWebsite").val(),
			name : $("#nameWibsite").val(),
			levle : $("#levelWebsite").val(),
			type : $("#typeWebsite").val()
		},
		dataType : "json",
		beforeSend : function() {
			begin();
		},
		success : function(msg) {
			if (msg.status == "OK") {
				window.location.href = "/website_infor.html"
			} else {
				alert(msg.result);
			}
			stop();
			window.location.href = "website_infor.html";
		},
		error : function() {
			alert("数据请求失败");
		}
	})
}

function clearWebsite() {
	url: $("#urlWebsite").val('');
	name: $("#nameWibsite").val('');
	level: $("#levelWebsite").val('');
	type: $("#typeWebsite").val('');
}

function websiteInforChange() {
	var newId = getCookie("id");
	$.ajax({
		type : "post",
		url : "/website/updateWebsite",
		data : {
			id : newId,
			url : $("#new_url_website").val(),
			name : $("#new_name_website").val(),
			level : $("#new_level_website").val(),
			type : $("#new_type_website").val()
		},
		dataType : "json",
		beforeSend : function() {
			begin();
		},
		success : function(msg) {
			if (msg.status == "OK") {
				// alert("更新成功");
			} else {
				alert(msg.result);
			}
			stop();
			window.location.href = "unknow_website_infor.html";
		},
		error : function() {
			alert("数据请求失败");
		},
	})
}

function clearNewWebsite() {
	$("#new_url_website").val('');
	$("#new_name_website").val('');
	$("#new_level_website").val('');
	$("#new_type_website").val('');
}

function test(){
	console.log("webSiteName="+getCookie("websiteName"));
	console.log("webSiteUrl="+getCookie("url"));
}
test();

function getCookie(name) {
	var arr = document.cookie.match(new RegExp("(^|)" + name + "=([^;]*)(;|$)"));
	if (arr != null)
		return unescape(arr[2]);
	return null;
}
