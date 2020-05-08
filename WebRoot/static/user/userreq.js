function getUserReq(){   
	$.ajax({
		  type : "POST",
		  async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
		  url: 'reqm/listOnlyReqm.do',
		  dataType:'json',
		  cache: false,
		  success : function(data) {
		      //请求成功时执行该函数内容，result即为服务器返回的json对象
			  if("success" == data.msgcode){
				  $("#reqm").replaceWith(data.num);
		      }    
		  },
		  error : function(errorMsg) {
			  
		  }
	});
	
	$.ajax({
		
		  type : "POST",
		  async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
		  url: 'reqm/listOnlyReqplus.do',
		  dataType:'json',
		  cache: false,
		  success : function(data) {
		      //请求成功时执行该函数内容，result即为服务器返回的json对象
			  if("success" == data.msgcode){
				  $("#reqplus").replaceWith(data.num);
		      }    
		  },
		  error : function(errorMsg) {
			  
		  }
	});
	
	$.ajax({
		  type : "POST",
		  async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
		  url: 'reqm/listReqplusSum.do',
		  dataType:'json',
		  cache: false,
		  success : function(data) {
		      //请求成功时执行该函数内容，result即为服务器返回的json对象
			  if("success" == data.msgcode){
				  $("#reqplussum").replaceWith(data.num);
		      }    
		  },
		  error : function(errorMsg) {
			  
		  }
	});
	
	$.ajax({
		  type : "POST",
		  async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
		  url: 'userloginlog/userloginlog.do',
		  dataType:'json',
		  cache: false,
		  success : function(data) {
		      //请求成功时执行该函数内容，result即为服务器返回的json对象
			  if("success" == data.msgcode){
				  $("#loginfo").replaceWith(data.loginfo);
		      }    
		  },
		  error : function(errorMsg) {
			  
		  }
	});
}
jQuery(function($) {
	getUserReq();
});