<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>

//---------------------------------------------设置警戒点-------------------------------------------------------
    //创建右键菜单
    var contextMenu = new AMap.ContextMenu();

    //右键放大
    contextMenu.addItem("设置为警戒点", function (e) {
        $.ajax({
	            type: 'GET',
	            url: '/gzadq/setLnglat/'+userid+'/'+contextMenuPositon+'/'+path,
	            error: function () {
	                alert('网络错误');
	            },
	            success: function (res) {
	            	
	            	document.location.href="<%=path%>/"+res;
	            
	            }
	        });
    },0);




    //地图绑定鼠标右击事件——弹出右键菜单
    map.on('rightclick', function (e) {
        contextMenu.open(map, e.lnglat);
        contextMenuPositon = e.lnglat;
    });
    
    
 //---------------------------------------------显示警戒圈-------------------------------------------------------
 	$.ajax({
	            type: 'GET',
	            url: '/gzadq/getThreshold',
	            error: function () {
	                alert('网络错误');
	            },
	            success: function (res) {
	            	var str=res.lnglat.split(",");
	            	var center=[];
	              	center.push(parseFloat(str[0]));
	              	center.push(parseFloat(str[1]));
	            	circle = new AMap.Circle({
				        center: center,
				        radius: res.radius*1000, //半径
				        borderWeight: 3,
				        strokeColor: "#FF33FF", 
				        strokeOpacity: 1,
				        strokeWeight: 6,
				        strokeOpacity: 0.2,
				        fillOpacity: 0.4,
				        strokeStyle: 'dashed',
				        strokeDasharray: [10, 10], 
				        // 线样式还支持 'dashed'
				        fillColor: '#1791fc',
				        zIndex: 50,
				        
				    })
				    map.add(circle);
    
				    circle.on('rightclick', function (e) {
				        contextMenu.open(map, e.lnglat);
				        contextMenuPositon = e.lnglat;
				    });
	            }
	        });
     

    
