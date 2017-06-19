// JavaScript Document
//用户信息展示
function roleInforShow(page){
	search_click=false;
	$.ajax({
		type:"post",
		url:"/role/selectAllRole",
		data:{
			start:(parseInt(10*page-10)),
			limit:10
		},
		dataType:"json",
		success: function(msg){
			if(msg.status=="OK"){
				var items=msg.result;
				var cookie_value1;
				var cookie_value2;
				$('#role_infor_tab tr:not(:first)').html("");
				
				$.each(items,function(idx,item){
					cookie_value1="'"+item.roleId+"'";
					cookie_value2="'"+item.roleName+"'";
					row = '<tr><td width="169" height="30" align="center" bgcolor="#ffffff">'+((page-1)*10+idx+1)+'</td><td width="231" height="30" align="center" bgcolor="#ffffff">'+item.roleName+'</td><td colspan="2" width="140" height="30" align="center" bgcolor="#ffffff"><button type="button" class="btn btn-primary" onClick="setCookie('+cookie_value1+','+cookie_value2+')">编辑</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-danger delRole" id="'+item.roleId+'">删除</button></td></tr>'
					$('#role_infor_tab').append(row);
				});
			}else{
				$('#role_infor_tab tr:not(:first)').html("");
			}
		},
		complete : function(){
			console.log("all")
        },
		error: function(){
			alert("请求失败");
		}
	})	
}
function initShowPage(currenPage){
    var listCount = 0;
    if("undefined" == typeof(currenPage) || null == currenPage){
        currenPage = 1;
    }
    $.ajax({
        type: "post",
        url: "/role/selectRoleInfoCount",
		dataType:"json",
        success: function (msg) {
            if (msg.status == "OK") {
                // alert("success");
                listCount = msg.result;
                $("#page").initPage(listCount,currenPage,roleInforShow);
            } else {
                alert(msg.result);
            }
        },
        error: function () {
            alert("数据请求失败");
        }})
}

initShowPage(1)

function initSearchPage(currenPage){
    var listCount = 0;
    if("undefined" == typeof(currenPage) || null == currenPage){
        currenPage = 1;
    }
    var roleInfo = $("#searchRole").val();
    $.ajax({
        type: "post",
        url: "/role/selectRoleInfoCount",
        data:{
        	roleName:roleInfo
		},
        dataType: "json",
        success: function (msg) {
            if (msg.status == "OK") {
                // alert("success");
                listCount = msg.result;
                $("#page").initPage(listCount,currenPage,roleInforSearch);
            } else {
                alert(msg.result);
            }
        },
        error: function () {
            alert("数据请求失败");
        }})
}
function setCookie(value1,value2){
	// alert(name+value);
	var cookie_name1="id";
	var cookie_name2="role_name";
	var Days = 1; // 此 cookie 将被保存 1 天
	var exp　= new Date();
	exp.setTime(exp.getTime() +Days*24*60*60*1000);
	document.cookie = cookie_name1 +"="+ escape (value1) + ";expires=" + exp.toGMTString();
	document.cookie = cookie_name2 +"="+ escape (value2) + ";expires=" + exp.toGMTString();
	baseAjax("role_change");
}
/*

/!**
 * 根据页码加载数据
 * 
 * @param {整型}
 *            page 页码
 *!/
var search_click;
function setViewForPage(page){
	if(search_click){
		roleInforSearch(page);
	}else{
		roleInforShow(page);
	}
}
/!**
 * 省略号点击
 *!/
function setPageChangeView(){
	var bt_name=parseInt($("#other").attr('name'))+3;
	updatePageValue(bt_name);
	setViewForPage(bt_name);
	setFirstSelected();
	updateNowPage(bt_name);
}
/!**
 * 更新页码数据
 * 
 * @param {Object}
 *            base_num
 *!/
function updatePageValue(base_num){
	var p1=parseInt(base_num);
	var p2=parseInt(base_num)+1;
	var p3=parseInt(base_num)+2;
	$("#p_1").val(p1);
	$("#p_2").val(p2);
	$("#p_3").val(p3);
	$("#other").attr('name',p1);
}
/!**
 * 页码点击
 * 
 * @param {Object}
 *            p_id 页码
 *!/
function pageNumClick(p_id){
	// background: #0e63ab;
    // color: #fff;
	var button=document.getElementById(p_id);
	var page=button.value;
	if(page!=undefined&&page.length>0){
		setViewForPage(page);
		updateNowPage(page);
		// $(this).addClass("cur").siblings().removeClass("cur");
		cleanAllSelected();
		button.style.background='#0e63ab';
		button.style.color='#FFFFFF';
	}
}
/!**
 * 设置第一个页码按钮为选中状态
 *!/
function setFirstSelected(){
	cleanAllSelected();
	$("#p_1").css("background","#0e63ab");
	$("#p_1").css("color","#FFFFFF");
}
function setSecondSelected(){
	cleanAllSelected();
	$("#p_2").css("background","#0e63ab");
	$("#p_2").css("color","#FFFFFF");
}
function setThirdSelected(){
	cleanAllSelected();
	$("#p_3").css("background","#0e63ab");
	$("#p_3").css("color","#FFFFFF");
}
/!**
 * 清除所有的选中状态
 *!/
function cleanAllSelected(){
	$("#p_1").css("background","#CCCCCC");
	$("#p_1").css("color","buttontext");
	$("#p_2").css("background","#CCCCCC");
	$("#p_2").css("color","buttontext");
	$("#p_3").css("background","#CCCCCC");
	$("#p_3").css("color","buttontext");
}
/!**
 * 上一页，下一页点击
 * 
 * @param {Object}
 *            action -1上一页，1下一页
 *!/
function changPageOne(action){
	var now_page=parseInt($("#down_page").attr('name'));
	var page=now_page+action;
	if(page>0){
		updateAllStyleAndData(page,action);
	}
}
/!**
 * 跳zhuan
 *!/
function changePage(){
	var page=$(".go_num").val();
	if(page!=undefined&&page.length>0){
		updateAllStyleAndData(page);
	}
}
function updateAllStyleAndData(page,action){
	updateNowPage(page);
	setViewForPage(page);
	if((page-1)%3==0){// 位置：第一个按钮 123 456 789
		setFirstSelected();
		if(action==1||action==undefined){// 点击下一页
			updatePageValue(page);
		}
	}else if(page%3==0){// 位置：第三个按钮
		setThirdSelected();
		if (action==-1||action==undefined) {// 点击上一页
			updatePageValue(page-2);
		}
	}else{// 位置：第二个按钮
		setSecondSelected();
		if(action==undefined){
			updatePageValue(page-1);
		}
	}
}
/!**
 * 更新当前页码
 * 
 * @param {Object}
 *            page 当前页
 *!/
function updateNowPage(page){
	$("#down_page").attr('name',page);
}
*/


// 信息搜索
function roleInforSearch(page){
	var roleInfo = $("#searchRole").val();
	search_click=true;
	setFirstSelected();
	$.ajax({
		type:"post",
		url:"/role/selectOneRoleInfo",
		data:{
			roleName:roleInfo,
			start:(parseInt(10*page)-10),
			limit:10
		},
		dataType:"json",
		success: function(msg){
			if( msg.status == "OK"){
				$('#role_infor_tab tr:not(:first)').html("");
				var items=msg.result;
				var cookie_value1;
				var cookie_value2;
				$.each(items,function(idx,item){
					cookie_value1="'"+item.roleId+"'";
					cookie_value2="'"+item.roleName+"'";
					row = '<tr><td width="169" height="30" align="center" bgcolor="#ffffff">'+((page-1)*10+idx+1)+'</td><td width="231" height="30" align="center" bgcolor="#ffffff">'+item.roleName+'</td><td colspan="2" width="140" height="30" align="center" bgcolor="#ffffff"><button type="button" class="btn btn-primary" onClick="setCookie('+cookie_value1+','+cookie_value2+')">编辑</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-danger delRole" id="'+item.roleId+'">删除</button></td></tr>'
					$('#role_infor_tab').append(row);
				});
			}else{
				$('#role_infor_tab tr:not(:first)').html("");
				alert("输入角色名有误，请重新输入");
				//roleInforShow(1)
			}
		},
		complete : function(){
			console.log("one")
            stop();
        },
		error: function(){
			alert("请求失败");
		}
	})	
}


// 用户添加
function roleInforAdd() {
	baseAjax("role_add");
}

function addRoleInfo(){
	console.log($(".addRole").val())
	$.ajax({
		type:"post",
		url:"/role/insertRoleInfo",
		data:{
			roleName:$(".addRole").val()
		},
		dataType:"json",
		beforeSend : function(){
            begin();
        },
		success: function(msg){
			if( msg.status == "OK"){
				baseAjax("role_infor");
			}else{
				alert(msg.result);
			}
		},
		complete:function(){
            stop();
        },
		error: function(){
		    alert("数据请求失败");
		}
	})
}

function clearRole(){
	$(".addRole").val('');
}

// 用户编辑
function getCookie(name) {
	
	console.log(document.cookie);
	var arr =document.cookie.match(new RegExp("(^|)"+name+"=([^;]*)(;|$)"));
	if(arr !=null) 
		return unescape(arr[2]); 
	return null;
}



//角色删除
$(function(){
	$("#role_infor_tab").on("click",".delRole",function(){
		var role_id = $(this).attr("id");
		var role_name = $(this).parents('tr').find("td").eq('1').text();
		
		if(role_name == "超级管理员"){
			alert('对不起，超级管理员角色不能被删除！');
			return;
		}
		if(role_name == "管理员"){
			alert('对不起，管理员角色不能被删除！');
			return;
		}
		roleInforDel(role_id);
		function roleInforDel(role_id){
			$.ajax({
				type:"post",
				url:"/role/deleteRoleInfoById",
				data:{
					roleId:role_id
				} ,
				dataType:"json",
				success:function(msg){
					if(msg.status=="OK"){
					    baseAjax("role_infor");
					}else{
						alert(msg.result);
					}
				},
				error: function(msg){
		            alert(msg.result);
		        }
			});
		}
	})
})