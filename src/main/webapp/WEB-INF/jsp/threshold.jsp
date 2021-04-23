<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>


<script type="text/javascript">
		window.onkeydown = function (event) {
		    var event = event || window.event
		    //esc 键被按下执行
		    if (event.keyCode == 27) {
		        $('.close_btn').click();
		    }
		};
		
		var userid="1006";
		function getThreshold(){
			
			$.ajax({
	            type: 'GET',
	            url: '/getThreshold',
	            error: function () {
	                alert('网络错误');
	            },
	            success: function (res) {
	            	
	            	if(res!=null&&res!=""){
	            		var str="";
	            		str += "<form action='/updateThreshold/"+path+"' method='post' name='form' id='form'>"+
	            					"<span class='text-muted'>实况降水(mm)</span><input type='text' class='form-control' id='arain' name='arain' value='"+res.arain+"' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
	            					"<span class='text-muted'>实况风力(m/s)</span><input type='text' class='form-control' id='awind' name='awind' value='"+res.awind+"' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
	            					"<span class='text-muted'>实况能见度(km)</span><input type='text' class='form-control' id='avis' name='avis' value='"+res.avis+"' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
	            					"<span class='text-muted'>预报降水(mm)</span><input type='text' class='form-control' id='frain' name='frain' value='"+res.frain+"' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
	            					"<span class='text-muted'>预报风力(m/s)</span><input type='text' class='form-control' id='fwind' name='fwind' value='"+res.fwind+"' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
	            					"<span class='text-muted'>预报能见度(km)</span><input type='text' class='form-control' id='fvis' name='fvis' value='"+res.fvis+"' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
	            					"<span class='text-muted' style='float:left'>警戒圈范围(km)(右键点击地图设置警戒中心点)</span><div id='tishi' style='color:red'></div><input type='text' class='form-control' id='radius' name='radius' value='"+res.radius+"' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
	            					//"<input name='userid' type='hidden' value='"+res.userid+"'>"+
	            			   		//"<button type='submit' class='btn btn-primary'>修改</button>"+
	            			   "</form>";
	            		document.getElementById("modal-body").innerHTML=str; 
	            		document.getElementById("submit").innerHTML="修改";
	            	}else{
	            		var str="";
	            		str += "<form action='/addThreshold/"+path+"' method='post' name='form' id='form'>"+
    					"<span class='text-muted'>实况降水(mm)</span><input type='text' class='form-control' id='arain' name='arain' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
    					"<span class='text-muted'>实况风力(m/s)</span><input type='text' class='form-control' id='awind' name='awind' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
    					"<span class='text-muted'>实况能见度(km)</span><input type='text' class='form-control' id='avis' name='avis' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
    					"<span class='text-muted'>预报降水(mm)</span><input type='text' class='form-control' id='frain' name='frain' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
    					"<span class='text-muted'>预报风力(m/s)</span><input type='text' class='form-control' id='fwind' name='fwind' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
    					"<span class='text-muted'>预报能见度(km)</span><input type='text' class='form-control' id='fvis' name='fvis' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
    					"<span class='text-muted' style='float:left'>警戒圈范围(km)(右键点击地图设置警戒中心点)</span><div id='tishi' style='color:red'></div><input type='text' class='form-control' id='radius' name='radius' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")' onafterpaste='this.value=this.value.replace(\/\\D\/g,\"\")'><br></br>"+
    					//"<input name='userid' type='hidden' value='"+userid+"'>"+
    			   		//"<button type='submit' class='btn btn-primary'>提交</button>"+
    			   	"</form>";
    					document.getElementById("modal-body").innerHTML=str;
	            	}
	            	//document.getElementById('yuzhibiao').style.display='block';
	            	//document.getElementById('yuzhiblack').style.display='block';
	                
	            }
	        });
		}
		
		function check(){
			
			if(document.getElementById('radius').value==""){
				document.getElementById('tishi').innerHTML="不允许为空";
			}else{
				document.form.submit();
			}
			
		}
		</script>



		<button class="yuzhi" onclick="getThreshold()" data-toggle="modal" data-target="#myModal">
							<span>阈值</span>
		</button>
		
		
		<!-- <div id="yuzhibiao" class="panel panel-info">
					  <div class="panel-heading">阈值设定
						  <button type="button" class="close" aria-hidden="true" 
						  onclick = "document.getElementById('yuzhibiao').style.display='none';document.getElementById('yuzhiblack').style.display='none'">
	      				    &times;
	   				      </button><br>
   					  </div>
					  <div id="panel-body" class="panel-body">
					 		
					  </div>
			  </div>
        <div id="yuzhiblack" class="black_overlay"></div> -->
        
        
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">阈值设定</h4>
          </div>
          <div class="modal-body" id="modal-body">
            
          </div>
          <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
            <button class="btn btn-primary" type="button" type="submit" id="submit" onClick="check()">提交</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
</div>
