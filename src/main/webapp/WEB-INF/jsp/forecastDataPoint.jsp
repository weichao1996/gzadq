<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>港珠澳大桥灾害天气预报预警</title>

	<link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css"/>
	<script src="https://how2j.cn/study/js/jquery/2.0.0/jquery.min.js"></script>
	<link href="https://how2j.cn/study/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
	<script src="https://how2j.cn/study/js/bootstrap/3.3.6/bootstrap.min.js"></script>
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
	<script src="https://webapi.amap.com/maps?v=1.4.15&key=60ea6f63d88dfc1055da2cbde103aef3"></script>

	<script>
		$(document).ready(function(){
			$("#forecasttime").change(function(){
				change();
			})
			
			$("#type").change(function(){
				change();
			})
			
		});
		function change(){
			var forecasttime=document.getElementById("forecasttime").value;
			var type=document.getElementById("type").value;
			$.ajax({
	            type: 'GET',
	            url: '/getForecastData/'+forecasttime+'/'+type,
	            error: function () {
	                alert('获取预报数据错误');
	            },
	            success: function (res) {
	            	document.getElementById("tips").style.display="none";
	            	document.getElementById("tips").innerHTML="";
	            	if(res.length>0&&type=="rain"){
	            		/* windmap.hide();
	            		vismap.hide();
	            		rainmap.setDataSet({
				            data: res,
				            max: 50
				        }); 
	            		rainmap.show(); */
				        map.clearMap();
	            		showRain(res);
	            		document.getElementById("color1").style.display="block";
	            		document.getElementById("color2").style.display="none";
	            		document.getElementById("color3").style.display="none";
	            		// for(var i=0;i<res.length;i++){
	            		// 	if(res[i].count>0){
	            		// 		document.getElementById("tips").innerHTML+="大桥附近有可能即将降雨，请减速慢行，注意保持车距！";
	            		// 		document.getElementById("tips").style.display="block";
	            		// 		break;
	            		// 	}
	            		// }
	            	}else if(res.length>0&&type=="wspd10m"){
	            		/* rainmap.hide();
	            		vismap.hide();
	            		windmap.setDataSet({
				            data: res,
				            max: 20.8
				        });
	            		windmap.show(); */
	            		map.clearMap();
	            		showWind(res);
	            		document.getElementById("color1").style.display="none";
	            		document.getElementById("color2").style.display="block";
	            		document.getElementById("color3").style.display="none";
	            		// for(var i=0;i<res.length;i++){
	            		// 	if(res[i].count>10){
	            		// 		document.getElementById("tips").innerHTML+="大桥附近有可能即将风速较快，请减速慢行，注意保持车距！";
	            		// 		document.getElementById("tips").style.display="block";
	            		// 		break;
	            		// 	}
	            		// }
	            	}else if(res.length>0&&type=="visi"){
	            		/* rainmap.hide();
	            		windmap.hide();
	            		vismap.setDataSet({
				            data: res,
				            max: 10
				        });
	            		vismap.show(); */
	            		map.clearMap();
	            		showVis(res);
	            		document.getElementById("color1").style.display="none";
	            		document.getElementById("color2").style.display="none";
	            		document.getElementById("color3").style.display="block";
	            		// for(var i=0;i<res.length;i++){
	            		// 	if(res[i].count<1){
	            		// 		document.getElementById("tips").innerHTML+="大桥附近有可能即将能见度较低，请减速慢行，注意保持车距！";
	            		// 		document.getElementById("tips").style.display="block";
	            		// 		break;
	            		// 	}
	            		// }
	            	}
	            }
	        });
		}
		
		function getForecastTime(){
	    	$.ajax({
	            type: 'GET',
	            url: '/getForecastTime',
	            error: function () {
	                alert('获取预报时间错误');
	            },
	            success: function (res) {
	            		var str="";
		                for(var i=0;i<res.length;i++){    
		                	str += "<option value='" + res[i].forecasttime + "' onclick='timeChange()"+"'>" + res[i].forecasttime + "</option>";
		                    
		                }
		                document.getElementById("forecasttime").innerHTML+=str;
	            }
	        });
	    }
		getForecastTime();
		
		
		
		
	</script>
   

</head>
<body>
	<script type="text/javascript">
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
							<li style="background-color: #37424f">
								<a href="forecastDataPoint">
									<b class="sidebar-icon"><img src="Images/icon_authentication.png" width="16" height="16" /></b>
									<span class="text-normal">大桥天气预报(格点)</span>
								</a>
							</li>
							<li>
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
					<div id="tips" style="width:100%;height:30px;background-color:#37424f;color:white;font-size:15px;display:none;position: fixed;top:0">
								
					</div>
					 <jsp:include flush="true" page="threshold.jsp"></jsp:include> 
					<div id="color1" class="input-card" style=" width: auto;bottom: 150px;display:none">
						<div style="width: 50px;height: 20px;background-color: #00FFFF"></div>0<br>
					    <div style="width: 50px;height: 20px;background-color: #00BFFF"></div>0-2<br>
					    <div style="width: 50px;height: 20px;background-color: #1874CD"></div>2-4<br>
					    <div style="width: 50px;height: 20px;background-color: #3A5FCD"></div>4-6<br>
					    <div style="width: 50px;height: 20px;background-color: #0000EE"></div>6-8<br>
					    <div style="width: 50px;height: 20px;background-color: #EE7AE9"></div>8-10<br>
					    <div style="width: 50px;height: 20px;background-color: #BF3EFF"></div>10-20<br>
					    <div style="width: 50px;height: 20px;background-color: #9A32CD"></div>20-50<br>
					    <div style="width: 50px;height: 20px;background-color: #551A8B"></div>≥50(mm)<br>
					</div>
					<div id="color2" class="input-card" style=" width: auto;bottom: 150px;display:none">
					    <div style="width: 50px;height: 20px;background-color: blue"></div>0-3.3<br>
					    <div style="width: 50px;height: 20px;background-color: green"></div>3.4-7.9<br>
					    <div style="width: 50px;height: 20px;background-color: yellow"></div>8.0-13.8<br>
					    <div style="width: 50px;height: 20px;background-color: orange"></div>13.9-20.7<br>
					    <div style="width: 50px;height: 20px;background-color: red"></div>≥20.8(m/s)<br>
					</div>
					<div id="color3" class="input-card" style=" width: auto;bottom: 150px;display:none">
					    <div style="width: 50px;height: 20px;background-color: #ffffff;border:1px solid gray"></div>≥10000<br>
					    <div style="width: 50px;height: 20px;background-color: #9AFF9A"></div>1000-10000<br>
					    <div style="width: 50px;height: 20px;background-color: #00FFFF"></div>200-1000<br>
					    <div style="width: 50px;height: 20px;background-color: #00C5CD"></div>50-200<br>
					    <div style="width: 50px;height: 20px;background-color: #3A5FCD"></div>0-50(m)<br>
						<div style="width: 50px;height: 20px;background-color: #0000EE"></div>NaN<br>


					</div>
					<div class="input-card" style="width: 200px;">
						    <!-- <div class="input-item">
						        <button class="btn" onclick="map.clearMap();windmap.hide();rainmap.show();document.getElementById('color1').style.display='block';document.getElementById('color2').style.display='none';document.getElementById('color3').style.display='none'">降水</button>
						        <button class="btn" onclick="map.clearMap();rainmap.hide();windmap.show();document.getElementById('color2').style.display='block';document.getElementById('color1').style.display='none';document.getElementById('color3').style.display='none'" style="margin-left:15px">风力</button>
						        <button class="btn" onclick="rainmap.hide();windmap.hide();showVis();document.getElementById('color3').style.display='block';document.getElementById('color1').style.display='none';document.getElementById('color2').style.display='none'" style="margin-left:15px">能见度</button>
						    </div> -->
						<select id="type" name="type">
           					<option>-请选择要素-</option>
           					<option value="rain">降水</option>
           					<option value="wspd10m">风力</option>
           					<option value="visi">能见度</option>
           					
       					</select>
       					</br>
					    <select id="forecasttime" name="forecasttime">
           					<option>-请选择时间-</option>
           					
       					</select>
					</div>
					
					<script>
						var path="forecastDataPoint";
					    var map = new AMap.Map("container", {
					        resizeEnable: true,
					        center: [113.739325, 22.180154],
					        zoom: 11
					    });
					
					    /* if (!isSupportCanvas()) {
					        alert('热力图仅对支持canvas的浏览器适用,您所使用的浏览器不能使用热力图功能,请换个浏览器试试~')
					    }
					    //判断浏览区是否支持canvas
					    function isSupportCanvas() {
					        var elem = document.createElement('canvas');
					        return !!(elem.getContext && elem.getContext('2d'));
					    } */
					    //详细的参数,可以查看heatmap.js的文档 http://www.patrick-wied.at/static/heatmapjs/docs.html
					    //参数说明如下:
					    /* visible 热力图是否显示,默认为true
					     * opacity 热力图的透明度,分别对应heatmap.js的minOpacity和maxOpacity
					     * radius 势力图的每个点的半径大小
					     * gradient  {JSON} 热力图的渐变区间 . gradient如下所示
					     *  {
					     .2:'rgb(0, 255, 255)',
					     .5:'rgb(0, 110, 255)',
					     .8:'rgb(100, 0, 255)'
					     }
					     其中 key 表示插值的位置, 0-1
					     value 为颜色值
					     */
					     /* var rainmap;
						    map.plugin(["AMap.Heatmap"], function () {
						        //初始化heatmap对象
						        rainmap = new AMap.Heatmap(map, {
						            radius: 25, //给定半径
						            opacity: [0.5, 0.8]
						            ,
						            gradient:{
						            	0.02:'#00FFFF',
						            	0.04:'#00BFFF',
						            	0.08: '#1874CD',
						                0.12: '#3A5FCD',
						                0.16: '#0000EE',
						                0.2: '#BF3EFF',
						                0.4: '#9A32CD',
						                1.0: '#551A8B'
						            }
						             
						        });
						        //设置数据集：该数据为北京部分“公园”数据
						        rainmap.setDataSet({
						            data: [],
						            max: 50
						        });
						    });
					    
					    var windmap;
					    map.plugin(["AMap.Heatmap"], function () {
					        //初始化heatmap对象
					        windmap = new AMap.Heatmap(map, {
					            radius: 25, //给定半径
					            opacity: [0.5, 0.8]
					            ,
					            gradient:{
					                0.014: 'blue',
					                0.163: 'green',
					                0.385: 'yellow',
					                0.668: 'orange',
					                1.0: 'red'
					            }
					             
					        });
					        //设置数据集：该数据为北京部分“公园”数据
					        windmap.setDataSet({
					            data: [],
					            max: 20.8
					        });
					    });
					    
					    var vismap;
					    map.plugin(["AMap.Heatmap"], function () {
					        //初始化heatmap对象
					        vismap = new AMap.Heatmap(map, {
					            radius: 25, //给定半径
					            opacity: [1, 1]
					            ,
					            gradient:{
					            	0.0025: '#3A5FCD',
					                0.005: '#00C5CD',
					                0.02: '#00FFFF',
					                0.1: '#9AFF9A',
					                1.0: '#ffffff'
					            }
					             
					        });
					        //设置数据集：该数据为北京部分“公园”数据
					        vismap.setDataSet({
					            data: [],
					            max: 10
					        });
					    });  */
					    <jsp:include flush="true" page="threshold2.jsp"></jsp:include> 
					   
						function showRain(res){
					    	
					    	for(var i=0;i<res.length;i+=1){
					    		var center=[];
							   	center.push(res[i].lng);
							   	center.push(res[i].lat);
						       // var circleMarker = new AMap.CircleMarker({
						       //    center:center,
						       //    radius:15,//3D视图下，CircleMarker半径不要超过64px
						       //    strokeColor:'white',
						       //    strokeWeight:2,
						       //    strokeOpacity:0.5,
						       //    fillColor:setRainColor(res[i].count),
						       //    fillOpacity:0.5,
						       //    zIndex:10,
						       //    bubble:true,
						       //    cursor:'pointer',
						       //    clickable: true
						       //  })
						       //  circleMarker.setMap(map)
								var southWest = new AMap.LngLat(res[i].lng-0.025, res[i].lat-0.025)
								var northEast = new AMap.LngLat(res[i].lng+0.025, res[i].lat+0.025)

								var bounds = new AMap.Bounds(southWest, northEast)

								var rectangle = new AMap.Rectangle({
									bounds: bounds,
									strokeColor:'white',
									strokeWeight: 6,
									strokeOpacity:0.5,
									strokeDasharray: [30,10],
									// strokeStyle还支持 solid
									strokeStyle: 'dashed',
									fillColor:setRainColor(res[i].count),
									fillOpacity:0.5,
									cursor:'pointer',
									zIndex:50,
								})

								rectangle.setMap(map);

								var text = new AMap.Text({
									text:res[i].count,
									anchor:'center', // 设置文本标记锚点

									cursor:'pointer',

									style:{
										'padding': '.75rem 1.25rem',
										'margin-bottom': '1rem',
										'border-radius': '.25rem',
										'background-color': setRainColor(res[i].count),

										'border-width': 0,
										'box-shadow': '0 2px 6px 0 rgba(114, 124, 245, .5)',
										'text-align': 'center',
										'font-size': '12px',
										'color': 'white'
									},
									position: center
								});

								text.setMap(map);
						      }
					    }
					    
						function showWind(res){
					    	
					    	for(var i=0;i<res.length;i+=1){
					    		var center=[];
							   	center.push(res[i].lng);
							   	center.push(res[i].lat);
						       // var circleMarker = new AMap.CircleMarker({
						       //    center:center,
						       //    radius:15,//3D视图下，CircleMarker半径不要超过64px
						       //    strokeColor:'white',
						       //    strokeWeight:2,
						       //    strokeOpacity:0.5,
						       //    fillColor:setWindColor(res[i].count),
						       //    fillOpacity:0.5,
						       //    zIndex:10,
						       //    bubble:true,
						       //    cursor:'pointer',
						       //    clickable: true
						       //  })
						       //  circleMarker.setMap(map)
								var southWest = new AMap.LngLat(res[i].lng-0.025, res[i].lat-0.025)
								var northEast = new AMap.LngLat(res[i].lng+0.025, res[i].lat+0.025)

								var bounds = new AMap.Bounds(southWest, northEast)

								var rectangle = new AMap.Rectangle({
									bounds: bounds,
									strokeColor:'white',
									strokeWeight: 6,
									strokeOpacity:0.5,
									strokeDasharray: [30,10],
									// strokeStyle还支持 solid
									strokeStyle: 'dashed',
									fillColor:setWindColor(res[i].count),
									fillOpacity:0.5,
									cursor:'pointer',
									zIndex:50,
								})

								rectangle.setMap(map);

								var text = new AMap.Text({
									text:res[i].count,
									anchor:'center', // 设置文本标记锚点

									cursor:'pointer',

									style:{
										'padding': '.75rem 1.25rem',
										'margin-bottom': '1rem',
										'border-radius': '.25rem',
										'background-color': setWindColor(res[i].count),

										'border-width': 0,
										'box-shadow': '0 2px 6px 0 rgba(114, 124, 245, .5)',
										'text-align': 'center',
										'font-size': '12px',
										'color': setWindTextColor(res[i].count)
									},
									position: center
								});

								text.setMap(map);
						      }




					    }
					    
					     function showVis(res){
					    	
					    	for(var i=0;i<res.length;i+=1){
					    		var center=[];
							   	center.push(res[i].lng);
							   	center.push(res[i].lat);
						       // var circleMarker = new AMap.CircleMarker({
						       //    center:center,
						       //    radius:15,//3D视图下，CircleMarker半径不要超过64px
						       //    strokeColor:'white',
						       //    strokeWeight:2,
						       //    strokeOpacity:0.5,
						       //    fillColor:setVisColor(res[i].count),
						       //    fillOpacity:0.5,
						       //    zIndex:10,
						       //    bubble:true,
						       //    cursor:'pointer',
						       //    clickable: true
						       //  })
						       //  circleMarker.setMap(map)

								var southWest = new AMap.LngLat(res[i].lng-0.025, res[i].lat-0.025)
								var northEast = new AMap.LngLat(res[i].lng+0.025, res[i].lat+0.025)

								var bounds = new AMap.Bounds(southWest, northEast)

								var rectangle = new AMap.Rectangle({
									bounds: bounds,
									strokeColor:'white',
									strokeWeight: 6,
									strokeOpacity:0.5,
									strokeDasharray: [30,10],
									// strokeStyle还支持 solid
									strokeStyle: 'dashed',
									fillColor:setVisColor(res[i].count),
									fillOpacity:0.5,
									cursor:'pointer',
									zIndex:50,
								})

								rectangle.setMap(map);

								var text = new AMap.Text({
									text:setVisText(res[i].count),
									anchor:'center', // 设置文本标记锚点

									cursor:'pointer',

									style:{
										'padding': '.75rem 1.25rem',
										'margin-bottom': '1rem',
										'border-radius': '.25rem',
										'background-color': setVisColor(res[i].count),

										'border-width': 0,
										'box-shadow': '0 2px 6px 0 rgba(114, 124, 245, .5)',
										'text-align': 'center',
										'font-size': '12px',
										'color': setVisTextColor(res[i].count)
									},
									position: center
								});

								text.setMap(map);
						        
						      }
					    }
					    
					     function setRainColor(count) {
						    	var vis=count/50;
						    	if (vis==0){
									return '#00FFFF'
								} else if (vis>0&&vis<0.04) {
						            return '#00BFFF'
						        } else if(vis>0.04&&vis<0.08||vis==0.04){
						            return '#1874CD'
						        } else if(vis>0.08&&vis<0.12||vis==0.08){
						            return '#3A5FCD'
						        } else if(vis>0.12&&vis<0.16||vis==0.12){
						            return '#0000EE'
						        } else if(vis>0.16&&vis<0.2||vis==0.16){
						            return '#EE7AE9'
						        } else if(vis>0.2&&vis<0.4||vis==0.2){
						            return '#BF3EFF'
						        } else if(vis>0.4&&vis<1||vis==0.4){
						            return '#9A32CD'
						        } else if(vis>1||vis==1){
						            return '#551A8B'
						        }
						    } 
					     
					     function setWindColor(count) {
						    	var vis=count/20.8;
						        if (vis<0.163) {
						            return 'blue'
						        } else if(vis>0.163&&vis<0.385||vis==0.163){
						            return 'green'
						        } else if(vis>0.385&&vis<0.668||vis==0.385){
						            return 'yellow'
						        } else if(vis>0.668&&vis<1||vis==0.668){
						            return 'orange'
						        } else if(vis>1||vis==1){
						            return 'red'
						        }
						    } 

					    function setVisColor(count) {
					    	var vis=count/10;
					        if (vis<0.005&&vis>0) {
					            return '#3A5FCD'
					        } else if(vis>0.005&&vis<0.02||vis==0.005){
					            return '#00C5CD'
					        } else if(vis>0.02&&vis<0.1||vis==0.02){
					            return '#00FFFF'
					        } else if(vis>0.1&&vis<1||vis==0.1){
					            return '#9AFF9A'
					        } else if(vis>1||vis==1){
					            return '#ffffff'
					        } else if(vis==0){
					        	return '#0000EE';
							}
					    }

					    function setVisText(count){
							if(count==0){
								return "NaN";
							}else{
								return count;
							}
						}

						function setVisTextColor(count){
							if(count==0){
								return 'white';
							}else{
								return 'black';
							}
						}

						function setWindTextColor(count){
							var vis=count/20.8;
							if(vis>0.385&&vis<0.668||vis==0.385){
								return 'black';
							}else{
								return 'white';
							}
						}



					</script>
				</div>
			</div>
		</div>
</body>
</html>