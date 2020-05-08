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
<body class="no-skin">
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
								<input type="hidden" name="TRAINPLAN_ID" id="TRAINPLAN_ID"
									value="${pd.TRAINPLAN_ID}" />
									<input type="hidden" name="PLANTRAINTIME"
												id="PLANTRAINTIME" value="${pd.PLANTRAINTIME}"
												maxlength="255" placeholder="这里输入计划培训日期" title="计划培训时间"
												style="width: 98%;" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<tr>
											<td
												style="width: 100px; text-align: center; padding-top: 13px;">培训名:</td>
											<td><input type="text" name="PLAN_NAME" id="PLAN_NAME"
												value="${pd.PLAN_NAME}" maxlength="255"
												placeholder="这里输入培训名" title="培训名" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 100px; text-align: center; padding-top: 13px;">培训描述:</td>
											<!-- <td><input type="text" name="PLAN_DESCRIE" id="PLAN_DESCRIE" value="${pd.PLAN_DESCRIE}" maxlength="255" placeholder="这里输入培训描述" title="培训描述" style="width:98%;"/></td> -->
											<td><textarea rows="5" cols="50" name="PLAN_DESCRIE"
													id="PLAN_DESCRIE" placeholder="这里输入培训描述"
													style="color: gray; resize: none; width: 98%">${pd.PLAN_DESCRIE}</textarea></td>
										</tr>
										<tr>
											<td
												style="width: 100px; text-align: center; padding-top: 13px;">开始时间:</td>
											<td>
											
											<%-- <input class="span10 date-picker" name="STARTTIME"
												id="STARTTIME" value="${pd.STARTTIME}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="开始时间" title="开始时间" style="width: 98%;" /> --%>
												
												<input class="span10 date-picker" name="STARTTIME"
												id="STARTTIME" value="${pd.STARTTIME}" type="text"
												readonly="readonly"
												placeholder="开始时间" title="开始时间" style="width: 98%;" />
												</td>
										</tr>
										<tr>
											<td
												style="width: 100px; text-align: center; padding-top: 13px;">结束时间:</td>
											<td>
											<%-- 
											<input class="span10 date-picker" name="ENDTIME"
												id="ENDTIME" value="${pd.ENDTIME}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="结束时间" title="结束时间" style="width: 98%;" /> --%>
												<input class="span10 date-picker" name="ENDTIME"
												id="ENDTIME" value="${pd.ENDTIME}" type="text"
												readonly="readonly"
												placeholder="结束时间" title="结束时间" style="width: 98%;" />
												</td>
										</tr>
	<!--
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">评价:</td>
											<td><input type="text" name="REMARK" id="REMARK"
												value="${pd.REMARK}" maxlength="255" placeholder="这里输入评价"
												title="评价" style="width: 98%;" /></td>
										</tr>
	-->
										<tr>
											<td
												style="width: 100px; text-align: center; padding-top: 13px;">讲师:</td>
											<td><input type="text" name="LETURE" id="LETURE"
												value="${pd.LETURE}" maxlength="255" placeholder="这里输入讲师"
												title="讲师" style="width: 98%;" /></td>
										</tr>
										<%-- <tr type="hidden">
											<td
												style="width: 100px; text-align: center; padding-top: 13px;">计划培训日期:</td>
											<td><input type="text" name="PLANTRAINTIME"
												id="PLANTRAINTIME" value="${pd.PLANTRAINTIME}"
												maxlength="255" placeholder="这里输入计划培训日期" title="计划培训时间"
												style="width: 98%;" /></td>
										</tr> --%>
										<tr>
											<td
												style="width: 100px; text-align: center; padding-top: 13px;">培训地点:</td>
											<td><input type="text" name="PLANPLACE" id="PLANPLACE"
												value="${pd.PLANPLACE}" maxlength="255"
												placeholder="这里输入培训地点" title="培训地点" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 100px; text-align: center; padding-top: 13px;">实际培训时长:</td>
											<td><input type="text" name="REALTRAINTIME"
												id="REALTRAINTIME" value="${pd.REALTRAINTIME}"
												maxlength="255" placeholder="这里输入实际培训时长" title="实际培训时长"
												style="width: 98%;" />分钟</td>
										</tr>
										<tr>
											<td
												style="width: 100px; text-align: center; padding-top: 13px;">培训奖励:</td>
											<td><input type="text" name="REWARD" id="REWARD"
												value="${pd.REWARD}" maxlength="255" placeholder="这里输入培训奖励"
												title="培训奖励" style="width: 98%;" /></td>
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
	
		<script src="static/ace/js/fuelux/fuelux.spinner.js"></script>
		<script src="static/ace/js/ace/ace.js"></script>
		<script src="static/ace/js/ace/elements.spinner.js"></script>
		
	<script type="text/javascript">
		$(top.hangge());
		//保存
		function save() {
			if ($("#PLAN_NAME").val() == "") {
				$("#PLAN_NAME").tips({
					side : 3,
					msg : '请输入培训名',
					bg : '#AE81FF',
					time : 2
				});
				$("#PLAN_NAME").focus();
				return false;
			}
			if ($("#PLAN_DESCRIE").val() == "") {
				$("#PLAN_DESCRIE").tips({
					side : 3,
					msg : '请输入培训描述',
					bg : '#AE81FF',
					time : 2
				});
				$("#PLAN_DESCRIE").focus();
				return false;
			}
			if ($("#STARTTIME").val() == "") {
				$("#STARTTIME").tips({
					side : 3,
					msg : '请输入开始时间',
					bg : '#AE81FF',
					time : 2
				});
				$("#STARTTIME").focus();
				return false;
			}
			if ($("#ENDTIME").val() == "") {
				$("#ENDTIME").tips({
					side : 3,
					msg : '请输入结束时间',
					bg : '#AE81FF',
					time : 2
				});
				$("#ENDTIME").focus();
				return false;
			}
			if ($("#REMARK").val() == "") {
				$("#REMARK").tips({
					side : 3,
					msg : '请输入评价',
					bg : '#AE81FF',
					time : 2
				});
				$("#REMARK").focus();
				return false;
			}
			if ($("#LETURE").val() == "") {
				$("#LETURE").tips({
					side : 3,
					msg : '请输入讲师',
					bg : '#AE81FF',
					time : 2
				});
				$("#LETURE").focus();
				return false;
			}
			if ($("#PLANTRAINTIME").val() == "") {
				$("#PLANTRAINTIME").tips({
					side : 3,
					msg : '请输入计划培训日期',
					bg : '#AE81FF',
					time : 2
				});
				$("#PLANTRAINTIME").focus();
				return false;
			}
			if ($("#PLANPLACE").val() == "") {
				$("#PLANPLACE").tips({
					side : 3,
					msg : '请输入培训地点',
					bg : '#AE81FF',
					time : 2
				});
				$("#PLANPLACE").focus();
				return false;
			}
			if ($("#REALTRAINTIME").val() == "") {
				$("#REALTRAINTIME").tips({
					side : 3,
					msg : '请输入实际培训时长',
					bg : '#AE81FF',
					time : 2
				});
				$("#REALTRAINTIME").focus();
				return false;
			}
			if ($("#REWARD").val() == "") {
				$("#REWARD").tips({
					side : 3,
					msg : '请输入培训奖励',
					bg : '#AE81FF',
					time : 2
				});
				$("#REWARD").focus();
				return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		/* $(function() {
			//日期框
			$('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			});
		}); */
		
		$(function() {
			//时间框
			$('.date-picker').datetimepicker({
				format: 'YYYY-MM-DD HH:mm', 
				locale: moment.locale('zh-cn')
			});
		});
		var index = 1 //全局计数器计算添加的评价类型
		function addline() {
			var str = "";
			str += "<tr>"
					+ "<td style='width:100px;text-align: center;padding-top: 13px;'>"
					+ "评价类型"
					+ index
					+ ":"
					+ "</td><td>"
					+ "<input type='text' name='SCORE"+index+"' id='SCORE"+index+"'  maxlength='255' placeholder='这里输入评价类型"
					+ index + "' title='评价类型" + index
					+ "' style='width:98%;'/></td></tr>";
			str += "<tr class='needdel'>"
					+ "<td style='text-align: center;' colspan='10'><a class='btn btn-mini btn-success' onclick='addline();'>"
					+ "添加评价类型"
					+ (index + 1)
					+ "</a><a class='btn btn-mini btn-primary' onclick='save();'>"
					+ "保存"
					+ "</a>	<a class='btn btn-mini btn-danger'	onclick='top.Dialog.close();'>"
					+ "取消" + "</a></td>	</tr>"
			$('.needdel').remove();
			$('#table_report').append(str);
			str = "";
			index++;
		}
		$('#REALTRAINTIME').ace_spinner({value:0,min:-100,max:1000,step:10, on_sides: true, icon_up:'ace-icon fa fa-plus bigger-110', icon_down:'ace-icon fa fa-minus bigger-110', btn_up_class:'btn-success' , btn_down_class:'btn-danger'});

	</script>
</body>
</html>