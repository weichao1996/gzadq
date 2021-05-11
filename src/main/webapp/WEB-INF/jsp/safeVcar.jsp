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
	            url: '/getUcar/'+cid,
	            error: function () {
	                alert('网络错误');
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
		            url: '/getUwind/'+cid+'/'+Ucar,
		            error: function () {
		                alert('网络错误');
		            },
		            success: function (res2) {
		            	$.ajax({
		    	            type: 'GET',
		    	            url: '/getWindList',
		    	            error: function () {
		    	                alert('网络错误');
		    	            },
		    	            success: function (res) {
		    	            	$.ajax({
		    	    	            type: 'GET',
		    	    	            url: '/getForeWindList',
		    	    	            error: function () {
		    	    	                alert('网络错误');
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
		
		
		
		var int=self.setInterval("clock()",5*1000);
		function clock()
		{
			if(${sessionScope.threshold !=null}&&${sessionScope.threshold.radius!=""}&&"${sessionScope.threshold.radius}">0&&${sessionScope.threshold.lnglat!=null}){
				if(${sessionScope.threshold.arain!=""}||${sessionScope.threshold.awind!=""}||${sessionScope.threshold.avis!=""}
				||${sessionScope.threshold.frain!=""}||${sessionScope.threshold.fwind!=""}||${sessionScope.threshold.fvis!=""}){
					$.ajax({
			            type: 'GET',
			            url: '/getDetailIn',
			            error: function () {
			                alert('网络错误');
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
					
					<div class="input-card" style=" width: 28%;height:58%;top: 10px;">
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
					
					
					<div class="input-card" style=" width: auto;">
						<div style="width: 65px;height: 20px">车速(km/h)</div>
					    <div style="width: 50px;height: 20px;background-color: red"></div>0-20<br>
					    <div style="width: 50px;height: 20px;background-color: orange"></div>20-40<br>
					    <div style="width: 50px;height: 20px;background-color: yellow"></div>40-60<br>
					    <div style="width: 50px;height: 20px;background-color: blue"></div>60-80<br>
					    <div style="width: 50px;height: 20px;background-color: green"></div>80-100<br>
					</div>
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
					</script>
					
				</div>
			</div>
		</div>

	</body>

</html>