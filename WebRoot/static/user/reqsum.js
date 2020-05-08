


function getRemCount(){    
	
	var dom = document.getElementById("container");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	var posList = [
	    'left', 'right', 'top', 'bottom',
	    'inside',
	    'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
	    'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
	];

	app.configParameters = {
	    rotate: {
	        min: -90,
	        max: 90
	    },
	    align: {
	        options: {
	            left: 'left',
	            center: 'center',
	            right: 'right'
	        }
	    },
	    verticalAlign: {
	        options: {
	            top: 'top',
	            middle: 'middle',
	            bottom: 'bottom'
	        }
	    },
	    position: {
	        options: echarts.util.reduce(posList, function (map, pos) {
	            map[pos] = pos;
	            return map;
	        }, {})
	    },
	    distance: {
	        min: 0,
	        max: 100
	    }
	};

	app.config = {
	    rotate: 90,
	    align: 'left',
	    verticalAlign: 'middle',
	    position: 'insideBottom',
	    distance: 15,
	    onChange: function () {
	        var labelOption = {
	            normal: {
	                rotate: app.config.rotate,
	                align: app.config.align,
	                verticalAlign: app.config.verticalAlign,
	                position: app.config.position,
	                distance: app.config.distance
	            }
	        };
	        myChart.setOption({
	            series: [{
	                label: labelOption
	            }, {
	                label: labelOption
	            }, {
	                label: labelOption
	            }, {
	                label: labelOption
	            }]
	        });
	    }
	};


	var labelOption = {
	    normal: {
	        show: true,
	        position: app.config.position,
	        distance: app.config.distance,
	        align: app.config.align,
	        verticalAlign: app.config.verticalAlign,
	        rotate: app.config.rotate,
	        formatter: '{c}  {name|{a}}',
	        fontSize: 16,
	        rich: {
	            name: {
	                textBorderColor: '#fff'
	            }
	        }
	    }
	};

	option = {
	    color: ['#003366', '#006699', '#4cabce', '#9585bf','#e5323e'],
	    tooltip: {
	        trigger: 'axis',
	        axisPointer: {
	            type: 'shadow'
	        }
	    },
	    legend: {
	        data: ['需求安排', '需求设计', '需求开发', '需求测试', '需求待上线']
	    },
	    toolbox: {
	        show: true,
	        orient: 'vertical',
	        left: 'right',
	        top: 'center',
	        feature: {
	            mark: {show: true},
	            dataView: {show: true, readOnly: false},
	            magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
	            restore: {show: true},
	            saveAsImage: {show: true}
	        }
	    },
	    calculable: true,
	    xAxis: [
	        {
	            type: 'category',
	            axisTick: {show: false},
	            data: ['需求单', '缺陷单']
	        }
	    ],
	    yAxis: [
	        {
	            type: 'value'
	        }
	    ],
	    series: [
	        {
	            name: '需求安排',
	            type: 'bar',
	            barGap: 0,
	            label: labelOption,
	            data: []
	        },
	        {
	            name: '需求设计',
	            type: 'bar',
	            label: labelOption,
	            data: []
	        },
	        {
	            name: '需求开发',
	            type: 'bar',
	            label: labelOption,
	            data: []
	        },
	        {
	            name: '需求测试',
	            type: 'bar',
	            label: labelOption,
	            data: []
	        },
	        {
	            name: '需求待上线',
	            type: 'bar',
	            label: labelOption,
	            data: []
	        }
	    ]
	};;
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	
  myChart.showLoading();    //数据加载完之前先显示一段简单的loading动画
  var names1=[];  var names2=[];  var names3=[];  var names4=[]; var names5=[];
  $.ajax({
	  type : "POST",
	  async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
	  url: 'reqm/listReqm.do',
	  dataType:'json',
	  cache: false,
	  success : function(data) {
	      //请求成功时执行该函数内容，result即为服务器返回的json对象
		  if("success" == data.msgcode){
	          for(var i=0;i<data.list.length;i++){   
	        	  if(data.list[i].REQ_NAME == "R"){
	        		  if(data.list[i].REQ_STATE == "02"){
	            		  names1.push(data.list[i].REQ_SUM);   
	            	  }else if(data.list[i].REQ_STATE == "04"){
	            		  names2.push(data.list[i].REQ_SUM);   
	            	  }else if(data.list[i].REQ_STATE == "07"){
	            		  names3.push(data.list[i].REQ_SUM);   
	            	  }else if(data.list[i].REQ_STATE == "08"){
	            		  names4.push(data.list[i].REQ_SUM);   
	            	  }else{
	            		  names5.push(data.list[i].REQ_SUM);   
	            	  }
	        	  }
	          }
	          for(var i=0;i<data.list.length;i++){   
	        	  if(data.list[i].REQ_NAME == "W"){
	        		  if(data.list[i].REQ_STATE == "02"){
	            		  names1.push(data.list[i].REQ_SUM);   
	            	  }else if(data.list[i].REQ_STATE == "04"){
	            		  names2.push(data.list[i].REQ_SUM);   
	            	  }else if(data.list[i].REQ_STATE == "07"){
	            		  names3.push(data.list[i].REQ_SUM);   
	            	  }else if(data.list[i].REQ_STATE == "08"){
	            		  names4.push(data.list[i].REQ_SUM);   
	            	  }else{
	            		  names5.push(data.list[i].REQ_SUM);   
	            	  }
	        	  }
	          }
	         myChart.hideLoading();    //隐藏加载动画
	         myChart.setOption({        //加载数据图表
	             series: [
	            	 {
	                     name: '需求安排',
	                     type: 'bar',
	                     barGap: 0,
	                     label: labelOption,
	                     data: names1
	                 },
	                 {
	                     name: '需求设计',
	                     type: 'bar',
	                     label: labelOption,
	                     data: names2
	                 },
	                 {
	                     name: '需求开发',
	                     type: 'bar',
	                     label: labelOption,
	                     data: names3
	                 },
	                 {
	                     name: '需求测试',
	                     type: 'bar',
	                     label: labelOption,
	                     data: names4
	                 },
	                 {
	                     name: '需求待上线',
	                     type: 'bar',
	                     label: labelOption,
	                     data: names5
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
	getRemCount();
});