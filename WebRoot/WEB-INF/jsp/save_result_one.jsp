<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>保存结果</title>
<base href="<%=basePath%>">
<script type="text/javascript" src="static/js/myjs/head.js"></script>
<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<%@ include file="system/index/top.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	$(top.hangge());
	</script>
</head>
<body>
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">
							<div class="error-container">
							<div class="well">
										<h1 class="grey lighter smaller">
											<span class="blue bigger-125">
											<c:if test="${msgcode == 'error' }">
												<i class="ace-icon fa fa-times "></i>
											</c:if>	
											
											<c:if test="${msgcode == 'success' }">
												<i class="ace-icon fa fa-check "></i>
											</c:if>	
											
											</span>
											${msg}
										</h1>

										<hr />
										<div class="space"></div>

											<div class="center">
												<a class="btn btn-grey" onclick="closeMenu('${menuid}')">
													<i class="ace-icon fa fa-arrow-left"></i>
													关闭
												</a>
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


	</div>

</body>
</html>