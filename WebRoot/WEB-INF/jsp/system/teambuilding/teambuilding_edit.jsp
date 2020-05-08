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
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">团建主题:</td>
											<td><input type="text" name="BULIDING_NAME"
												id="BULIDING_NAME" value="${pd.BULIDING_NAME}"
												maxlength="255" placeholder="这里输入团建主题" title="团建主题"
												style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">团建描述:</td>
											<td><textarea name="BUILDING_DESCRIE" id="BUILDING_DESCRIE" rows="10" cols="10"
												maxlength="255" placeholder="这里输入团建描述" title="团建描述"
												style="width: 98%;height:200px;">${pd.BUILDING_DESCRIE}</textarea>
												<div><font color="#808080">请不要多于200字否则无法发送</font></div>
												</td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">开始日期:</td>
											<td><input class="span10 date-picker" name="STARTTIME"
												id="STARTTIME" value="${pd.STARTTIME}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="开始日期" title="开始日期" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">结束日期:</td>
											<td><input class="span10 date-picker" name="ENDTIME"
												id="ENDTIME" value="${pd.ENDTIME}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="结束日期" title="结束日期" style="width: 98%;" /></td>
										</tr>
										<tr class="needdel">
											<td style="text-align: center;" colspan="10"><a
												class="btn btn-mini btn-success" onclick="addline();">添加评价类型1</a>
												<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
												<a class="btn btn-mini btn-danger"
												onclick="top.Dialog.close();">取消</a></td>
										</tr>
									</table>
								</div>

								<div id="zhongxin2" class="center" style="display: none">
									<br />
									<br />
									<br />
									<br />
									<br />
									<img src="static/images/jiazai.gif" /><br />
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
	<script type="text/javascript">
		$(top.hangge());
		//保存
		function save() {
			if ($("#BULIDING_NAME").val() == "") {
				$("#BULIDING_NAME").tips({
					side : 3,
					msg : '请输入团建主题',
					bg : '#AE81FF',
					time : 2
				});
				$("#BULIDING_NAME").focus();
				return false;
			}
			if ($("#BUILDING_DESCRIE").val() == "") {
				$("#BUILDING_DESCRIE").tips({
					side : 3,
					msg : '请输入团建描述',
					bg : '#AE81FF',
					time : 2
				});
				$("#BUILDING_DESCRIE").focus();
				return false;
			}
			if ($("#STARTTIME").val() == "") {
				$("#STARTTIME").tips({
					side : 3,
					msg : '请输入开始日期',
					bg : '#AE81FF',
					time : 2
				});
				$("#STARTTIME").focus();
				return false;
			}
			if ($("#ENDTIME").val() == "") {
				$("#ENDTIME").tips({
					side : 3,
					msg : '请输入结束日期',
					bg : '#AE81FF',
					time : 2
				});
				$("#ENDTIME").focus();
				return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		$(function() {
			//日期框
			$('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			});
		});
		var index = 1 //全局计数器计算添加的打分类型
		function addline() {
			var str = "";
			str += "<tr>"
					+ "<td style='width:100px;text-align: center;padding-top: 13px;'>"
					+ "评价类型" + index + ":" + "</td><td>"
					+ "<input type='text' name='SCORE" + index + "' id='SCORE"
					+ index + "'  maxlength='255' placeholder='这里输入评价类型"
					+ index + "' title='评价类型" + index
					+ "' style='width:98%;'/></td></tr>";
			str += "<tr class='needdel'>"
					+ "<td style='text-align: center;' colspan='10'><a class='btn btn-mini btn-success' onclick='addline();'>"
					+ "添加评价类型"
					+ (index + 1)
					+ "</a><a class='btn btn-mini btn-primary' onclick='save();' style='margin-left: 5px;'>"
					+ "保存"
					+ "</a>	<a class='btn btn-mini btn-danger'	onclick='top.Dialog.close();'>"
					+ "取消" + "</a></td>	</tr>"
			$('.needdel').remove();
			$('#table_report').append(str);
			str = "";
			index++;
		}
	</script>
</body>
</html>