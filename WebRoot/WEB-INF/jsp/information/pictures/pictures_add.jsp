<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>${pd.SYSNAME}</title>
<meta name="description" content="" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="static/ace/css/bootstrap.min.css" />
<link rel="stylesheet" href="static/ace/css/font-awesome.css" />
<!-- page specific plugin styles -->
<!-- text fonts -->
<link rel="stylesheet" href="static/ace/css/ace-fonts.css" />
<!-- ace styles -->
<link rel="stylesheet" href="static/ace/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />
<!--[if lte IE 9]>
	<link rel="stylesheet" href="static/ace/css/ace-part2.css" class="ace-main-stylesheet" />
<![endif]-->
<!--[if lte IE 9]>
  <link rel="stylesheet" href="static/ace/css/ace-ie.css" />
<![endif]-->
<!-- inline styles related to this page -->
<!-- ace settings handler -->
<script src="static/ace/js/ace-extra.js"></script>
<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
<!--[if lte IE 8]>
<script src="static/ace/js/html5shiv.js"></script>
<script src="static/ace/js/respond.js"></script>
<![endif]-->
<!-- webuploader上传插件css -->
<link rel="stylesheet" type="text/css"
	href="plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css"
	href="plugins/webuploader/style.css" />
</head>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<div class="main-content">
			<div class="main-content-inner">
				<div id="wrapper">
					<div id="container">
						<!--头部，相册选择和格式选择-->
						<div id="uploader">
							<div class="queueList">
								<div id="dndArea" class="placeholder">
									<div id="filePicker"></div>
									<p>或将照片拖到这里，单次最多可选300张</p>
								</div>
							</div>


							<div class="remark" style="display: none;">
								<table id="table_report"
									class="table table-striped table-bordered table-hover">
									<tr>
										<td style="width: 79px; text-align: right; padding-top: 13px;">标题:</td>
										<td><input type="text" name="TITLE" id="TITLE" value="" maxlength="32"
											placeholder="这里输入标题" title="标题" /></td>
										
										<td style="width:79px;text-align: right;padding-top: 13px;">类型:</td>
										<td>
											<select class="chosen-select form-control" name="MASTER_ID" id="MASTER_ID" data-placeholder="请选择类型" style="vertical-align:top;width: 220px;">
												<option value=""></option>
												<option value="0">大众</option>
												<option value="1">展览</option>
										  	</select>
										</td>
									</tr>
									<tr>
										<td style="width: 79px; text-align: right; padding-top: 13px;">备注:</td>
										<td colspan="3"><input type="text" name="REMARK" id="REMARK"
											value="" maxlength="200" placeholder="这里输入备注" style="width: 600px;"
											title="备注" /></td>
									</tr>
								</table>
							</div>

							<div class="statusBar" style="display: none;">
								<div class="progress">
									<span class="text">0%</span> <span class="percentage"></span>
								</div>
								<div class="info"></div>
								<div class="btns">
									<div id="filePicker2"></div>
									<div class="uploadBtn">开始上传</div>
								</div>

							</div>
						

<div id="zhongxin2" class="center" style="display:none"><br/><img src="static/images/jzx.gif" id='msg' /><br/><h4 class="lighter block green" id='msg'>正在发送...</h4><strong id="second_shows" class="red">3秒</strong>后关闭</div>
							
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- webuploader上传插件js -->
	<script type="text/javascript" src="plugins/webuploader/webuploader.js"></script>
	<script type="text/javascript" src="plugins/webuploader/upload.js"></script>
	<script type="text/javascript">
		$(top.hangge());
	</script>
</body>
</html>
