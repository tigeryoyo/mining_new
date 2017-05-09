//角色权限配置js文件
function getCookie(name) {
	
	console.log(document.cookie);
	var arr =document.cookie.match(new RegExp("(^|)"+name+"=([^;]*)(;|$)"));
	if(arr !=null) 
		return unescape(arr[2]); 
	return null;
}

//得到角色包含的权限
function getIncludePowers(roleId){
	var count = 0;
	$.ajax({
		type:"POST",
		url:"/role/includePowersOfRole",
		data:{roleId:roleId},
		dataType:"json",
		beforeSend : function(){
            begin();
        },
        success : function(msg){
        	if(msg.status=="OK"){
				var powers = msg.result;
				count = powers.length;
				console.log(msg);
				$.each(powers,function(index,power){
					var row = ' <tr class="infor_tab02_tit"><td colspan="1" height="40" align="center" valign="middle" bgcolor="#ffffff"><input style=" width: 19px; height: 25px; padding: 0 0 5px 0;" type="checkbox" checked="checked" id="check_power">&nbsp;&nbsp;'+(index+1)+'</td><td colspan="3" height="40" align="center" valign="middle" bgcolor="#ffffff" >'+power.powerName+'</td></tr>';
					$('#role_power_tab').append(row);
				});
				
        	}else{
        		alert(msg.result);
        	}
        },
        complete : function(){
        	getNotIncludePowers(roleId,count);
            stop();
        },
		error: function(){
			alert("请求失败");
		}
	})
}
//得到角色不包含的权限
function getNotIncludePowers(roleId,index){
	$.ajax({
		type:"POST",
		url:"/role/notIncludePowersOfRole",
		data:{roleId:roleId},
		dataType:"json",
		beforeSend : function(){
            begin();
        },
        success : function(msg){
        	if(msg.status=="OK"){
				var powers = msg.result;
				console.log(msg);
				$.each(powers,function(idx,power){
					var row = ' <tr class="infor_tab02_tit"><td colspan="1" height="40" align="center" valign="middle" bgcolor="#ffffff"><input style=" width: 19px; height: 25px; padding: 0 0 5px 0;" type="checkbox" id="check_power">&nbsp;&nbsp;'+(idx+index+1)+'</td><td colspan="3" height="40" align="center" valign="middle" bgcolor="#ffffff" >'+power.powerName+'</td></tr>';
					$('#role_power_tab').append(row);
				})
        	}else{
        		alert(msg.result);
        	}
        },
        complete : function(){
			console.log("all")
            stop();
        },
		error: function(){
			alert("请求失败");
		}
	})
}
//权限显示
function showPowers(){
	var roleId = getCookie("id");
	getIncludePowers(roleId);
}

showPowers();


function changeRole(){
	var newId=getCookie("id");
	$.ajax({
		type:"post",
		url:"/role/updateRoleInfo",
		data:{
			roleId:newId,
			roleName:$(".roleChange").val(),
			powerName:''
		},
		dataType:"json",
		beforeSend : function(){
            begin();
        },
		success: function(msg){
			console.log(msg);
			if( msg.status == "OK"){
				alert("添加成功");
			}else{
				alert("fail");
			}
		},
		complete:function(){
            stop();
        },
		error: function(){
		    alert("请求失败");
		}
	})
}
function clearNewrole(){
	$("#new_name_role").val('');
}

//
$(function() {
    $("#check_all_power").click(function() {
        $('input[id="check_power"]').attr("checked",this.checked); 
    });
    var $subBox = $("input[id='check_power']");
    $subBox.click(function(){
        $("#check_all_power").attr("checked",$subBox.length == $("input[id='check_power']:checked").length ? true : false);
    });
});
