var int=self.setInterval("clock()",5*1000);
function clock()
{
	if(${sessionScope.threshold !=null}&&${sessionScope.threshold.radius}>0&&${sessionScope.threshold.lnglat}!=null){
		$.ajax({
            type: 'GET',
            url: '/getDetailIn',
            error: function () {
                alert('网络错误');
            },
            success: function (res) {
            	var str0="";
            	var str1="";
            	if(${sessionScope.threshold.arain}<res[0].maxRain){
	            	str0+="港珠澳大桥 降雨要素 实况值 已超过警戒值"+${sessionScope.threshold.arain}+"mm(所设置的警戒值)\n"; 
	            }
            	if(${sessionScope.threshold.awind}<res[0].maxWind){
	            	str0+="港珠澳大桥 风力要素 实况值 已超过警戒值"+${sessionScope.threshold.awind}+"m/s(所设置的警戒值)\n";
	            }
            	if(${sessionScope.threshold.avis}>res[0].minVis/1000){
	            	str0+="港珠澳大桥 能见度要素 实况值 已低于警戒值"+${sessionScope.threshold.avis}+"km(所设置的警戒值)\n";
	            }
            	if(${sessionScope.threshold.frain}<res[1].maxRain){
	            	str1+="港珠澳大桥 降雨要素 预报值 已超过警戒值"+${sessionScope.threshold.frain}+"mm(所设置的警戒值)\n";
	            }
            	if(${sessionScope.threshold.fwind}<res[1].maxWind){
	            	str1+="港珠澳大桥 风力要素 预报值 已超过警戒值"+${sessionScope.threshold.fwind}+"m/s(所设置的警戒值)\n";
	            }
            	if(${sessionScope.threshold.fvis}>res[1].minVis){
	            	str1+="港珠澳大桥 能见度要素 预报值 已低于警戒值"+${sessionScope.threshold.fvis}+"km(所设置的警戒值)\n";
	            }
            	if(str0!="") alert(str0);
            	if(str1!="") alert(str1);
            }
        }); 
	}
	
}