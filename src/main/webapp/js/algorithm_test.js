/**
 * Created by Jack on 2017/6/2.
 */




//细节展示
function kmeans_detail() {
    $("#algorithm_detail").html("");
    var content = "k值：<input type='text' id='k_value'><br>粒度选择：<input type='radio' name='kmeans_size' value='1' checked='checked'> 粗粒度 <input type='radio' name='kmeans_size' value='2'> 细粒度";
    $("#algorithm_detail").append(content);
}

function canopy_detail() {
    $("#algorithm_detail").html("");
    var content = "阀值：<input type='text' id='c_value'> <br>粒度选择：<input type='radio' name='canopy_size' value='1' checked='checked'> 粗粒度 <input type='radio' name='canopy_size' value='2'> 细粒度 ";
    $("#algorithm_detail").append(content);
}

function dbscan_detail() {
    $("#algorithm_detail").html("");
    var content = "半径：<input type='text' id='radius'>最小数量：<input type='text' id='minNum'><br>粒度选择：<input type='radio' name='dbscan_size' value='1' checked='checked'> 粗粒度 <input type='radio' name='dbscan_size' value='2'> 细粒度 ";
    $("#algorithm_detail").append(content);
}

//选择算法时，显示对应的细节
function algorithmChange(){
    var alg = $("input[name='algorithm']:checked").val();
    if(alg == 1){
        kmeans_detail();
    }else if(alg == 2){
        canopy_detail();
    }else{
        dbscan_detail();
    }

}


//保存按钮点击事件
function conservationClick() {
    var alg = $("input[name='algorithm']:checked").val();
    if(alg == 1){
        kmeans_conservation();
    }else if(alg == 2){
        canopy_conservation();
    }else{
        dbscans_conservation();
    }
}


//聚类按钮点击事件
function clussterClick() {
    var alg = $("input[name='algorithm']:checked").val();
    if(alg == 1){
        kmeans_clusster();
    }else if(alg == 2){
        canopy_clusster();
    }else{
        dbscan_clusster();
    }
}

//聚类结果处理
/**
 * 根据ajax获取的参数items生成hmtl
 * @param items 聚类结果集
 */
function showMining(items){
    var indexOfTitle = parseInt(items[0][0]) + 1;
    var indexOfUrl = parseInt(items[0][1]) + 1;
    var indexOfTime = parseInt(items[0][2]) + 1;
    console.log(indexOfTitle);
    console.log(indexOfUrl);
    console.log(indexOfTime);
    for (var i = 0; i < items.length - 1; i++) {
        // items第一行存储index，故从i+1读起
        item = items[i + 1];
        console.log(item);
        rows = '<tr><td height="32" align="center"><input type="checkbox" style="width: 20px; height: 20px;" class="'
            + i
            + '"/></td><td height="32" align="center"><a href="'
            + item[indexOfUrl]
            + '" target="_blank">'
            + item[indexOfTitle]
            + '</a></td><td height="32" align="center">'
            + item[indexOfTime]
            + '</td><td height="32" align="center">'
            + '<a href="javascript:;" onclick="toPaint('
            + i
            + ',\''
            + item[indexOfTitle]
                .replace(/\"/g, " ").replace(
                    /\'/g, " ")
            + '\')">'
            + item[0] + '</a>' + '</td></tr>';
        $('.summary_tab table').append(rows);}
}




//ajax请求处理

//kmeans保存设置请求
function kmeans_conservation(){
    var k_value = $("#k_value").val();
    var size = $("#kmeans_size:checked").val();
    //ajax 发送请求
    $.ajax({
        type:"post",
        url:"",
        data:{

        },
        dataType:"json",
        beforeSend : function(){
            begin();
        },
        success: function(msg){
            if(msg.status=="OK"){
                var items = msg.result;
                showMining(items);
            }else{
                alert(msg.result);
                //     $('.summary_tab table').html("");
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
//canopy保存设置请求
function canopy_conservation() {
    var c_value = $("#c_value").val();
    var size = $("#canopy_size:checked").val();
    //ajax 发送请求
    $.ajax({
        type:"post",
        url:"",
        data:{

        },
        dataType:"json",
        beforeSend : function(){
            begin();
        },
        success: function(msg){
            if(msg.status=="OK"){
                var items = msg.result;
                showMining(items);
            }else{
                alert(msg.result);
           //     $('.summary_tab table').html("");
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
//dbscan保存设置请求
function dbscans_conservation() {
    var radius = $("#radius").val();
    var minNum = $("#minNum").val();
    var size = $("#dbscan_size:checked").val();
    //ajax 发送请求
    $.ajax({
        type:"post",
        url:"",
        data:{

        },
        dataType:"json",
        beforeSend : function(){
            begin();
        },
        success: function(msg){
            if(msg.status=="OK"){
                var items = msg.result;
                showMining(items);
            }else{
                alert(msg.result);
                //     $('.summary_tab table').html("");
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
//kmeans聚类请求
function kmeans_clusster(){
    var k_value = $("#k_value").val();
    var size = $("#kmeans_size:checked").val();
    //ajax 发送请求
    $.ajax({
        type:"post",
        url:"",
        data:{

        },
        dataType:"json",
        beforeSend : function(){
            begin();
        },
        success: function(msg){
            if(msg.status=="OK"){
                var items = msg.result;
                showMining(items);
            }else{
                alert(msg.result);
                //     $('.summary_tab table').html("");
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
//canopy聚类请求
function canopy_clusster(){
    var c_value = $("#c_value").val();
    var size = $("#canopy_size:checked").val();
    //ajax 发送请求
    $.ajax({
        type:"post",
        url:"",
        data:{

        },
        dataType:"json",
        beforeSend : function(){
            begin();
        },
        success: function(msg){
            if(msg.status=="OK"){
                var items = msg.result;
                showMining(items);
            }else{
                alert(msg.result);
                //     $('.summary_tab table').html("");
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
//dbscan聚类请求
function dbscan_clusster(){
    var radius = $("#radius").val();
    var minNum = $("#minNum").val();
    var size = $("#dbscan_size:checked").val();
    //ajax 发送请求
    $.ajax({
        type:"post",
        url:"",
        data:{

        },
        dataType:"json",
        beforeSend : function(){
            begin();
        },
        success: function(msg){
            if(msg.status=="OK"){
                var items = msg.result;
                showMining(items);
            }else{
                alert(msg.result);
                //     $('.summary_tab table').html("");
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



//拖拽文件处理


//下载按钮操作


