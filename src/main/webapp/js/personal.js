/**
 *  账号管理js文件
**/
//个人信息显示
function personalInforShow(){
	$.ajax({
		type:"GET",
		url:"/personal/getCurrentUserInfo",
		data:{
			userName:"chenghu"
		},
		dataType:"json",
		beforeSend : function(){
			begin();
		},
		success : function(msg){
			if( msg.status == "OK"){
				alert(msg.result.user);
				var user = msg.result.user;
				$("#new_userName").val(user.userName);
				$("#new_trueName").val(user.trueName);
				$("#new_telephone").val(user.telphone);
				$("#new_email").val(user.email);
			}else{
				alert(msg.result);
			}
		},
		complete : function(){
			stop();
		},
		error : function(){
			alert("数据请求失败");
		},
	})
		
}

personalInforShow();

function clearUserInfor(){
	$("#new_userName").val('');
	$("#new_trueName").val('');
	$("#new_telephone").val('');
	$("#new_email").val('');
}
//个人信息修改
function personalInforChange(){
	
}