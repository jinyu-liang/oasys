function getUserskill(){   
	$.ajax({
		  type : "POST",
		  async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
		  url: 'useraby/getUserskill.do',
		  dataType:'json',
		  cache: false,
		  success : function(data) {
		      //请求成功时执行该函数内容，result即为服务器返回的json对象
			  if("success" == data.msgcode){
				  $("#A1").attr("data-percent",data.BUSINESS_P);
				  $("#A11").replaceWith(data.BUSINESS_P);
				  $("#A2").attr("data-percent",data.TECHNICAL_P);
				  $("#A22").replaceWith(data.TECHNICAL_P);
				  $("#A3").attr("data-percent",data.COMMUNICATION_P);
				  $("#A33").replaceWith(data.COMMUNICATION_P);
				  $("#A4").attr("data-percent",data.INNOVATION_P);
				  $("#A44").replaceWith(data.INNOVATION_P);
				  $("#A5").attr("data-percent",data.LEARN_P);
				  $("#A55").replaceWith(data.LEARN_P);
				  
					$('.easy-pie-chart.percentage').each(function(){
						var barColor = $(this).data('color') || '#555';
						var trackColor = '#E2E2E2';
						var size = parseInt($(this).data('size')) || 72;
						$(this).easyPieChart({
							barColor: barColor,
							trackColor: trackColor,
							scaleColor: false,
							lineCap: 'butt',
							lineWidth: parseInt(size/10),
							animate:false,
							size: size
						}).css('color', barColor);
					});
				 
		      }else{ 
			  $('.easy-pie-chart.percentage').each(function(){
					var barColor = $(this).data('color') || '#555';
					var trackColor = '#E2E2E2';
					var size = parseInt($(this).data('size')) || 72;
					$(this).easyPieChart({
						barColor: barColor,
						trackColor: trackColor,
						scaleColor: false,
						lineCap: 'butt',
						lineWidth: parseInt(size/10),
						animate:false,
						size: size
					}).css('color', barColor);
				});}   
		  }
	});

}
jQuery(function($) {
	getUserskill();
	getSkill('1');
	$('[data-rel=tooltip]').tooltip();

});


function getSkill(obj){  
	$("#b1").empty();
	$.ajax({
		  type : "POST",
		  async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
		  url: 'useraby/getUserskillInfos.do?ABY_GROUP_ID='+obj,
		  dataType:'json',
		  cache: false,
		  success : function(data) {
		      //请求成功时执行该函数内容，result即为服务器返回的json对象
			  if("success" == data.msgcode){
				  var html='';
				  for(var i=0;i<data.list.length;i++){  
					  debugger;
					  var value = data.list[i].ABY_VALUE_O;
					  if(value <=1){
						  value = value+30;
					  }else if(1<value &&  value<=10){
						  value = value+20;
					  }else if(10<value &&  value<=15){
						  value = value+10;
					  }
					  html=html+'<div class="progress " data-rel="tooltip" data-placement="right" title="'+data.list[i].ABY_3RD+'    '+data.list[i].ABY_VALUE_O+'%">'; 
					  
					  if(i=='1'){
						  html=html+'<div class="progress-bar progress-bar-success" style="width:'+value+'%">';
					  }else if(i=='2'){
						  html=html+'<div class="progress-bar progress-bar-warning" style="width:'+value+'%">';
					  }else if(i=='3'){
						  html=html+'<div class="progress-bar progress-bar-danger" style="width:'+value+'%">';
					  }else{
						  html=html+'<div class="progress-bar" style="width:'+value+'%">';
					  }
					  
					  
					  html=html+'<span class="pull-left" id="B11">'+data.list[i].ABY_3RD+'</span>';
					  html=html+'<span class="pull-right" id="B12">'+data.list[i].ABY_VALUE_O+'%</span>';
					  html=html+'</div>';
					  html=html+'</div>';
		          }
		      }
			  $("#b1").append(html);
			 
		  }
	});

}