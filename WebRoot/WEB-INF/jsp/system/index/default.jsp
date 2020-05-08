<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<link rel="stylesheet" href="static/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
<link rel="stylesheet" href="static/ace/css/jquery-ui.custom.css" />
<link rel="stylesheet" href="static/ace/css/font-awesome.css" />
<link rel="stylesheet" href="static/ace/css/ace-fonts.css" />
<script type="text/javascript" src="static/js/myjs/head.js"></script>

<!-- 百度echarts -->
<script type="text/javascript" src="plugins/echarts/echarts.min.js"></script>
<script type="text/javascript" src="plugins/echarts/echarts-gl.min.js"></script>
<script type="text/javascript" src="plugins/echarts/ecStat.min.js"></script>
<script type="text/javascript" src="plugins/echarts/dataTool.min.js"></script>
<script type="text/javascript" src="plugins/echarts/china.js"></script>
<script type="text/javascript" src="plugins/echarts/world.js"></script>
<script type="text/javascript" src="plugins/echarts/bmap.min.js"></script>
<script src="static/ace/js/jquery.js"></script>
<script src="static/ace/js/jquery-ui.custom.js"></script>
<script src="static/ace/js/jquery.ui.touch-punch.js"></script>
<script src="static/ace/js/bootstrap.js"></script>
<script src="static/ace/js/jquery.easypiechart.js"></script>
		
<script src="static/ace/js/ace/ace.js"></script>
<script src="static/ace/js/ace/ace.ajax-content.js"></script>
<script src="static/ace/js/ace/ace.touch-drag.js"></script>
<script src="static/ace/js/ace/ace.sidebar.js"></script>
<script src="static/ace/js/ace/ace.sidebar-scroll-1.js"></script>
<script src="static/ace/js/ace/ace.submenu-hover.js"></script>
<script src="static/ace/js/ace/ace.widget-box.js"></script>
<script src="static/ace/js/ace/ace.settings.js"></script>
<script src="static/ace/js/ace/ace.settings-rtl.js"></script>
<script src="static/ace/js/ace/ace.settings-skin.js"></script>
<script src="static/ace/js/ace/ace.widget-on-reload.js"></script>
<script src="static/ace/js/ace/ace.searchbox-autocomplete.js"></script>


</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					  <div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">

							<div class="alert alert-block alert-success">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								<i class="ace-icon fa fa-check green"><strong class="green">欢迎使用  OA SYSTEM 系统</strong></i>
								
								<i class="ace-icon fa  blue">         &nbsp; &nbsp;<span id="loginfo" ></span></i>
							</div>
							
							
							<!-- 个人信息 -->
							<%@ include file="userinfo.jsp"%>

							<!-- 个人绩效 -->
							<%@ include file="userskill.jsp"%>
							
							
							<div class="col-xs-12 col-sm-6 widget-container-col">
								<!-- #section:custom/widget-box -->
								<div class="widget-box">
									<div class="widget-header">
										<h4 class="widget-title">我的需求情报</h4>
	
										<!-- #section:custom/widget-box.toolbar -->
										<div class="widget-toolbar">
	
	
											<a  data-action="fullscreen" class="orange2">
												<i class="ace-icon fa fa-expand"></i>
											</a>
	
											<a  data-action="reload" onclick="getReqSum6()">
												<i class="ace-icon fa fa-refresh"></i>
											</a>
	
											<a  data-action="collapse">
												<i class="ace-icon fa fa-chevron-up"></i>
											</a>
	
											<a  data-action="close">
												<i class="ace-icon fa fa-times"></i>
											</a>
										</div>
	
										<!-- /section:custom/widget-box.toolbar -->
									</div>
	
									<div class="widget-body">
										<div class="widget-main center">
											<div id="main" style="height:300px;"></div>
										</div>
									</div>
								</div>
	
								<!-- /section:custom/widget-box -->
							</div>
							
							
							<div class="col-xs-12 col-sm-6 widget-container-col">
								<div class="widget-box">
									<!-- #section:custom/widget-box.header.options -->
									<div class="widget-header">
										<h4 class="widget-title">部门需求情报</h4>

										<div class="widget-toolbar">
											<a  data-action="fullscreen">
												<i class="ace-icon fa fa-expand"></i>
											</a>

											<a href="#" data-action="reload">
												<i class="ace-icon fa fa-refresh" onclick="getRemCount()"></i>
											</a>

											<a  data-action="collapse">
												<i class="ace-icon fa fa-chevron-up"></i>
											</a>

											<a  data-action="close">
												<i class="ace-icon fa fa-times"></i>
											</a>
										</div>
									</div>

									<!-- /section:custom/widget-box.header.options -->
									<div class="widget-body">
										<div class="widget-main center">
											<div id="container" style="	height:300px;"></div>
										</div>
									</div>
								</div>
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


		<!-- 返回顶部 -->
		<a  id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());
		jQuery(function($) {
			
			// widget boxes
			// widget box drag & drop example
		    $('.widget-container-col').sortable({
		        connectWith: '.widget-container-col',
				items:'> .widget-box',
				handle: ace.vars['touch'] ? '.widget-header' : false,
				cancel: '.fullscreen',
				opacity:0.8,
				revert:true,
				forceHelperSize:true,
				placeholder: 'widget-placeholder',
				forcePlaceholderSize:true,
				tolerance:'pointer',
				start: function(event, ui) {
					//when an element is moved, it's parent becomes empty with almost zero height.
					//we set a min-height for it to be large enough so that later we can easily drop elements back onto it
					ui.item.parent().css({'min-height':ui.item.height()})
					//ui.sender.css({'min-height':ui.item.height() , 'background-color' : '#F5F5F5'})
				},
				update: function(event, ui) {
					ui.item.parent({'min-height':''})
					//p.style.removeProperty('background-color');
				}
		    });
		
		});
	</script>
	
	
	

	


<!-- <script type="text/javascript" src="static/user/usersum.js"></script> -->
<script type="text/javascript" src="static/user/reqsum.js"></script>
<script type="text/javascript" src="static/user/reqsum6.js"></script>


</body>
</html>