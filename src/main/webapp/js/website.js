// JavaScript Document
//用户信息展示
function websiteInforShow(page) {
    search_click = false;
    $.ajax({
        type: "post",
        url: "/domain/selectDomain",
        data: {
            start: (parseInt(10 * page - 10)),
            limit: 10
        },
        dataType: "json",
        success: function (msg) {
            $('#domain_content').html("");
            if (msg.status == "OK") {
                // alert("success");
                var result = msg.result;
                var one = result.one;
                var two = result.two;
                $.each(one, function (idx, item) {
                    row = '<summary style="margin-bottom:10px;">'
                        + '<p data-id="'+item.uuid+'">'
                        + '<span style="width: 220px; min-height: 10px; display: inline; float: left;">'
                        + '<span class="glyphicon glyphicon-chevron-right" aria-label="true" style="float: left; padding: 1px 3px;"></span>'
                        + '<a href="http://'+item.url+'" target="_blank">'+item.url+'</a>'
                        + '</span>'
                        + '<span style="width: 170px;min-height: 10px; display: inline; float: left;">'+item.name+'</span>'
                        + '<span style="width: 110px;min-height: 10px; display: inline; float: left">'+item.rank+'</span>'
                        + '<span style="width: 100px;min-height: 10px; display: inline; float: left">'+item.weight+'</span>'
                        + '<span><a href="javascript:" style="margin: 2px 0px; text-decoration:underline" onclick="showOneDetails(this)">详情</a> <a href="javascript:" style="margin: 2px 0px;text-decoration:underline" onclick="delDomainOne(this)">删除</a></span>'
                        + '</p>'
                        + '</summary>';
                    $.each(two[idx],function(idx,item){
                        row +='<p data-id="'+item.uuid+'">'
                            + '<span style="width: 220px; min-height: 10px; display: inline; float: left;">'
                            + '<a href="http://'+item.url+'" target="_blank">----'+item.url+'</a>'
                            + '</span>'
                            + '<span style="width: 170px;min-height: 10px; display: inline; float: left;">'+item.name+'</span>'
                            + '<span style="width: 110px;min-height: 10px; display: inline; float: left">'+item.rank+'</span>'
                            + '<span style="width: 100px;min-height: 10px; display: inline; float: left">'+item.weight+'</span>'
                            + '<span><a href="javascript:" style="margin: 2px 0px; text-decoration:underline" onclick="showTwoDetails(this)">详情</a> <a href="javascript:" style="margin: 2px 0px;text-decoration:underline" onclick="delDomainTwo(this)">删除</a></span>'
                            + '</p>'
                    })
                    row = '<details style="font-size: 16px">'+row+'</details>';
                    $('#domain_content').append(row);
                });
            } else {
                alert(msg.result);
                $('#domain_content').html("");
            }
        },
        error: function () {
            alert("数据请求失败");
        },
    })
}
function initShowPage(currenPage) {
    var listCount = 0;
    if ("undefined" == typeof(currenPage) || null == currenPage) {
        currenPage = 1;
    }
    $.ajax({
        type: "post",
        url: "/domain/selectDomainCount",
        dataType: "json",
        success: function (msg) {
            if (msg.status == "OK") {
                // alert("success");
                listCount = msg.result;
                $("#page").initPage(listCount, currenPage, websiteInforShow);
            } else {
                //              console.log(msg.result);
            }
        },
        error: function () {
            alert("数据请求失败");
        }
    })
}
initShowPage(1)

function initSearchPage(currenPage) {
    var listCount = 0;
    if ("undefined" == typeof(currenPage) || null == currenPage) {
        currenPage = 1;
    }
    var obj2 = $("#web_name").val();
    var obj3 = $("#web_level").val();
    var obj4 = $("#web_type").val();
    $.ajax({
        type: "post",
        url: "/website/selectWebsiteCount",
        data: {
            url: $("#web_url").val(),
            name: obj2,
            // level:obj3,
            levle: obj3,
            type: obj4
        },
        dataType: "json",
        success: function (msg) {
            if (msg.status == "OK") {
                // alert("success");
                listCount = msg.result;
                $("#page").initPage(listCount, currenPage, websiteInforSearch);
            } else {
                alert(msg.result);
            }
        },
        error: function () {
            alert("数据请求失败");
        }
    })
}
function setCookie(value1, value2, value3, value4, value5) {
    // alert(name+value);
    var cookie_name1 = "id";
    var cookie_name2 = "websiteName";
    var cookie_name3 = "type";
    var cookie_name4 = "url";
    var cookie_name5 = "level";
    var Days = 1; // 此 cookie 将被保存 1 天
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    document.cookie = cookie_name1 + "=" + escape(value1) + ";expires=" + exp.toGMTString();
    document.cookie = cookie_name2 + "=" + escape(value2) + ";expires=" + exp.toGMTString();
    document.cookie = cookie_name3 + "=" + escape(value3) + ";expires=" + exp.toGMTString();
    document.cookie = cookie_name4 + "=" + escape(value4) + ";expires=" + exp.toGMTString();
    document.cookie = cookie_name5 + "=" + escape(value5) + ";expires=" + exp.toGMTString();
    baseAjax("website_change");
}


// 信息搜索
function websiteInforSearch(page) {
    search_click = true;
    // var obj1 = $("#web_url").val();
    var obj2 = $("#web_name").val();
    var obj3 = $("#web_level").val();
    var obj4 = $("#web_type").val();
    setFirstSelected();
    $.ajax({
        type: "post",
        url: "/website/selectByCondition",
        data: {
            url: $("#web_url").val(),
            name: obj2,
            // level:obj3,
            levle: obj3,
            type: obj4,
            start: (parseInt(10 * page - 10)),
            limit: 10
        },
        dataType: "json",
        success: function (msg) {
            if (msg.status == "OK") {
                // alert("success");
                $('.infor_tab02 tr:not(:first)').html("");
                var items = msg.result;
                var cookie_value1;
                var cookie_value2;
                var cookie_value3;
                var cookie_value4;
                var cookie_value5;
                $.each(items, function (idx, item) {
                    // alert(msg.tagName);
                    cookie_value1 = "'" + item.id + "'";
                    cookie_value2 = "'" + item.name + "'";
                    cookie_value3 = "'" + item.type + "'";
                    cookie_value4 = "'" + item.url + "'";
                    cookie_value5 = "'" + item.level + "'";
                    row = '<tr><td width="42" height="40" align="center" bgcolor="#ffffff">' + ((page - 1) * 10 + idx + 1) + '</td><td width="238" height="40" align="center" bgcolor="#ffffff"><div class="tab_url">' + item.url + '</div></td><td width="83" height="40" align="center" bgcolor="#ffffff">' + item.name + '</td><td width="76" height="40" align="center" bgcolor="#ffffff">' + item.level + '</td><td width="77" height="40" align="center" bgcolor="#ffffff">' + item.type + '</td><td width="150" height="40" align="center" bgcolor="#ffffff"><button type="button" class="btn btn-primary" onClick="setCookie(' + cookie_value1 + ',' + cookie_value2 + ',' + cookie_value3 + ',' + cookie_value4 + ',' + cookie_value5 + ')" >编辑</button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-danger delWebsite" id="' + item.id + '">删除</button></td></tr>';
                    $('.infor_tab02').append(row);
                });
            } else {
                $('.infor_tab02 tr:not(:first)').html("");
                alert(msg.result);
            }
        },
        error: function () {
            alert("数据请求失败");
        }
    })
}

// 用户添加
function websiteInforAdd() {
    baseAjax("website_add");
}
// 用户编辑
function getCookie(name) {

//	console.log(document.cookie);
    var arr = document.cookie.match(new RegExp("(^|)" + name + "=([^;]*)(;|$)"));
    if (arr != null)
        return unescape(arr[2]);
    return null;
}

//查看一级域名详细信息
function showOneDetails(e) {
	var uuid = $(e).parent().parent("p").attr("data-id");
    var minutes = 20; // 此 cookie 将被保存 20分钟
    var exp = new Date();
    exp.setTime(exp.getTime() + minutes * 60 * 1000);
    document.cookie = "domain_id" + "=" + escape(uuid) + ";expires=" + exp.toGMTString();
    baseAjax("website_one_details");
}

//查看二级域名详细信息
function showTwoDetails(e){
	var uuid = $(e).parent().parent("p").attr("data-id");
    var minutes = 20; // 此 cookie 将被保存 20分钟
    var exp = new Date();
    exp.setTime(exp.getTime() + minutes * 60 * 1000);
    document.cookie = "domain_id" + "=" + escape(uuid) + ";expires=" + exp.toGMTString();
    baseAjax("website_two_details");

}

//删除一级域名
function delDomainOne(e) {
	var uuid = $(e).parent().parent("p").attr("data-id");
    $.ajax({
        type:"post",
        url:"/domain/deleteDomainOne",
        data:{
            uuid:uuid
        },
        dataType: "json",
        success: function (msg) {
            if (msg.status == "OK") {
                alert(msg.result);
                baseAjax("website_infor");
            }else
                alert(msg.result);
        },
        error: function () {
            alert("数据请求失败");
        }

    })
}

//删除二级域名
function delDomainTwo(e) {
    var uuid = $(e).parent().parent("p").attr("data-id");
    $.ajax({
        type:"post",
        url:"/domain/deleteDomainTwo",
        data:{
            uuid:uuid
        },
        dataType: "json",
        success: function (msg) {
            if (msg.status == "OK") {
                alert(msg.result);
                baseAjax("website_infor");
            }else
                alert(msg.result);
        },
        error: function () {
            alert("数据请求失败");
        }

    })
}


// 用户删除
$(function () {
    $(".infor_tab02").on("click", ".delWebsite", function () {
        var website_id = $(this).attr("id");
//		console.log(website_id);
        websiteInforDel(website_id);
        function websiteInforDel(website_id) {
            $.ajax({
                type: "post",
                url: "/website/deleteWebsite",
                data: {
                    websiteId: website_id,
                },
                dataType: "json",
                success: function (msg) {
                    // alert("lll");
                    if (msg.status == "OK") {
                        baseAjax("website_infor");
                    } else {
                        alert(msg.result);
                    }
                },
                error: function () {
                    alert("数据请求失败");
                },
            });
        }
    })
})