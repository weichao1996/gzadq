<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<title>港珠澳大桥灾害天气预报预警</title>
		
    	<link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css" />
    	<script src="https://how2j.cn/study/js/jquery/2.0.0/jquery.min.js"></script>
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
		<script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
		
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
					            	str1+="港珠澳大桥 降雨要素 预报值 已超过警戒值"+"${sessionScope.threshold.frain}"+"mm(所设置的警戒值)\n";
					            }
			            	}
			            	
			            	if(${sessionScope.threshold.fwind!=null}&&${sessionScope.threshold.fwind!=""}){
			            		if("${sessionScope.threshold.fwind}"<res[1].maxWind){
					            	str1+="港珠澳大桥 风力要素 预报值 已超过警戒值"+"${sessionScope.threshold.fwind}"+"m/s(所设置的警戒值)\n";
					            }
			            	}
			            	if(${sessionScope.threshold.fvis!=null}&&${sessionScope.threshold.fvis!=""}){
			            		if("${sessionScope.threshold.fvis}">res[1].minVis){
					            	str1+="港珠澳大桥 能见度要素 预报值 已低于警戒值"+"${sessionScope.threshold.fvis}"+"km(所设置的警戒值)\n";
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
		
 		
	</head>

	<body>
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
							<li style="background-color: #37424f">
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
							<li>
								<a href="safeVcar">
									<b class="sidebar-icon"><img src="Images/icon_news.png" width="16" height="16" /></b>
									<span class="text-normal">安全速度告警</span>
								</a>
							</li>
							
							
						</ul>
					</div>
				</div>
			</div>
			<div class="view-product background-color">
				<div class="padding-big background-color">
					<div id="container"></div>
					
					<jsp:include flush="true" page="threshold.jsp"></jsp:include>
					
			
					<script type="text/javascript">
						var path="actualData";
						var json=${json};
					
					    var map = new AMap.Map("container", {
					    	resizeEnable: true,
					        center: [113.74, 22.25],
					        zoom: 12
					    });
						
					    <jsp:include flush="true" page="threshold2.jsp"></jsp:include> 
					    
						for(var i=0;i<json.length;i+=1){
						    // 创建点、线、面覆盖物实例
						    var G3970 = new AMap.Marker({
						        position: new AMap.LngLat(json[i].lon, json[i].lat),
						        map:map
						    });
						    G3970.positionCode=json[i].positionCode;
						    G3970.obtid=json[i].obtid;
						   
						    G3970.on('click', showInfoClick);
						    G3970.on('dblclick', showInfoClick2);
						}
					    
						$.ajax({
					        type: 'GET',
					        url: '/getMinActual',
					        error: function () {
					            alert('网络错误');
					        },
					        success: function (res) {
					        	
						            	for(var i=0;i<res.length;i+=1){
						            		var str="";
						            		var temp=res[i];
						            		if(temp.length!=0){
						            			if(temp[0].rain>0){
							            			str+="当前正在降雨,";
						            			}
												if(temp[0].wind>10){
													str+="当前风速较大,";
						            			}
												if(temp[0].vis<1000){
													str+="当前能见度较低,";	
												}
						            		
						            		if(str.length>0){
						            			str=str.substring(0,str.length-1);
						            		}
						            		
						            		var center=[];
										   	center.push(temp[0].lon);
										   	center.push(temp[0].lat+0.02);
						            		  // 创建纯文本标记
						            	    var text = new AMap.Text({
						            	        text:str,
						            	        anchor:'center', // 设置文本标记锚点

						            	        cursor:'pointer',

						            	        style:{
						            	            'padding': '.75rem 1.25rem',
						            	            'margin-bottom': '1rem',
						            	            'border-radius': '.25rem',
						            	            'background-color': 'white',
						            	 
						            	            'border-width': 0,
						            	            'box-shadow': '0 2px 6px 0 rgba(114, 124, 245, .5)',
						            	            'text-align': 'center',
						            	            'font-size': '12px',
						            	            'color': 'grey'
						            	        },
						            	        position: center
						            	    });

						            	    text.setMap(map);
						            		}
						            			
						            		
										}
						            	
					        }
					    });
						
					    function showInfoClick2(e){
					    	obtid=e.target.obtid;
					    	document.getElementById("anfen").checked=true;
					    	getMinData();
					    	
					    }
					    
					    function getMinData(){
					    	$.ajax({
					            type: 'GET',
					            url: '/getMinActual/'+obtid,
					            error: function () {
					                alert('网络错误');
					            },
					            success: function (res) {
					                //var data=res;
					                //alert(data[0].datetime);
					                if(res.length>0){
					                	var x=[];
					                	var wind=[];
					                	var rain=[];
					                	var vis=[];
						                for(var i=res.length-1;i>=0;i--){     

						                	x.push(res[i].datetime.substring(14,16));    //挨个取出类别并填入类别数组
						                	wind.push(res[i].wind);
						                	rain.push(res[i].rain);
						                	vis.push(res[i].vis);
						                }
						                myChart.hideLoading();
						                myChart.setOption({
											xAxis: {
						                        data: x
						                    },
						                    series:[
						                    	{
													data:rain
												},
												{
													data:wind
												},
												{
													data:vis
												}
						                    ]
											
										});
						                document.getElementById('light').style.display='block';
								    	document.getElementById('fade').style.display='block'
								    	
								    	document.getElementById('tips').innerHTML="当前";
							    		if(res[0].rain>0){
							    			document.getElementById('tips').innerHTML+="正在降雨，";
							    		}
							    		if(res[0].wind>10){
							    			document.getElementById('tips').innerHTML+="风速较快，";
							    		}
							    		if(res[0].vis<1000){
							    			document.getElementById('tips').innerHTML+="能见度较低，";
								    	}
							    		document.getElementById('tips').innerHTML+="请减速慢行，注意保持车距！";
							    		if(document.getElementById('tips').innerHTML.length==15){
							    			document.getElementById('tips').innerHTML="";
							    		}
					                }else{
					                	alert("此站点暂无数据")
					                }
					                
					            }
					        });
					    }
					    
					    function getHourData(){
					    	$.ajax({
					            type: 'GET',
					            url: '/getHourActual/'+obtid,
					            error: function () {
					                alert('网络错误');
					            },
					            success: function (res) {
					                //var data=res;
					                //alert(data[0].datetime);
					                if(res.length>0){
					                	var x=[];
					                	var wind=[];
					                	var rain=[];
					                	var vis=[];
						                for(var i=res.length-1;i>=0;i--){     

						                	x.push(res[i].datetime.substring(11,13));    //挨个取出类别并填入类别数组
						                	wind.push(res[i].wind);
						                	rain.push(res[i].rain);
						                	vis.push(res[i].vis);
						                }
						                myChart.hideLoading();
						                myChart.setOption({
											xAxis: {
						                        data: x
						                    },
						                    series:[
						                    	{
													data:rain
												},
												{
													data:wind
												},
												{
													data:vis
												}
						                    ]
											
										});
						                
						                
						                document.getElementById('tips').innerHTML="当前";
							    		if(res[0].rain>0){
							    			document.getElementById('tips').innerHTML+="正在降雨，";
							    		}
							    		if(res[0].wind>10){
							    			document.getElementById('tips').innerHTML+="风速较快，";
							    		}
							    		if(res[0].vis<1000){
							    			document.getElementById('tips').innerHTML+="能见度较低，";
								    	}
							    		document.getElementById('tips').innerHTML+="请减速慢行，注意保持车距！";
							    		if(document.getElementById('tips').innerHTML.length==15){
							    			document.getElementById('tips').innerHTML="";
							    		}
					                }else{
					                	alert("此站点暂无数据")
					                }
					                
					            }
					        });
					    }
					      

				
					     function showInfoClick(e){
					        
						     	var position = e.target.getPosition();
						        var infoWindow = new AMap.InfoWindow({
						            position: position,
						            offset: new AMap.Pixel(0, -35),
						            content:'<div className="custom-infowindow input-card">' +
					                '<label style="color:grey">站名：       </label>' +e.target.positionCode+
					                '<label style="color:grey">站号：</label>'+e.target.obtid+
					                '<div class="input-item">' +
					                    '<div class="input-item-prepend">' +
					                        '<span class="input-item-text" >经纬度</span>' +
					                    '</div>' +
					                    '<input id="lnglat" type="text" value="'+position+'"/>' +
					                '</div>' +
					            '</div>'
						                
						        });
						
						        infoWindow.open(map);
						    
					    }
					    
						function anfen(){
							getMinData()
						}
						
						function anshi(){
							getHourData()
						}
					
					</script>
					
					
					<div id="light" class="white_content">
							<div id="tips" style="width:100%;height:30px;background-color:#37424f;color:white;font-size:15px;">
								
							</div>
							<div style="float:left;padding-left:75px;padding-top:20px;position: absolute;z-index:9999;">
				    			<label><input type="radio" name="type" id="anfen" onclick="anfen()" checked="checked">按分</label>
				    			<label><input type="radio" name="type" id="anshi" onclick="anshi()">按时</label>
							</div>
							<button type="button" class="close" aria-hidden="true" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
			      				&times;
			   				</button><br>
				   			
					
							<div id="main" style="width: 1000px;height:380px;"></div>
						    <script type="text/javascript">
						    
						        // 基于准备好的dom，初始化echarts实例
						        var myChart = echarts.init(document.getElementById('main'));
						 
						       option = {
						        color: ["#0B438B","#9bbb59","#CB4335"],
						    // title: {
						    //     text: '折线图堆叠'
						    // },
						    tooltip: { //框浮层内容格式器  提示框组件
						                trigger: 'axis',
						                formatter: '{b}'+'<br>'+'{a0}:{c0}' + '<br>' + '{a1}:{c1}' + '<br>' + '{a2}:{c2}'
						            },
						
						    legend: {
						             
						                data: ['降水(mm)', '风力(m/s)', '能见度(m)'],
						                textStyle: {
						                    color: "#000",
						                    fontsize: 25
						                }
						            },
						    grid: {
						                left: '15%',
						                bottom: '3%',
						                containLabel: true
						            },
						    toolbox: {
						        feature: {
						            saveAsImage: {}
						        }
						    },
						
						    xAxis: {
				                type: 'category',
				                boundaryGap: true,
				                /* data:function (){
						        	
						        	var list = [];
						            for (var i = 0; i < data.length-30; i++) {
						                list.push(data[i].datetime);
						            } 
						            return list;
						        }() , */
						        data:[1,2,3,4,5,6],
				                axisLabel: {
				                      interval: 0
				                    } 
				                   
				            },
						    yAxis: [{
						                    boundaryGap: [0, '50%'],
						                    axisLine: {
						                        lineStyle: {
						                            color: '#0B438B'
						                        }
						                    },
						                    type: 'value',
						                    name: '降水(mm)',
						                    position: 'left',//Y轴在图的坐边
						                    offset: 120,//坐标轴移动120
						                    axisLabel: {
						                        formatter: function(value, index) {
						                            return value;
						                        }
						                    },
						                    splitLine: {
						                        show: false,
						                    },
						                },
						                {
						                    boundaryGap: [0, '50%'],
						                    axisLine: {
						                        lineStyle: {
						                            color: '#9bbb59'
						                        }
						                    },
						                    splitLine: {
						                        show: false,
						                    },
						                    type: 'value',
						                    name: '风力(m/s)',
						                    position: 'left',
						                    offset: 60,//
						                    axisLabel: {
						                        formatter: function(value, index) {
						
						                            return value;
						                        }
						                    }
						                },
						                {
						                    boundaryGap: [0, '50%'],
						                    axisLine: {
						                        lineStyle: {
						                            color: '#CB4335'
						                        }
						                    },
						                    splitLine: {
						                        show: false,
						                    },
						                    type: 'value',
						                    name: '能见度(m)',
						                    position: 'left',
						                    axisLabel: {
						                        formatter: function(value, index) {
						                            return value;
						                        }
						                    },
						                    axisTick: {
						                        inside: 'false',
						                        length: 10,
						                    }
						                },
						            ],
						
						    series: [{
						                    name: '降水(mm)',
						                    type: 'line',
						                    //data: [2,1,2,1,2,1],
						                    lineStyle: {
						                        color: "#0B438B"//折线颜色
						                    },
						                    yAxisIndex: 0,
						                },
						                {
						                    name: '风力(m/s)',
						                    type: 'line',
						                    //data: [7,8,4,2,1,2],
						                    lineStyle: {
						                        color: "#9bbb59"
						                    },
						                    yAxisIndex: 1,
						                },
						                {
						                    name: '能见度(m)',
						                    type: 'line',
						                    //data: [9,5,6,9,7,10],
						                    lineStyle: {
						                        color: "#CB4335"
						                    },
						                    yAxisIndex: 2,
						                }
						            ]
						
						    };
						 
						    // 使用刚指定的配置项和数据显示图表。
						    myChart.setOption(option);
						    window.onresize = myChart.resize;
						    </script>
					</div>
			        <div id="fade" class="black_overlay"></div>
			        
				</div>
			</div>
		</div>
		
		
		
        
        
			 
	</body>

</html>