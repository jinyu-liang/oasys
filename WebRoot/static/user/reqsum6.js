function getReqSum6(){    
	 
	var dom = document.getElementById("main");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;	    
	    option = {
	    		 title: {
	    		        text: ''
	    		    },
	    		    tooltip: {
	    		        trigger: 'axis',
	    		        axisPointer: {
	    		            type: 'cross',
	    		            label: {
	    		                backgroundColor: '#6a7985'
	    		            }
	    		        }
	    		    },
	    		    toolbox: {
	    		        feature: {
	    		            saveAsImage: {}
	    		        }
	    		    },
	    		    grid: {
	    		        left: '3%',
	    		        right: '4%',
	    		        bottom: '3%',
	    		        containLabel: true
	    		    },
	    		    xAxis: [
	    		        {
	    		            type: 'category',
	    		            boundaryGap: false,
	    		            data: []
	    		        }
	    		    ],
	    		    yAxis: [
	    		        {
	    		            type: 'value'
	    		        }
	    		    ],
	    		    series: [
	    		        {
	    		            name: '月工作量',
	    		            type: 'line',
	    		            stack: '总量',
	    		            areaStyle: {},
	    		            data: []
	    		        },
	    		        
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
		  url: 'reqm/listReqplusSum6.do',
		  dataType:'json',
		  cache: false,
		  success : function(data) {
			  
		      //请求成功时执行该函数内容，result即为服务器返回的json对象
			  if("success" == data.msgcode){
		          for(var i=0;i<data.list.length;i++){   
		        	  names.push(data.list[i].DATAS);
		        	  datalist.push(data.list[i].WORKLOAD); 
		          }
		         myChart.hideLoading();    //隐藏加载动画
		         myChart.setOption({        //加载数据图表
		        	
		        	 	xAxis: [
		    		        {
		    		            type: 'category',
		    		            boundaryGap: false,
		    		            data: names
		    		        }
		    		    ],
		    		    series: [
		    		        {
		    		            name: '月工作量',
		    		            type: 'line',
		    		            stack: '总量',
		    		            areaStyle: {},
		    		            data: datalist
		    		        },
		    		        
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
	getReqSum6();
});