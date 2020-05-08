<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />

<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link rel="stylesheet" href="static/ace/css/bootstrap-datetimepicker.css" />
</head>

<body class="no-skin" onload="show()">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">

							<form action="trainplan/${msg }.do" name="Form" id="Form"
								method="post">
								<input type="hidden" name="LETURE" id="LETURE" value="${pd.LETURE}" />
								<div id="zhongxin" style="padding-top: 13px;">
									

									<div class="widget-box" >
											<div class="widget-header widget-header-flat widget-header-small">
												<h5 class="widget-title">
													<i class="ace-icon fa fa-signal"></i>
													<i id="cplanname">导师：${pd.LETURE}</i>
												</h5>
											</div>
											<div class="widget-body">
												<div class="widget-main">
													<!-- #section:plugins/charts.flotchart -->
													<div id="piechart-placeholder"></div>

												</div><!-- /.widget-main -->
											</div><!-- /.widget-body -->
									</div><!-- /.widget-box -->


								</div>

								<div id="zhongxin2" class="center" style="display: none">
									<br /> <br /> <br /> <br /> <br /> <img
										src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
								</div>

							</form>

							<div id="zhongxin2" class="center" style="display: none">
								<img src="static/images/jzx.gif" style="width: 50px;" /><br />
								<h4 class="lighter block green"></h4>
							</div>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->

	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<script src="static/ace/js/date-time/moment.js"></script>
	<script src="static/ace/js/date-time/bootstrap-datetimepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 饼图 -->
		<script src="static/html_UI/assets/js/flot/jquery.flot.js"></script>
		<script src="static/html_UI/assets/js/flot/jquery.flot.pie.js"></script>
		<script src="static/html_UI/assets/js/flot/jquery.flot.resize.js"></script>
	<script type="text/javascript">
	
	function show(){
		var Id=$("#LETURE").val();
		 $.ajax({
	        url: '<%=basePath%>trainplan/piechart4.do?LETURE='+Id,
	        //dataType: "JSONP", //返回格式为json
	        async: true, //请求是否异步，默认为异步，这也是ajax重要特性
	        type: "POST", //请求方式
	        success: function (data){
	        	
	        	if(data.pd2!=""){
	        	$("#cplanname").html(data.pd2[0].PLAN_NAME);
	        	var data1=[];
	        	for(var i=0;i<data.pd2.length;i++){
	        		var haha={label:data.pd2[i].SCORE_TYPE,data:data.pd2[i].COUNT};
	        		data1.push(haha);
	        	}
	        	var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'150px'});
	  		  var data =data1; 
	  		  
	  		function drawPieChart(placeholder, data, position) {
			 	  $.plot(placeholder, data, {
					series: {
						pie: {
							show: true,
							tilt:0.8,
							highlight: {
								opacity: 0.25
							},
							stroke: {
								color: '#fff',
								width: 2
							},
							startAngle: 2
						}
					},
					legend: {
						show: true,
						position: position || "ne", 
						labelBoxBorderColor: null,
						margin:[-30,15]
					}
					,
					grid: {
						hoverable: true,
						clickable: true
					}
				 })
			 }
			 drawPieChart(placeholder, data);
	        }else{
	        	$("#cplanname").html("暂无评价");
	        	//alert("该培训暂无评价");
	        }
	        }, error: function (msg) {
	        }
	    }); 
	  <%--   var url="<%=basePath%>trainplan/piechart2.do?TRAINPLAN_ID="+Id;
	    $.get(url,function(data){
			/* nextPage(${page.currentPage}); */
			console.log(data);
		}); --%>
		
	}
	
		$(top.hangge());
		

		  
	</script>
</body>
</html>