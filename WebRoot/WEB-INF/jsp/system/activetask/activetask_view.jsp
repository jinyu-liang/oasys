<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
					
					<form action="activetask/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ACTIVETASK_ID" id="ACTIVETASK_ID" value="${pd.ACTIVETASK_ID}"/>
						<input type="hidden" name="STAFF_ID" id="STAFF_ID" value="${pd.STAFF_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">任务名称:</td>
								<td><input type="text" name="TASK_NAME" id="TASK_NAME" value="${pd.TASK_NAME}" maxlength="255" title="任务名称" style="width:98%;" autocomplete="off" disabled="disabled"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">需求编号:</td>
								<td><input type="text" name="TASK_CODE" id="TASK_CODE" value="${pd.TASK_CODE}" maxlength="255" title="需求编号" style="width:98%;" autocomplete="off" disabled="disabled"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">任务类型:</td>
								<td>
								<select class="chosen-select form-control" name="TASK_TYPE" id="TASK_TYPE" data-placeholder="请选择任务类型" style="vertical-align:top;width: 300px;" disabled="disabled">
								    <option value="" <c:if test="${pd.TASK_TYPE eq ''}">selected</c:if>>请选择任务类型</option>
									<option value="绩效工时(不包括值班,节假日加班)" <c:if test="${pd.TASK_TYPE eq '绩效工时(不包括值班,节假日加班)'}">selected</c:if>>绩效工时(不包括值班,节假日加班)</option>  
									<option value="绩效工时(维护工时)" <c:if test="${pd.TASK_TYPE eq '绩效工时(维护工时)'}">selected</c:if>>绩效工时(维护工时)</option> 
									<option value="绩效工时(运维组_转发的工单池)" <c:if test="${pd.TASK_TYPE eq '绩效工时(运维组_转发的工单池)'}">selected</c:if>>绩效工时(运维组_转发的工单池)</option>
									<option value="绩效工时(运维组_信息卡)" <c:if test="${pd.TASK_TYPE eq '绩效工时(运维组_信息卡)'}">selected</c:if>>绩效工时(运维组_信息卡)</option> 
									<option value="绩效工时(运维组_其他)" <c:if test="${pd.TASK_TYPE eq '绩效工时(运维组_其他)'}">selected</c:if>>绩效工时(运维组_其他)</option> 
									<option value="项目工时" <c:if test="${pd.TASK_TYPE eq '项目工时'}">selected</c:if>>项目工时</option> 
								</select> 
								<%-- <input type="text" name="TASK_TYPE" id="TASK_TYPE" value="${pd.TASK_TYPE}" maxlength="255" placeholder="这里输入任务类型" title="任务类型" style="width:98%;" autocomplete="off"/> --%>
								</td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">实际开始时间:</td>
								<td><input class="span10 date-picker" name="START_DATE" id="START_DATE" value="${pd.START_DATE}" type="text" readonly="readonly" placeholder="实际开始时间" title="实际开始时间" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">实际结束时间:</td>
								<td><input class="span10 date-picker" name="END_DATE" id="END_DATE" value="${pd.END_DATE}" type="text" readonly="readonly" placeholder="实际结束时间" title="实际结束时间" style="width:98%;" disabled="disabled"/></td>
							</tr>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">实际工作量:</td>
								<td><input type="text" name="WORK_LOAD" id="WORK_LOAD" value="${pd.WORK_LOAD}" maxlength="255" title="实际工作量" style="width:98%;" autocomplete="off" disabled="disabled"/></td>
							</tr>
<%-- 						
                            <tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">移动负责人:</td>
								<td><input type="text" name="IT_NAME" id="IT_NAME" value="${pd.IT_NAME}" maxlength="255" placeholder="这里输入移动负责人" title="移动负责人" style="width:98%;" autocomplete="off"/></td>
							</tr> 
--%>
							<tr>
								<td style="width:125px;text-align: right;padding-top: 13px;">具体工作内容:</td>
								<td><textarea style="width: 98%; height: 90px;"
								rows="10" cols="10" name="REMARK" id="REMARK"
								title="具体工作内容" maxlength="255" autocomplete="off" disabled="disabled">${pd.REMARK}</textarea>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">关闭</a>
								</td>
							</tr>
						</table>
						</div>
						
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
						
					</form>
	
					<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>
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
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#TASK_NAME").val()==""){
				$("#TASK_NAME").tips({
					side:3,
		            msg:'请输入任务名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TASK_NAME").focus();
			return false;
			}
			if($("#TASK_TYPE").val()==""){
				$("#TASK_TYPE").tips({
					side:3,
		            msg:'请选择任务类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TASK_TYPE").focus();
			return false;
			}
			if($("#START_DATE").val()==""){
				$("#START_DATE").tips({
					side:3,
		            msg:'请输入实际开始时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#START_DATE").focus();
			return false;
			}
			if($("#END_DATE").val()==""){
				$("#END_DATE").tips({
					side:3,
		            msg:'请输入实际结束时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#END_DATE").focus();
			return false;
			}
			if($("#WORK_LOAD").val()==""){
				$("#WORK_LOAD").tips({
					side:3,
		            msg:'请输入实际工作量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WORK_LOAD").focus();
			return false;
			}

			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//时间框
			$('.date-picker').datetimepicker({
				format: 'YYYY-MM-DD HH:mm', 
				locale: moment.locale('zh-cn')
			});
		});
		</script>
</body>
</html>