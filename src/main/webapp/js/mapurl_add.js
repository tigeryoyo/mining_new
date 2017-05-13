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
	var box = document.getElementById('drop_area'); // 拖拽区域
	box.addEventListener("drop", function(e) {
		e.preventDefault(); // 取消默认浏览器拖拽效果
		var file = e.dataTransfer.files[0]; // 获取文件对象
		console.log(file);
		if (file.name.lastIndexOf("xls") !== -1
				|| file.name.lastIndexOf("xlsx") !== -1) {
			var fd = new FormData();
			fd.append("file", file);
			$("#submitUpload").click(function() {
				submit(fd);
			});
			console.log("excel");
		} else {
			alert(file.name + " 不是Excel文件");
		}
	}, false);
});

function submit(fd) {
	$.ajax({
		async : false,
		crossDomain : true,
		url : "/website/importMapUrl",
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
			if (msg.status == 'OK') {
				alert('导入成功！');
			} else {
				alert('导入失败！');
				console.log("no ok");
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