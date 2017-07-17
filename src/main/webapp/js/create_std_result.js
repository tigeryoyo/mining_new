$(function() {
	// 阻止浏览器默认行。
	$(document).on({
		dragleave : function(e) { // 拖离
			e.preventDefault();
		},
		drop : function(e) { // 拖后放
			e.preventDefault();
		},
		dragenter : function(e) { // 拖进
			e.preventDefault();
		},
		dragover : function(e) { // 拖来拖去
			e.preventDefault();
		}
	});
	box = document.getElementById('drop_area'); // 拖拽区域
	box.addEventListener("drop", function(e) {
		e.preventDefault(); // 取消默认浏览器拖拽效果
//		console.log("before");
//		console.log(e.dataTransfer.files);
		var file = e.dataTransfer.files[0]; // 获取文件对象
		
		if (file.name.lastIndexOf("xls") !== -1
				|| file.name.lastIndexOf("xlsx") !== -1) {
			box.innerHTML=file.name;
			var fd = new FormData();
			fd.append("file", file);
			$("#create_std_result").one("click",function() {				
				createWithFile(fd);
			});
		} else {
			alert(file.name + " 不是Excel文件");
		}
	}, false);
	
	$("#create_std_result").one("click",function() {	
		alert("您没有上传准数据文件，将从上述泛数据生成准数据！");
		createWithoutFile();
	});
	
});

//从上传的准数据文件生成准数据 
function createWithFile(fd) {
	$.ajax({
		crossDomain : true,
		url : "/standardResult/createResWithFile",
		method : "POST",
		processData : false,
		contentType : false,
		dataType : "json",
		mimeType : "multipart/form-data",
		data : fd,
		beforeSend : function() {
			begin();
			},
		success : function(msg) {
			alert(msg.result);
		},
		complete : function() {
			stop();
			box.innerHTML="将文件拖拽到此处";
		},
		error : function() {
			alert("数据请求失败");
		}
	});
}
//没有上传准数据，对聚类后的数据生成准数据
function createWithoutFile() {
	$.ajax({
		crossDomain : true,
		url : "/standardResult/createResWithoutFile",
		method : "POST",
		processData : false,
		contentType : false,
		dataType : "json",		
		beforeSend : function() {
			begin();
			},
		success : function(msg) {
			alert(msg.result);
		},
		complete : function() {
			stop();
			box.innerHTML="将文件拖拽到此处";
		},
		error : function() {
			alert("数据请求失败");
		}
	});
}