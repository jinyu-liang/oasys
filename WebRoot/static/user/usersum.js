function getUserCount(){    
	 
	var dom = document.getElementById("main");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	    app.title = '环形图';
	    
	    option = {
	        tooltip: {
	            trigger: 'item',
	            formatter: "{a} <br/>{b}: {c} ({d}%)"
	        },
	        legend: {
                orient: 'vertical',
                x: 'left',
                data:['个人组','集团组','账务组','客服组','运维组']
            },
	        series: [
	            {
	                name:'人员',
	                type:'pie',
	                radius: ['50%', '70%'],
	                avoidLabelOverlap: false,
	                label: {
	                    normal: {
	                        show: false,
	                        position: 'center'
	                    },
	                    emphasis: {
	                        show: true,
	                        textStyle: {
	                            fontSize: '30',
	                            fontWeight: 'bold'
	                        }
	                    }
	                },
	                labelLine: {
	                    normal: {
	                        show: false
	                    }
	                },
	                data:[]
	            }
	        ]
	    };
	;
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};

	
	  myChart.showLoading();    //数据加载完之前先显示一段简单的loading动画
	  var names=[];  var datalist=[]; 
	  $.ajax({
		  type : "POST",
		  async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
		  url: 'user/listUsersCount.do',
		  dataType:'json',
		  cache: false,
		  success : function(data) {
			  
		      //请求成功时执行该函数内容，result即为服务器返回的json对象
			  if("success" == data.msgcode){
		          for(var i=0;i<data.list.length;i++){   
		        	  names.push(data.list[i].name);   
		          }
		         myChart.hideLoading();    //隐藏加载动画
		         myChart.setOption({        //加载数据图表
		        	
		             series: [
		            	 {
		            		 data:data.list
		                 }
		             ]
		         });
		             
		      }
		 },
		  error : function(errorMsg) {
		      //请求失败时执行该函数
			  alert("图表请求数据失败!");
		      myChart.hideLoading();
		      }
		 });
	};
jQuery(function($) {
	getUserCount();
});