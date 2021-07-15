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
	<script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>

    <style type="text/css">
			#box::-webkit-scrollbar,#box2::-webkit-scrollbar,#box3::-webkit-scrollbar{
                display: none;
            }
	</style>
	<script type="text/javascript">
		window.onload = function() {
    var a = document.getElementById('box');
    var b = document.getElementById('box2');
    var c = document.getElementById('box3');
    var scroll_width = 100;
     
    // if(document.addEventListener){
    //     document.addEventListener('DOMMouseScroll', mousewheel_event, false); // FF
    // }
    a.onmousewheel = mousewheel_event; // IE/Opera/Chrome
     
    function mousewheel_event(e) {
        var e = e || window.event, v;
        e.wheelDelta ? v=e.wheelDelta : v=e.detail;
        if(v>3||-v>3) v=-v;
        v>0 ? a.scrollLeft+=scroll_width : a.scrollLeft-=scroll_width;
    }
    
    b.onmousewheel = mousewheel_event2; // IE/Opera/Chrome
    
    function mousewheel_event2(e) {
        var e = e || window.event, v;
        e.wheelDelta ? v=e.wheelDelta : v=e.detail;
        if(v>3||-v>3) v=-v;
        v>0 ? b.scrollLeft+=scroll_width : b.scrollLeft-=scroll_width;
    }
    
 	c.onmousewheel = mousewheel_event3; // IE/Opera/Chrome
    
    function mousewheel_event3(e) {
        var e = e || window.event, v;
        e.wheelDelta ? v=e.wheelDelta : v=e.detail;
        if(v>3||-v>3) v=-v;
        v>0 ? c.scrollLeft+=scroll_width : c.scrollLeft-=scroll_width;
    }
};
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
				<a href="safeVcar"
					class="topbar-home-link topbar-btn text-center fl"><span>灾害天气预报预警</span></a>
			</div>
		</div>
	</div>
	<div class="view-body">

		<div class="view-sidebar">

			<div class="sidebar-content">

				<div class="sidebar-nav">

					<ul class="sidebar-trans">
						<li><a href="actualData"> <b class="sidebar-icon"><img
									src="Images/icon_cost.png" width="16" height="16" /></b> <span
								class="text-normal">大桥天气实况</span>
						</a></li>
						<li style="background-color: #37424f"><a href="forecastData">
								<b class="sidebar-icon"><img
									src="Images/icon_authentication.png" width="16" height="16" /></b>
								<span class="text-normal">大桥天气预报</span>
						</a></li>
						<li>
								<a href="forecastDataPoint">
									<b class="sidebar-icon"><img src="Images/icon_authentication.png" width="16" height="16" /></b>
									<span class="text-normal">大桥天气预报(格点)</span>
								</a>
							</li>
						<li><a href="safeVcar"> <b class="sidebar-icon"><img
									src="Images/icon_news.png" width="16" height="16" /></b> <span
								class="text-normal">安全行驶速度</span>
						</a></li>


					</ul>
				</div>
			</div>
		</div>
		<div class="view-product background-color">
			<div class="padding-big background-color">
				<div id="container"></div>

				<jsp:include flush="true" page="threshold.jsp"></jsp:include>

				<div class="input-card" style="color: gray">
					<span style="color: red">说明：</span>
					<span>1.本页面主要对降水、风力、能见度三要素进行了近24小时（逐小时）、近2-3天（逐3小时）和近4-6天（逐6小时）的预报预警</span>
					<span>2.预报数据一般会在每天的上午和下午更新</span>
					<span>3.采用5km*5km的格点预报形式，将覆盖在大桥上的7个格点实体化成站点，为大桥上各个路段提供预报预警</span>
					<span>4.单击站点可查看具体预报数据以及数据趋势图</span>
					<span>5.当降雨量>0mm或风速>10m/s或能见度<1000m的频率大于三分之一则给出预警信息</span>
				</div>



				<script>
					var path="forecastData";
					zhandian=[];
					var map = new AMap.Map("container", {
				    	resizeEnable: true,
				        center: [113.71, 22.25],
				        zoom: 12
				    });
					<jsp:include flush="true" page="threshold2.jsp"></jsp:include> 
					$.ajax({
				        type: 'GET',
				        url: '/getObtid',
				        error: function () {
				            alert('网络错误');
				        },
				        success: function (res1) {
							$.ajax({
								type: 'GET',
								url: '/getForecastDataDiv',
								error: function () {
									alert('网络错误');
								},
								success: function (res) {

									for(var i=0;i<res1.length;i+=1){
										// 创建点、线、面覆盖物实例
										var G3970 = new AMap.Marker({
											position: new AMap.LngLat(res1[i].lon, res1[i].lat),
											map:map,
											icon: '<%=request.getContextPath()%>/img/'+i+'.ico'
										});
										G3970.obtid=res1[i].obtid;
										G3970.on('click', showInfoClick);
										zhandian.push(res1[i].obtid);

										//预警标签
										// for(var i=0;i<res.length;i+=1){
										var str=i+1+"| ";
										var temp=res[i];
										var rain1=0;
										var wind1=0;
										var vis1=0;
										var rain3=0;
										var wind3=0;
										var vis3=0;
										var rain6=0;
										var wind6=0;
										var vis6=0;


										// for(var j=0;j<temp.length;j+=1){
										// 	if(temp[j].rain>0){
										// 		if(j<24){
										// 			if(str.indexOf("预计24小时内即将降雨")==-1){
										// 				str+="预计24小时内即将降雨,";
										// 			}
										// 		}else if(j>=24&&j<40){
										// 			if(str.indexOf("预计2-3天内即将降雨")==-1){
										// 				str+="预计2-3天内即将降雨,";
										// 			}
										// 		}else if(j>=40&&j<52){
										// 			if(str.indexOf("预计4-6天内即将降雨")==-1){
										// 				str+="预计4-6天内即将降雨,";
										// 			}
										// 		}
										// 	}
										// 	if(temp[j].wind>10){
										// 		if(j<24){
										// 			if(str.indexOf("预计24小时内风速较快")==-1){
										// 				str+="预计24小时内风速较快,";
										// 			}
										// 		}else if(j>=24&&j<40){
										// 			if(str.indexOf("预计2-3天内风速较快")==-1){
										// 				str+="预计2-3天内风速较快,";
										// 			}
										// 		}else if(j>=40&&j<52){
										// 			if(str.indexOf("预计4-6天内风速较快")==-1){
										// 				str+="预计4-6天内风速较快,";
										// 			}
										// 		}
										// 	}
										// 	if(temp[j].vis<1){
										// 		if(j<24){
										// 			if(str.indexOf("预计24小时内能见度较低")==-1){
										// 				str+="预计24小时内能见度较低,";
										// 			}
										// 		}else if(j>=24&&j<40){
										// 			if(str.indexOf("预计2-3天内能见度较低")==-1){
										// 				str+="预计2-3天内能见度较低,";
										// 			}
										// 		}else if(j>=40&&j<52){
										// 			if(str.indexOf("预计4-6天内能见度较低")==-1){
										// 				str+="预计4-6天内能见度较低,";
										// 			}
										// 		}
										// 	}
										// }

										for(var j=0;j<temp.length;j+=1){
											if(temp[j].rain>0){
												if(j<24){
													rain1++;
												}else if(j>=24&&j<40){
													rain3++;
												}else if(j>=40&&j<52){
													rain6++;
												}
											}
											if(temp[j].wind>10){
												if(j<24){
													wind1++;
												}else if(j>=24&&j<40){
													wind3++;
												}else if(j>=40&&j<52){
													wind6++;
												}
											}
											if(temp[j].vis<1&&temp[j].vis>0){
												if(j<24){
													vis1++;
												}else if(j>=24&&j<40){
													vis3++;
												}else if(j>=40&&j<52){
													vis6++;
												}
											}
										}


										if(rain1>=8){
											str+="预计24小时内即将降雨,";
										}
										if(wind1>=8){
											str+="预计24小时内风速较快,";
										}
										if(vis1>=8){
											str+="预计24小时内能见度较低,";
										}
										if(rain3>=5){
											str+="预计2-3天内即将降雨,";
										}
										if(wind3>=5){
											str+="预计2-3天内风速较快,";
										}
										if(vis3>=5){
											str+="预计2-3天内能见度较低,";
										}
										if(rain6>=4){
											str+="预计4-6天内即将降雨,";
										}
										if(wind6>=4){
											str+="预计4-6天内风速较快,";
										}
										if(vis6>=4){
											str+="预计4-6天内能见度较低,";
										}
										if(str.length>3){
											str=str.substring(0,str.length-1);
											// 设置label标签
											// label默认蓝框白底左上角显示，样式className为：amap-marker-label
											G3970.setLabel({

												content: "<div class='info'>"+str+"</div>", //设置文本标注内容
												direction: 'top' //设置文本标注方位
											});
										}



										// var center=[];
										// center.push(temp[0].x);
										// center.push(temp[0].y+0.02);
										//   // 创建纯文本标记
										// var text = new AMap.Text({
										//     text:str,
										//     anchor:'center', // 设置文本标记锚点
										//
										//     cursor:'pointer',
										//
										//     style:{
										//         'padding': '.75rem 1.25rem',
										//         'margin-bottom': '1rem',
										//         'border-radius': '.25rem',
										//         'background-color': 'white',
										//
										//         'border-width': 0,
										//         'box-shadow': '0 2px 6px 0 rgba(114, 124, 245, .5)',
										//         'text-align': 'center',
										//         'font-size': '12px',
										//         'color': 'grey'
										//     },
										//     position: center
										// });
										//
										// text.setMap(map);

										// }

									}



								}
							});

				        }
				    });
					


				    function showInfoClick(e){
				    	
						obtid=e.target.obtid;
						getObtidData();
				               
				    }

				    function getObtidData(){
						$.ajax({
							type: 'GET',
							url: '/getForecastDataDiv/'+obtid,
							error: function () {
								alert('网络错误');
							},
							success: function (res) {
								var str="";
								var str2="";
								var str3="";


								str+="<tr><td colspan='2'>预报时间</td>";
								for(var j=0;j<24;j+=1){
									str+="<td>"+res[j].forecasttime.substring(11,16)+"</td>";
								}
								str+="</tr>";
								str+="<tr><td colspan='2'>降雨(mm)</td>";
								for(var j=0;j<24;j+=1){
									str+="<td>"+res[j].rain+"</td>";
								}
								str+="</tr>";
								str+="<tr><td colspan='2'>风速(m/s)</td>";
								for(var j=0;j<24;j+=1){
									str+="<td>"+res[j].wind+"</td>";
								}
								str+="</tr>";
								str+="<tr><td colspan='2'>能见度(km)</td>";
								for(var j=0;j<24;j+=1){
									str+="<td>"+res[j].vis+"</td>";
								}
								str+="</tr>";

								str2+="<tr><td>预报时间</td>";
								for(var j=24;j<40;j+=1){
									str2+="<td>"+res[j].forecasttime.substring(5,16)+"</td>";
								}
								str2+="</tr>";
								str2+="<tr><td>降雨(mm)</td>";
								for(var j=24;j<40;j+=1){
									str2+="<td>"+res[j].rain+"</td>";
								}
								str2+="</tr>";
								str2+="<tr><td>风速(m/s)</td>";
								for(var j=24;j<40;j+=1){
									str2+="<td>"+res[j].wind+"</td>";
								}
								str2+="</tr>";
								str2+="<tr><td>能见度(km)</td>";
								for(var j=24;j<40;j+=1){
									str2+="<td>"+res[j].vis+"</td>";
								}
								str2+="</tr>";

								str3+="<tr><td>预报时间</td>";
								for(var j=40;j<52;j+=1){
									str3+="<td>"+res[j].forecasttime.substring(5,16)+"</td>";
								}
								str3+="</tr>";
								str3+="<tr><td>降雨(mm)</td>";
								for(var j=40;j<52;j+=1){
									str3+="<td>"+res[j].rain+"</td>";
								}
								str3+="</tr>";
								str3+="<tr><td>风速(m/s)</td>";
								for(var j=40;j<52;j+=1){
									str3+="<td>"+res[j].wind+"</td>";
								}
								str3+="</tr>";
								str3+="<tr><td>能见度(km)</td>";
								for(var j=40;j<52;j+=1){
									str3+="<td>"+res[j].vis+"</td>";
								}
								str3+="</tr>";




								document.getElementById("tbody").innerHTML=str;
								document.getElementById("tbody2").innerHTML=str2;
								document.getElementById("tbody3").innerHTML=str3;

								var x=[];
								var wind=[];
								var rain=[];
								var vis=[];
								for(var i=0;i<24;i++){

									x.push(res[i].forecasttime.substring(11,13));    //挨个取出类别并填入类别数组
									wind.push(res[i].wind);
									rain.push(res[i].rain);
									vis.push(res[i].vis*1000);
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

								var x2=[];
								var wind2=[];
								var rain2=[];
								var vis2=[];
								for(var i=24;i<40;i++){

									x2.push(res[i].forecasttime.substring(8,10)+"("+res[i].forecasttime.substring(11,13)+")");    //挨个取出类别并填入类别数组
									wind2.push(res[i].wind);
									rain2.push(res[i].rain);
									vis2.push(res[i].vis*1000);
								}
								myChart2.hideLoading();
								myChart2.setOption({
									xAxis: {
										data: x2
									},
									series:[
										{
											data:rain2
										},
										{
											data:wind2
										},
										{
											data:vis2
										}
									]

								});

								var x3=[];
								var wind3=[];
								var rain3=[];
								var vis3=[];
								for(var i=40;i<52;i++){

									x3.push(res[i].forecasttime.substring(8,10)+"("+res[i].forecasttime.substring(11,13)+")");    //挨个取出类别并填入类别数组
									wind3.push(res[i].wind);
									rain3.push(res[i].rain);
									vis3.push(res[i].vis*1000);
								}
								myChart3.hideLoading();
								myChart3.setOption({
									xAxis: {
										data: x3
									},
									series:[
										{
											data:rain3
										},
										{
											data:wind3
										},
										{
											data:vis3
										}
									]

								});
								document.getElementById('light').style.display='block';
								document.getElementById('fade').style.display='block';

								document.getElementById('getLast').style.display='block';
								document.getElementById('getNext').style.display='block';
								if(getArrayIndex(zhandian,obtid)==zhandian.length-1){document.getElementById('getNext').style.display='none'}
								if(getArrayIndex(zhandian,obtid)==0){document.getElementById('getLast').style.display='none'}

								var tips="";
								var rain1=0;
								var wind1=0;
								var vis1=0;
								var rain3=0;
								var wind3=0;
								var vis3=0;
								var rain6=0;
								var wind6=0;
								var vis6=0;

								// for(var j=0;j<res.length;j+=1){
								// 	if(res[j].rain>0){
								// 		if(j<24){
								// 			if(tips.indexOf("预计24小时内即将降雨")==-1){
								// 				tips+="预计24小时内即将降雨,";
								// 			}
								// 		}else if(j>=24&&j<40){
								// 			if(tips.indexOf("预计2-3天内即将降雨")==-1){
								// 				tips+="预计2-3天内即将降雨,";
								// 			}
								// 		}else if(j>=40&&j<52){
								// 			if(tips.indexOf("预计4-6天内即将降雨")==-1){
								// 				tips+="预计4-6天内即将降雨,";
								// 			}
								// 		}
								// 	}
								// 	if(res[j].wind>10){
								// 		if(j<24){
								// 			if(tips.indexOf("预计24小时内风速较快")==-1){
								// 				tips+="预计24小时内风速较快,";
								// 			}
								// 		}else if(j>=24&&j<40){
								// 			if(tips.indexOf("预计2-3天内风速较快")==-1){
								// 				tips+="预计2-3天内风速较快,";
								// 			}
								// 		}else if(j>=40&&j<52){
								// 			if(tips.indexOf("预计4-6天内风速较快")==-1){
								// 				tips+="预计4-6天内风速较快,";
								// 			}
								// 		}
								// 	}
								// 	if(res[j].vis<1){
								// 		if(j<24){
								// 			if(tips.indexOf("预计24小时内能见度较低")==-1){
								// 				tips+="预计24小时内能见度较低,";
								// 			}
								// 		}else if(j>=24&&j<40){
								// 			if(tips.indexOf("预计2-3天内能见度较低")==-1){
								// 				tips+="预计2-3天内能见度较低,";
								// 			}
								// 		}else if(j>=40&&j<52){
								// 			if(tips.indexOf("预计4-6天内能见度较低")==-1){
								// 				tips+="预计4-6天内能见度较低,";
								// 			}
								// 		}
								// 	}
								// }
								for(var j=0;j<res.length;j+=1){
									if(res[j].rain>0){
										if(j<24){
											rain1++;
										}else if(j>=24&&j<40){
											rain3++;
										}else if(j>=40&&j<52){
											rain6++;
										}
									}
									if(res[j].wind>10){
										if(j<24){
											wind1++;
										}else if(j>=24&&j<40){
											wind3++;
										}else if(j>=40&&j<52){
											wind6++;
										}
									}
									if(res[j].vis<1&&res[j].vis>0){
										if(j<24){
											vis1++;
										}else if(j>=24&&j<40){
											vis3++;
										}else if(j>=40&&j<52){
											vis6++;
										}
									}
								}




								if(rain1>=8){
									tips+="预计24小时内即将降雨,";
								}
								if(wind1>=8){
									tips+="预计24小时内风速较快,";
								}
								if(vis1>=8){
									tips+="预计24小时内能见度较低,";
								}
								if(rain3>=5){
									tips+="预计2-3天内即将降雨,";
								}
								if(wind3>=5){
									tips+="预计2-3天内风速较快,";
								}
								if(vis3>=5){
									tips+="预计2-3天内能见度较低,";
								}
								if(rain6>=4){
									tips+="预计4-6天内即将降雨,";
								}
								if(wind6>=4){
									tips+="预计4-6天内风速较快,";
								}
								if(vis6>=4){
									tips+="预计4-6天内能见度较低,";
								}
								if(tips.length>0){
									tips=tips.substring(0,tips.length-1);
								}
								document.getElementById('tips').innerHTML="站点"+(getArrayIndex(zhandian,obtid)+1)+" | "+tips;
							}
						});
					}
					   
					    
					</script>


				<div id="light" class="white_content_fore">
					<div id="tips" style="width:100%;height:30px;background-color:#37424f;color:white;font-size:15px;">

					</div>

					<%--<button type="button" class="close" aria-hidden="true"
						onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
						&times;</button>
					<br>--%>
					<div id="lightLeft" style="width:35%;height:80%;float:left;">
						<div style="height:10%;"></div>
						<div class="panel panel-info" style="height:30%;border: 1px solid #37424f;">
							<div class="panel-heading"><img src="<%=request.getContextPath()%>/img/天气预报.png"/>&nbsp;&nbsp;近24小时预报</div>
							<div class="panel-body">
								<div id='box'
									style=" overflow-y: hidden;">
									<div id="content" style="width: 300%;">
		
										<table class="table table-hover">
							  <tbody id="tbody">
							     
							  </tbody>
						</table>
									</div>
								</div>
							</div>
						</div>
					
						<div class="panel panel-info" style="height: 30%;border: 1px solid #37424f;">
							<div class="panel-heading"><img src="<%=request.getContextPath()%>/img/天气预报.png"/>&nbsp;&nbsp;未来2-3天预报（逐3小时）</div>
							<div class="panel-body" style="overflow-y: hidden;">
								<div id='box2'
									style="overflow-y: hidden;">
									<div id="content2" style="width: 400%;">

										<table class="table table-hover">
							  <tbody id="tbody2">
							     
							  </tbody>
						</table>
									</div>
								</div>
							</div>
						</div>
					
					
						<div class="panel panel-info" style="height: 30%;border: 1px solid #37424f;">
							<div class="panel-heading"><img src="<%=request.getContextPath()%>/img/天气预报.png"/>&nbsp;&nbsp;未来4-6天预报（逐6小时）</div>
							<div class="panel-body" style="overflow-y: hidden;">
								<div id='box3'
									style="overflow-y: hidden;">
									<div id="content3" style="width: 300%;">

										<table class="table table-hover">
							  <tbody id="tbody3">
							     
							  </tbody>
						</table>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					<div id="lightRight" style="float:right;width:64%;height:95%;" >
						<div id="main" style="width: 990px;height:290px;border: 1px solid #37424f;"></div>
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
						                   // data: [9,5,6,9,7,10],
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
						    
						    <div id="main2" style="width: 990px;height:290px;border: 1px solid #37424f;"></div>
						    <script type="text/javascript">
						    
						        // 基于准备好的dom，初始化echarts实例
						        var myChart2 = echarts.init(document.getElementById('main2'));
						 
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
						                   // data: [9,5,6,9,7,10],
						                    lineStyle: {
						                        color: "#CB4335"
						                    },
						                    yAxisIndex: 2,
						                }
						            ]
						
						    };
						 
						    // 使用刚指定的配置项和数据显示图表。
						    myChart2.setOption(option);
						    window.onresize = myChart2.resize;
						    </script>
						    
						    <div id="main3" style="width: 990px;height:290px;border: 1px solid #37424f;"></div>
						    <script type="text/javascript">
						    
						        // 基于准备好的dom，初始化echarts实例
						        var myChart3 = echarts.init(document.getElementById('main3'));
						 
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
						                   // data: [9,5,6,9,7,10],
						                    lineStyle: {
						                        color: "#CB4335"
						                    },
						                    yAxisIndex: 2,
						                }
						            ]
						
						    };
						 
						    // 使用刚指定的配置项和数据显示图表。
						    myChart3.setOption(option);
						    window.onresize = myChart3.resize;
						    </script>

				


					</div>
				</div>
				<div id="fade" class="black_overlay">
					<a onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'" href="#">
						<img class="close_btn" src="<%=request.getContextPath()%>/img/close.png"/>
					</a>
					<a onclick="getLast()" href="#" id="getLast"><img class="left_btn" src="<%=request.getContextPath()%>/img/left.png"/></a>
					<a onclick="getNext()" href="#" id="getNext"><img class="right_btn" src="<%=request.getContextPath()%>/img/right.png"/></a>
				</div>
				



			</div>
		</div>
	</div>

	<script type="application/javascript">
		function getNext(){
			var index = getArrayIndex(zhandian,obtid);
			obtid=zhandian[index+1];
			getObtidData();

		}

		function getLast(){
			var index = getArrayIndex(zhandian,obtid);
			obtid=zhandian[index-1];
			getObtidData();

		}

		function getArrayIndex(arr, obj) {
			var i = arr.length;
			while (i--) {
				if (arr[i] === obj) {
					return i;
				}
			}
			return -1;
		}

	</script>
</body>
</html>