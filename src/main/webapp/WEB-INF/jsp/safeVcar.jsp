<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<title>港珠澳大桥灾害天气预报预警</title>
 
    	<link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css" />
    	<link href="https://how2j.cn/study/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
		<script src="https://how2j.cn/study/js/bootstrap/3.3.6/bootstrap.min.js"></script>
   		<script src="https://webapi.amap.com/maps?v=1.4.15&key=60ea6f63d88dfc1055da2cbde103aef3&plugin=AMap.Driving"></script>
    	<script src="https://a.amap.com/jsapi_demos/static/demo-center/js/demoutils.js"></script>
    	<script src="https://cache.amap.com/lbs/static/es5.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/identify.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/account.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/control_index.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/threshold.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/layer.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/haidao.offcial.general.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/select.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/haidao.validate.js"></script>
		<style>
			.input-card .btn{
				margin-right: 1.2rem;
				width: 9rem;
			}

			.input-card .btn:last-child{
				margin-right: 0;
			}
		</style>
		<script>
		
		$(document).ready(function(){
			$("#cid").change(function(){
				addRoute();
				document.getElementById("tbody").innerHTML="";
				if(document.getElementById("Ucar").value!=null&&document.getElementById("Ucar").value!=""&&
						document.getElementById("Ucar").value>0&&document.getElementById("Ucar").value<=100){
					addTable();
				}
			})
			addRoute();
			
		});
		
		function check(){
			if(document.getElementById("Ucar").value<=0||document.getElementById("Ucar").value>100){
	    		document.getElementById("tips").innerHTML="请输入有效的行驶车速(1-100)";
	    	}else{
	    		document.getElementById("tips").innerHTML="";
	    	}
		}
	
		function addRoute(){
			var cid=document.getElementById("cid").value;
	    	$.ajax({
	            type: 'GET',
	            url: '/gzadq/getUcar/'+cid,
	            error: function () {
	                alert('获取车速错误');
	            },
	            success: function (res) {
	            			var temp=res[0];
			            	for(var i=0;i<temp.length;i+=1){
							    // 创建点、线、面覆盖物实例
							    var G3970 = new AMap.Marker({
							        position: new AMap.LngLat(temp[i].lon, temp[i].lat),
							        map:map,
							        icon: '<%=request.getContextPath()%>/img/'+i+'.ico'
							    });
							    G3970.Ucar=res[i+1];
							    G3970.on('click', showInfoClick);
							    	
								
							    
							}
	            	        var drivingOption = {
						        policy: AMap.DrivingPolicy.LEAST_TIME, // 其它policy参数请参考 https://lbs.amap.com/api/javascript-api/reference/route-search#m_DrivingPolicy
						        ferry: 1, // 是否可以使用轮渡
						        province: '京', // 车牌省份的汉字缩写  
						    }
						
						    // 构造路线导航类
						    var driving = new AMap.Driving(drivingOption)
						
						    // 根据起终点经纬度规划驾车导航路线
						    driving.search(new AMap.LngLat(113.590622,22.210364), new AMap.LngLat(113.60604,22.220207), function(status, result) {
						        // result即是对应的驾车导航信息，相关数据结构文档请参考 https://lbs.amap.com/api/javascript-api/reference/route-search#m_DrivingResult
						        if (status === 'complete') {
						            if (result.routes && result.routes.length) {
						                // 绘制第一条路线，也可以按需求绘制其它几条路线
						                chooseDrawRoute(res[1],result);
						                
						                // log.success('安全速度加载完成')
						            }
						        } else {
						            log.error('获取驾车数据失败：' + result)
						        }
						    });
						
						    driving.search(new AMap.LngLat(113.60604,22.220207), new AMap.LngLat(113.628028,22.23424), function(status, result) {
						        if (status === 'complete') {
						            if (result.routes && result.routes.length) {
						            	chooseDrawRoute(res[2],result);
						            }
						        } else {
						            log.error('获取驾车数据失败：' + result)
						        }
						    });
						
						    driving.search(new AMap.LngLat(113.628028,22.23424), new AMap.LngLat(113.66419,22.248064), function(status, result) {
						        if (status === 'complete') {
						            if (result.routes && result.routes.length) {
						            	chooseDrawRoute(res[3],result);
						            }
						        } else {
						            log.error('获取驾车数据失败：' + result)
						        }
						    });
						    
						    driving.search(new AMap.LngLat(113.66419,22.248064), new AMap.LngLat(113.696999,22.267605), function(status, result) {
						        if (status === 'complete') {
						            if (result.routes && result.routes.length) {
						            	chooseDrawRoute(res[4],result);
						            }
						        } else {
						            log.error('获取驾车数据失败：' + result)
						        }
						    });
						
						    driving.search(new AMap.LngLat(113.696999,22.267605), new AMap.LngLat(113.719935,22.278745), function(status, result) {
						        if (status === 'complete') {
						            if (result.routes && result.routes.length) {
						            	chooseDrawRoute(res[5],result);
						            }
						        } else {
						            log.error('获取驾车数据失败：' + result)
						        }
						    });
						
						    driving.search(new AMap.LngLat(113.719935,22.278745), new AMap.LngLat(113.74061,22.280147), function(status, result) {
						        if (status === 'complete') {
						            if (result.routes && result.routes.length) {
						            	chooseDrawRoute(res[6],result);
						            }
						        } else {
						            log.error('获取驾车数据失败：' + result)
						        }
						    });
						 	
						    driving.search(new AMap.LngLat(113.74061,22.280147), new AMap.LngLat(113.765663,22.280184), function(status, result) {
						        if (status === 'complete') {
						            if (result.routes && result.routes.length) {
						            	chooseDrawRoute(res[7],result);
						            }
						        } else {
						            log.error('获取驾车数据失败：' + result)
						        }
						    });
						
						    driving.search(new AMap.LngLat(113.765663,22.280184), new AMap.LngLat(113.810717,22.280212), function(status, result) {
						        if (status === 'complete') {
						            if (result.routes && result.routes.length) {
						            	chooseDrawRoute(res[8],result);
						            }
						        } else {
						            log.error('获取驾车数据失败：' + result)
						        }
						    });
						     
						    driving.search(new AMap.LngLat(113.810717,22.280212), new AMap.LngLat(113.870335,22.272177), function(status, result) {
						        if (status === 'complete') {
						            if (result.routes && result.routes.length) {
						            	chooseDrawRoute(res[9],result);
						            }
						        } else {
						            log.error('获取驾车数据失败：' + result)
						        }
						    });
						    
						    
						    log.success('安全速度加载完成')
	            }    
	        })
	        
		}
		
		
		function chooseDrawRoute(Ucar,result){
			if(Ucar>=0 && Ucar<=20){
				drawRouteRed(result.routes[0])
			}else if(Ucar>20 && Ucar<=40){
				drawRouteOrg(result.routes[0])
			}else if(Ucar>40 && Ucar<=60){
				drawRouteYel(result.routes[0])
			}else if(Ucar>60 && Ucar<=80){
				drawRouteBlue(result.routes[0])
			}else if(Ucar>80 && Ucar<=100){
				drawRouteGre(result.routes[0])
			}else if(Ucar=="限行(风速大于18m/s封桥)"){
				drawRouteRed(result.routes[0])
			}
		}
		
		window.onkeydown = function (event) {
		    var event = event || window.event
		    //esc 键被按下执行
		    if (event.keyCode == 13) {
				queding();
		    }			
		};

		function queding(){
			if(document.getElementById("Ucar").value<=0||document.getElementById("Ucar").value>100){
				document.getElementById("tbody").innerHTML="";
			}else{
				addTable();
			}
		}
		
		function addTable(){
			
			
				var cid=document.getElementById("cid").value;
		    	var Ucar=document.getElementById("Ucar").value;
		    	
		    	$.ajax({
		            type: 'GET',
		            url: '/gzadq/getUwind/'+cid+'/'+Ucar,
		            error: function () {
		                alert('获取安全行驶风速错误');
		            },
		            success: function (res2) {
		            	$.ajax({
		    	            type: 'GET',
		    	            url: '/gzadq/getWindList',
		    	            error: function () {
		    	                alert('获取风速实况错误');
		    	            },
		    	            success: function (res) {
		    	            	$.ajax({
		    	    	            type: 'GET',
		    	    	            url: '/gzadq/getForeWindList',
		    	    	            error: function () {
		    	    	                alert('获取风速预报错误');
		    	    	            },
		    	    	            success: function (res1) {
		    	    	            	var str="";
		    	    				    for(var i=0;i<res.length;i+=1){
		    	    					   
		    	    					    var a="";
		    	    					    if(res2[i]<res1[i].wind){
		    	    					    	a="class='warning'";
		    	    					    }
		    	    					    if(res2[i]<res[i].wind){
		    	    					    	a="class='danger'";
		    	    					    }
		    	    					    str+="<tr "+a+
		    	    					    	 "><td><img src='<%=request.getContextPath()%>/img/"+i+".ico'/></td>"+
		    	    					    	 "<td>"+res2[i]+"</td>"+
		    	    					    	 "<td>"+res[i].wind+"</td>"+
		    	    					    	 "<td>"+res1[i].wind+"</td></tr>"
		    	    					    	
		    	    						
		    	    					    
		    	    					}
		    	    				    document.getElementById("tbody").innerHTML=str;
		    	    	            }
		    	    	        });
		    	            	
		    	            }
		    	        });  
		            }
		        });  
			
	    	
		}
		
		
		
		
		
		</script>
		
	</head>

	<body>
		<script>
		
		
		
		var int=self.setInterval("clock()",${thresholdTime});
		function clock()
		{
			if(${sessionScope.threshold !=null}&&${sessionScope.threshold.radius!=""}&&"${sessionScope.threshold.radius}">0&&${sessionScope.threshold.lnglat!=null}){
				if(${sessionScope.threshold.arain!=""}||${sessionScope.threshold.awind!=""}||${sessionScope.threshold.avis!=""}
				||${sessionScope.threshold.frain!=""}||${sessionScope.threshold.fwind!=""}||${sessionScope.threshold.fvis!=""}){
					$.ajax({
			            type: 'GET',
			            url: '/gzadq/getDetailIn',
			            error: function () {
			                alert('获取警戒圈预警错误');
			            },
			            success: function (res) {
			            	var str0="";
			            	var str1="";
			            	if(${sessionScope.threshold.arain!=null}&&${sessionScope.threshold.arain!=""}){
			            		if("${sessionScope.threshold.arain}"<res[0].maxRain){
					            	str0+="港珠澳大桥 降雨要素 实况值 已超过警戒值"+"${sessionScope.threshold.arain}"+"mm(所设置的警戒值)\n"; 
					            }
			            	}
			            	if(${sessionScope.threshold.awind!=null}&&${sessionScope.threshold.awind!=""}){
			            		if("${sessionScope.threshold.awind}"<res[0].maxWind){
					            	str0+="港珠澳大桥 风力要素 实况值 已超过警戒值"+"${sessionScope.threshold.awind}"+"m/s(所设置的警戒值)\n";
					            }
			            	}
			            	
			            	if(${sessionScope.threshold.avis!=null}&&${sessionScope.threshold.avis!=""}){
			            		if("${sessionScope.threshold.avis}">res[0].minVis/1000){
					            	str0+="港珠澳大桥 能见度要素 实况值 已低于警戒值"+"${sessionScope.threshold.avis}"+"km(所设置的警戒值)\n";
					            }
			            	}

							if(${sessionScope.threshold.frain!=null}&&${sessionScope.threshold.frain!=""}){
								if("${sessionScope.threshold.frain}"<res[1].maxRain){
									str1+="港珠澳大桥 降雨要素 预报值("+res[1].forecasttime+") 已超过警戒值"+"${sessionScope.threshold.frain}"+"mm(所设置的警戒值)\n";
								}
							}

							if(${sessionScope.threshold.fwind!=null}&&${sessionScope.threshold.fwind!=""}){
								if("${sessionScope.threshold.fwind}"<res[1].maxWind){
									str1+="港珠澳大桥 风力要素 预报值("+res[1].forecasttime+") 已超过警戒值"+"${sessionScope.threshold.fwind}"+"m/s(所设置的警戒值)\n";
								}
							}
							if(${sessionScope.threshold.fvis!=null}&&${sessionScope.threshold.fvis!=""}){
								if("${sessionScope.threshold.fvis}">res[1].minVis){
									str1+="港珠澳大桥 能见度要素 预报值("+res[1].forecasttime+") 已低于警戒值"+"${sessionScope.threshold.fvis}"+"km(所设置的警戒值)\n";
								}
							}
			            	
			            	
			            	if(str0!="") alert(str0);
			            	if(str1!="") alert(str1);
			            }
			        }); 
				}
				
			}
			
		}
		</script>
		<div class="view-topbar">
			<div class="topbar-console">
				<div class="tobar-head fl">
					<a href="safeVcar" class="topbar-home-link topbar-btn text-center fl"><span>灾害天气预报预警</span></a>
				</div>
			</div>
		</div>
		<div class="view-body">

			<div class="view-sidebar">
				
				<div class="sidebar-content">
					
					<div class="sidebar-nav">
						
						<ul class="sidebar-trans">
							<li>
								<a href="actualData">
									<b class="sidebar-icon"><img src="Images/icon_cost.png" width="16" height="16" /></b>
									<span class="text-normal">大桥天气实况</span>
								</a>
							</li>
							<li>
								<a href="forecastData">
									<b class="sidebar-icon"><img src="Images/icon_authentication.png" width="16" height="16" /></b>
									<span class="text-normal">大桥天气预报</span>
								</a>
							</li>
							<li>
								<a href="forecastDataPoint">
									<b class="sidebar-icon"><img src="Images/icon_authentication.png" width="16" height="16" /></b>
									<span class="text-normal">大桥天气预报(格点)</span>
								</a>
							</li>
							<li style="background-color: #37424f">
								<a href="safeVcar">
									<b class="sidebar-icon"><img src="Images/icon_news.png" width="16" height="16" /></b>
									<span class="text-normal">安全行驶速度</span>
								</a>
							</li>
							
							
						</ul>
					</div>
				</div>
			</div>
			<div class="view-product background-color">
				<div class="padding-big background-color">
					<div id="container"></div>
<%--					<div class="info" id="text">--%>
<%--						请用鼠标在地图上操作试试--%>
<%--					</div>--%>
					
					<div class="input-card" style=" width: 28%;height:58%;">
					<div class="form-inline">
					  <div class="form-group">
					     <div class="input-item">
					     				<label>车型 &nbsp;</label>
					     				<select name="cid" id="cid">
					    
					 				    	<option value ="1">轿车</option>
					  						<option value ="2">微型客车</option>
					 						<option value="3">中型客车</option>
					  						<option value="4">集装箱挂车</option>
										</select>
						 </div>
					  </div>
					  &nbsp;&nbsp;&nbsp;&nbsp;
					  <div class="form-group">
					    <label>车速（km/h）</label>
					    <input type="text" class="form-control" id="Ucar" onkeyup="this.value=this.value.replace(/\D/g,'');check()" onafterpaste="this.value=this.value.replace(/\D/g,'')"
					    style="width:100px">
						  <button type="button" class="btn btn-primary" onclick="queding()">确定</button><br>

						  <div id="tips" style="float:right;color:red"></div>
					  </div>
					</div>
					</br>
						<table class="table table-hover">
							  <thead>
							     <th>站点</th>
							     <th>安全行驶风速(m/s)</th>
							     <th>风速实况(m/s)</th>
							     <th>风速预报(m/s)</th>
							  </thead>
							  <tbody id="tbody">
							     
							  </tbody>
						</table>
					</div>
					
					
					<div class="input-card" style=" width: auto;height:15rem;top: 10px;">
						<div style="width: 65px;height: 20px">车速(km/h)</div>
					    <div style="width: 50px;height: 20px;background-color: red"></div>0-20<br>
					    <div style="width: 50px;height: 20px;background-color: orange"></div>20-40<br>
					    <div style="width: 50px;height: 20px;background-color: yellow"></div>40-60<br>
					    <div style="width: 50px;height: 20px;background-color: blue"></div>60-80<br>
					    <div style="width: 50px;height: 20px;background-color: green"></div>80-100<br>

					</div>

<%--					<div class="input-card" style="right:15rem;top:1rem;height:5rem">--%>

<%--						<div class="input-item">--%>
<%--							<input type="button" class="btn"  value="开始动画" id="start" onclick="addRoute2()"/>--%>

<%--						</div>--%>

<%--					</div>--%>
					<script type="text/javascript">
					
					    var map = new AMap.Map("container", {
					    	resizeEnable: true,
					        center: [113.78, 22.25],
					        zoom: 12
					    });
					
					    
					
					      

					     function showInfoClick(e){
					     	var position = this.getPosition();
					        var infoWindow = new AMap.InfoWindow({
					            position: position,
					            offset: new AMap.Pixel(0, -35),
					            content: '<div>当前安全行驶车速：'+e.target.Ucar+'</div>'
					        });
					
					        infoWindow.open(map);
					    }
					
					
					
					   
					
					    function drawRouteRed (route) {
					        var path = parseRouteToPath(route)
							// var startMarker = new AMap.Marker({
					        //     position: path[0],
					        //     icon: 'https://webapi.amap.com/theme/v1.3/markers/n/start.png',
					        //     map: map
					        // })
					
					        // var endMarker = new AMap.Marker({
					        //     position: path[path.length - 1],
					        //     icon: 'https://webapi.amap.com/theme/v1.3/markers/n/end.png',
					        //     map: map
					        // })
					        
					        var routeLine = new AMap.Polyline({
					            path: path,
					            isOutline: true,
					            outlineColor: '#ffeeee',
					            borderWeight: 2,
					            strokeWeight: 5,
					            strokeColor: 'red',
					            lineJoin: 'round'
					        })
					
					        routeLine.setMap(map)
							// 调整视野达到最佳显示区域
					        // map.setFitView([ startMarker, endMarker, routeLine ])
					    }
					
					    function drawRouteOrg (route) {
					        var path = parseRouteToPath(route)      
					
					        var routeLine = new AMap.Polyline({
					            path: path,
					            isOutline: true,
					            outlineColor: '#ffeeee',
					            borderWeight: 2,
					            strokeWeight: 5,
					            strokeColor: 'orange',
					            lineJoin: 'round'
					        })
					
					        routeLine.setMap(map)
					
					    }
					
					    function drawRouteYel (route) {
					        var path = parseRouteToPath(route)
					
					        var routeLine = new AMap.Polyline({
					            path: path,
					            isOutline: true,
					            outlineColor: '#ffeeee',
					            borderWeight: 2,
					            strokeWeight: 5,
					            strokeColor: 'yellow',
					            lineJoin: 'round'
					        })
					
					        routeLine.setMap(map)
					    }
					    
					    function drawRouteBlue (route) {
					        var path = parseRouteToPath(route)
					
					        var routeLine = new AMap.Polyline({
					            path: path,
					            isOutline: true,
					            outlineColor: '#ffeeee',
					            borderWeight: 2,
					            strokeWeight: 5,
					            strokeColor: 'blue',
					            lineJoin: 'round'
					        })
					
					        routeLine.setMap(map)
					    }
					    
					    function drawRouteGre (route) {
					        var path = parseRouteToPath(route)
					
					        var routeLine = new AMap.Polyline({
					            path: path,
					            isOutline: true,
					            outlineColor: '#ffeeee',
					            borderWeight: 2,
					            strokeWeight: 5,
					            strokeColor: 'green',
					            lineJoin: 'round'
					        })
					
					        routeLine.setMap(map)
					    }
					    
					    
					
					    // 解析DrivingRoute对象，构造成AMap.Polyline的path参数需要的格式
					    // DrivingResult对象结构参考文档 https://lbs.amap.com/api/javascript-api/reference/route-search#m_DriveRoute
					    function parseRouteToPath(route) {
					        var path = []
					
					        for (var i = 0, l = route.steps.length; i < l; i++) {
					            var step = route.steps[i]
					
					            for (var j = 0, n = step.path.length; j < n; j++) {
					              path.push(step.path[j])
					            }
					        }
					
					        return path
					    }




					    //轨迹回放

						// var marker, lineArr = [[113.590622,22.210364],[113.60604,22.220207],[113.628028,22.23424],[113.66419,22.248064],[113.696999,22.267605],
						// 	[113.719935,22.278745],[113.74061,22.280147],[113.765663,22.280184],[113.810717,22.280212],[113.870335,22.272177]];

							var marker, lineArr = [[113.590622,22.210364],[113.60604,22.220207],
								[113.628028,22.23424],[113.639563,22.241017],[113.645607,22.243292], [113.66419,22.248064],[113.667521,22.248974],[113.672048,22.250533],[113.679205,22.253939],
								[113.685567,22.257901],[113.689107,22.260602],[113.696999,22.267605],[113.698471,22.268944],[113.701143,22.270896],[113.705834,22.273646],
								[113.708874,22.275136],[113.714711,22.27737],[113.719935,22.278745],[113.72589,22.279797],[113.74061,22.280147],[113.765663,22.280184],[113.810717,22.280212],
								[113.843073,22.279998],[113.845696,22.279809],[113.851827,22.27859],[113.855401,22.277615],[113.870335,22.272177]

							];
							var lineArr9=[[113.810717,22.280212],[113.843073,22.279998],[113.845696,22.279809],[113.851827,22.27859],[113.855401,22.277615],[113.870335,22.272177]];
							var lineArr8=[[113.765663,22.280184],[113.810717,22.280212]];
					     	var lineArr7=[[113.74061,22.280147],[113.765663,22.280184]];
							var lineArr6=[[113.719935,22.278745],[113.72589,22.279797],[113.74061,22.280147]];
							var lineArr5=[[113.696999,22.267605],[113.698471,22.268944],[113.701143,22.270896],[113.705834,22.273646],
								[113.708874,22.275136],[113.714711,22.27737],[113.719935,22.278745]];
							var lineArr4=[[113.66419,22.248064],[113.667521,22.248974],[113.672048,22.250533],[113.679205,22.253939],
								[113.685567,22.257901],[113.689107,22.260602],[113.696999,22.267605]];
							var lineArr3=[[113.628028,22.23424],[113.639563,22.241017],[113.645607,22.243292], [113.66419,22.248064]];
							var lineArr2=[[113.60604,22.220207],[113.628028,22.23424]];
							var lineArr1=[[113.590622,22.210364],[113.60604,22.220207]];
							var map = new AMap.Map("container", {
							resizeEnable: true,
							center: [113.78, 22.25],
							zoom: 12
						});

							marker = new AMap.Marker({
							map: map,
							position: [113.590622,22.210364],
							icon: "<%=request.getContextPath()%>/img/car2.png",
							offset: new AMap.Pixel(-26, -30),
							autoRotation: true,
							angle:-35,
						});
						marker.on('click', addRoute2);

						// 创建跟速度信息展示框
						var carWindow = new AMap.InfoWindow({
							offset: new AMap.Pixel(6, -25),
						});



							// 绘制轨迹
							var polyline = new AMap.Polyline({
							map: map,
							path: lineArr,
							showDir:true,
							strokeColor: "#28F",  //线颜色
							// strokeOpacity: 1,     //线透明度
							strokeWeight: 6,      //线宽
							// strokeStyle: "solid"  //线样式
						});

						// 	var passedPolyline = new AMap.Polyline({
						// 	map: map,
						// 	// path: lineArr,
						// 	strokeColor: "#28F",  //线颜色
						// 	// strokeOpacity: 1,     //线透明度
						// 	strokeWeight: 6,      //线宽
						// 	// strokeStyle: "solid"  //线样式
						// });

						//添加监听事件： 车辆移动的时候，更新速度窗体位置
							marker.on('moving', function (e) {
								//passedPolyline.setPath(e.passedPath);
								var lastLocation = e.passedPath[e.passedPath.length - 1];
								//移动窗体
								carWindow.setPosition(lastLocation);
								//console.log(e.target.getPosition());
								// if(e.target.getPosition()=="113.60604,22.220207"){alert(123)}
							});

							map.setFitView();

							function startAnimation () {
								addRoute2();
							}


						function run9(){
							marker.moveAlong(lineArr9, Ucar[9]*81);
							carWindow.setContent("速度:" + Ucar[9] + "公里/时");
							setIcon(8);
						}
						function run8(){
							marker.moveAlong(lineArr8, Ucar[8]*81);
							carWindow.setContent("速度:" + Ucar[8] + "公里/时");
							setIcon(7);
						}
						function run7(){
							marker.moveAlong(lineArr7, Ucar[7]*81);
							carWindow.setContent("速度:" + Ucar[7] + "公里/时");
							setIcon(6);
						}
						function run6(){
							marker.moveAlong(lineArr6, Ucar[6]*81);
							carWindow.setContent("速度:" + Ucar[6] + "公里/时");
							setIcon(5);
						}
						function run5(){
							marker.moveAlong(lineArr5, Ucar[5]*81);
							carWindow.setContent("速度:" + Ucar[5] + "公里/时");
							setIcon(4);
						}

						function run4(){
							marker.moveAlong(lineArr4, Ucar[4]*81);
							carWindow.setContent("速度:" + Ucar[4] + "公里/时");
							setIcon(3);
						}
						function run3(){
							marker.moveAlong(lineArr3, Ucar[3]*81);
							carWindow.setContent("速度:" + Ucar[3] + "公里/时");
							setIcon(2);
						}

						function run2(){
							marker.moveAlong(lineArr2, Ucar[2]*81);
							carWindow.setContent("速度:" + Ucar[2] + "公里/时");
							setIcon(1);
						}

						function run1(){
							marker.moveAlong(lineArr1, Ucar[1]*81);
							carWindow.setContent("速度:" + Ucar[1] + "公里/时");
							setIcon(0);
						}

						function setIcon(a){
							temp=Ucar[0];
							if(temp[a].rain>0){
								marker.setIcon("<%=request.getContextPath()%>/img/raincar2.png")
								marker.setOffset(new AMap.Pixel(-26, -27));
							}else{
								marker.setIcon("<%=request.getContextPath()%>/img/car2.png")
								marker.setOffset(new AMap.Pixel(-26, -30));
							}
						}
						function addRoute2(){
							// document.getElementById("start").setAttribute("disabled", true);//设置不可点击
							// document.getElementById("start").style.backgroundColor  = '#555555';//设置背景色
							// document.getElementById("start").removeAttribute("disabled");//去掉不可点击
							carWindow.open(map, marker.getPosition());
							var cid=document.getElementById("cid").value;
							$.ajax({
								type: 'GET',
								url: '/gzadq/getUcar/'+cid,
								error: function () {
									alert('获取车速错误');
								},
								success: function (res) {

									Ucar=[];
									Ucar.push(res[0]);
									Ucar.push(res[1]);
									Ucar.push(res[2]);
									Ucar.push(res[3]);
									Ucar.push(res[4]);
									Ucar.push(res[5]);
									Ucar.push(res[6]);
									Ucar.push(res[7]);
									Ucar.push(res[8]);
									Ucar.push(res[9]);

									// marker.moveAlong(lineArr1, Ucar[0]*81);
									//
									// setTimeout(run9,(1927/1000/Ucar[0]+2749/1000/Ucar[1]+4061/1000/Ucar[2]+4068/1000/Ucar[3]+2693/1000/Ucar[4]+2138/1000/Ucar[5]+
									// 		2577/1000/Ucar[6]+4635/1000/Ucar[7])*3600/81*1000);
									// setTimeout(run8,(1927/1000/Ucar[0]+2749/1000/Ucar[1]+4061/1000/Ucar[2]+4068/1000/Ucar[3]+2693/1000/Ucar[4]+2138/1000/Ucar[5]+
									// 		2577/1000/Ucar[6])*3600/81*1000);
									// setTimeout(run7,(1927/1000/Ucar[0]+2749/1000/Ucar[1]+4061/1000/Ucar[2]+4068/1000/Ucar[3]+2693/1000/Ucar[4]+2138/1000/Ucar[5])*3600/81*1000);
									// setTimeout(run6,(1927/1000/Ucar[0]+2749/1000/Ucar[1]+4061/1000/Ucar[2]+4068/1000/Ucar[3]+2693/1000/Ucar[4])*3600/81*1000);
									// setTimeout(run5,(1927/1000/Ucar[0]+2749/1000/Ucar[1]+4061/1000/Ucar[2]+4068/1000/Ucar[3])*3600/81*1000);
									// setTimeout(run4,(1927/1000/Ucar[0]+2749/1000/Ucar[1]+4061/1000/Ucar[2])*3600/81*1000);
									// setTimeout(run3,(1927/1000/Ucar[0]+2749/1000/Ucar[1])*3600/81*1000);
									// setTimeout(run2, 1927/1000/Ucar[0]*3600/81*1000);
									if(Ucar[1]!="限行(风速大于18m/s封桥)"){
										run1();
										if(Ucar[2]!="限行(风速大于18m/s封桥)"){
											setTimeout(run2, 1927/1000/Ucar[1]*3600/81*1000);
											if(Ucar[3]!="限行(风速大于18m/s封桥)"){
												setTimeout(run3,(1927/1000/Ucar[1]+2749/1000/Ucar[2])*3600/81*1000);
												if(Ucar[4]!="限行(风速大于18m/s封桥)"){
													setTimeout(run4,(1927/1000/Ucar[1]+2749/1000/Ucar[2]+4061/1000/Ucar[3])*3600/81*1000);
													if(Ucar[5]!="限行(风速大于18m/s封桥)"){
														setTimeout(run5,(1927/1000/Ucar[1]+2749/1000/Ucar[2]+4061/1000/Ucar[3]+4068/1000/Ucar[4])*3600/81*1000);
														if(Ucar[6]!="限行(风速大于18m/s封桥)"){
															setTimeout(run6,(1927/1000/Ucar[1]+2749/1000/Ucar[2]+4061/1000/Ucar[3]+4068/1000/Ucar[4]+2693/1000/Ucar[5])*3600/81*1000);
															if(Ucar[7]!="限行(风速大于18m/s封桥)"){
																setTimeout(run7,(1927/1000/Ucar[1]+2749/1000/Ucar[2]+4061/1000/Ucar[3]+4068/1000/Ucar[4]+2693/1000/Ucar[5]+2138/1000/Ucar[6])*3600/81*1000);
																if(Ucar[8]!="限行(风速大于18m/s封桥)"){
																	setTimeout(run8,(1927/1000/Ucar[1]+2749/1000/Ucar[2]+4061/1000/Ucar[3]+4068/1000/Ucar[4]+2693/1000/Ucar[5]+2138/1000/Ucar[6]+
																			2577/1000/Ucar[7])*3600/81*1000);
																	if(Ucar[9]!="限行(风速大于18m/s封桥)"){
																		setTimeout(run9,(1927/1000/Ucar[1]+2749/1000/Ucar[2]+4061/1000/Ucar[3]+4068/1000/Ucar[4]+2693/1000/Ucar[5]+2138/1000/Ucar[6]+
																				2577/1000/Ucar[7]+4635/1000/Ucar[8])*3600/81*1000);
																	}
																}
															}
														}
													}
												}
											}
										}
									}

									// while(1){
									// 	if(marker.getPosition()=="113.60604,22.220207"){
									// 		if(Ucar[1]!="限行(风速大于18m/s封桥)"){
									// 			run2();
									// 			continue;
									// 		}
									//
									// 	}
									// 	if(marker.getPosition()=="113.628028,22.23424"){
									// 		if(Ucar[2]!="限行(风速大于18m/s封桥)"){
									// 			run3();
									// 			continue;
									// 		}
									//
									// 	}
									// 	if(marker.getPosition()=="113.66419,22.248064"){
									// 		if(Ucar[3]!="限行(风速大于18m/s封桥)"){
									// 			run4();
									// 			continue;
									// 		}
									//
									// 	}
									// 	if(marker.getPosition()=="113.696999,22.267605"){
									// 		if(Ucar[4]!="限行(风速大于18m/s封桥)"){
									// 			run5();
									// 			continue;
									// 		}
									//
									// 	}
									// 	if(marker.getPosition()=="113.719935,22.278745"){
									// 		if(Ucar[5]!="限行(风速大于18m/s封桥)"){
									// 			run6();
									// 			continue;
									// 		}
									//
									// 	}
									// 	if(marker.getPosition()=="113.74061,22.280147"){
									// 		if(Ucar[6]!="限行(风速大于18m/s封桥)"){
									// 			run7();
									// 			continue;
									// 		}
									//
									// 	}
									// 	if(marker.getPosition()=="113.765663,22.280184"){
									// 		if(Ucar[7]!="限行(风速大于18m/s封桥)"){
									// 			run8();
									// 			continue;
									// 		}
									//
									// 	}
									// 	if(marker.getPosition()=="113.810717,22.280212"){
									// 		if(Ucar[8]!="限行(风速大于18m/s封桥)"){
									// 			run9();
									// 			continue;
									// 		}
									//
									// 	}
									// }

									// setTimeout(run9,40000);
									// setTimeout(run8,35000);
									// setTimeout(run7,30000);
									// setTimeout(run6,25000);
									// setTimeout(run5,20000);
									// setTimeout(run4,15000);
									// setTimeout(run3,10000);
									// setTimeout(run2, 5000);
								}
							})

						}

						// map.on('click', showInfoClick);
						// function showInfoClick(e){
						// 	var text = '您在 [ '+e.lnglat.getLng()+','+e.lnglat.getLat()+' ] 的位置单击了地图！'
						// 	document.querySelector("#text").innerText = text;
						// }
					</script>
					
				</div>
			</div>
		</div>

	</body>

</html>