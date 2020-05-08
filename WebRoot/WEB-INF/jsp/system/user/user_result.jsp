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
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<%@ include file="../index/top.jsp"%>
</head>
<body class="no-skin">
 
 	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
								<div id="">
								<table style="width:95%;" >
									<tr  style="text-align: center;padding-top: 10px;">
										<td style="padding-top: 20px;"><div id="zhongxin"></div></div></td>
									</tr>
									
								</table>
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
 
	<script type="text/javascript">
	
		var msg = "${msg}";
		var msginfo = "${msginfo}";
		$("#zhongxin").html(msginfo);
		setTimeout(function(){top.Dialog.close();},10000);
	</script>
</body>
</html>