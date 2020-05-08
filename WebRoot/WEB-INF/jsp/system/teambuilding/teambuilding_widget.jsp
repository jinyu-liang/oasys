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
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">

							<form action="teambuilding/${msg }.do" name="Form" id="Form"
								method="post">
								<input type="hidden" name="TEAMBUILDING_ID" id="TEAMBUILDING_ID"
									value="${pd.TEAMBUILDING_ID}" />
								<div id="zhongxin" style="padding-top: 13px;">
									<!-- 饼状图开始 -->
									<div class="col-sm-5">
										<div class="widget-box">
											<div
												class="widget-header widget-header-flat widget-header-small">
												<h5 class="widget-title">
													<i class="ace-icon fa fa-signal"></i> ${pd.pd3.BULIDING_NAME}
												</h5>
											</div>

											<div class="widget-body">
											<c:if test="${not empty pd.pd2}">
												<div class="widget-main">
													<div id="piechart-placeholder"></div>
												</div>
											</c:if>
											<c:if test="${empty pd.pd2}">
												<div class="widget-main">
													暂无评价
												</div>
											</c:if>
											</div>
										</div>
									</div>

									<!-- 饼状图结束 -->
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script src="static/html_UI/assets/js/flot/jquery.flot.js"></script>
	<script src="static/html_UI/assets/js/flot/jquery.flot.pie.js"></script>
	<script src="static/html_UI/assets/js/flot/jquery.flot.resize.js"></script>
	<script src="static/html_UI/assets/js/ace/ace.widget-box.js"></script>
	<script src="static/html_UI/assets/js/ace/ace.widget-on-reload.js"></script>
	<script type="text/javascript">
		$(top.hangge());
	</script>
	<script type="text/javascript">
	var Id = $("#TEAMBUILDING_ID").val();
	$.ajax({
		url: "<%=basePath%>teambuilding/goDetail2.do?TEAMBUILDING_ID="+Id,
		type: "GET", //请求方式
		dataType: "json",
		success:function(data){
			var len = data.length;

				var placeholder = $('#piechart-placeholder').css({
					'width' : '90%',
					'min-height' : '150px'
				});
			var data1=[];
        	for(var i=0;i<data.length;i++){
        		var haha={label:data[i].SCORETYPE,data:data[i].COUNT};
        		data1.push(haha);
        	}
        	var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'150px'});
  		    var data =data1; 
  		    function drawPieChart(placeholder, data, position) {
				$.plot(placeholder, data, {
					series : {
						pie : {
							show : true,
							tilt : 0.8,
							highlight : {
								opacity : 0.25
							},
							stroke : {
								color : '#fff',
								width : 2
							},
							startAngle : 2
						}
					},
					legend : {
						show : true,
						position : position || "ne",
						labelBoxBorderColor : null,
						margin : [ -30, 15 ]
					},
					grid : {
						hoverable : true,
						clickable : true
					}
				})
			}
			drawPieChart(placeholder, data);

			/**
			we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
			so that's not needed actually.
			 */
			placeholder.data('chart', data);
			placeholder.data('draw', drawPieChart);
		},
		error: function(data) { 
		 } 
	});
	</script>
</body>
</html>