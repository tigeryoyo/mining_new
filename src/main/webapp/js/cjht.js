/**
 * Created by Administrator on 2016/12/18.
 */
$(document).ready(function() {
	$(':radio').click(function() {
		if (this.checked) {
            $(this).parent().css("color","red");
            $(this).parent().siblings('label').css("color","black");
        }
	});
})

function creatInt() {
	var issueType = $("input[name='issueType']:checked").val();
	var title = $("#chuangjian").val().replace(" ", "");
	if (title === undefined || title == '') {
		alert("请输入任务名称");
		return;
	}
	$
			.ajax({
				type : "post",
				url : "/issue/create",
				data : {
					issueName : $("#chuangjian").val(),
					issueType : issueType,
				},
				dataType : "json",
				beforeSend : function() {
					begin();
				},
				success : function(msg) {
					console.log(msg);
					if (msg.status == "OK") {
						window.location.href = "topic_list.html?issueType="
								+ issueType;
					} else {
						alert("fail");
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
