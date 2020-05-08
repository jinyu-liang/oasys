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
					
					<form action="sysparam/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="P_CODE" id="P_CODE" value="${pd.P_CODE}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">P_CODE:</td>
								<td><input type="text" name="P_CODE" id="P_CODE" value="${pd.P_CODE}" maxlength="10" placeholder="这里输入P_CODE" title="P_CODE" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">P_VALUE:</td>
								<td><input type="text" name="P_VALUE" id="P_VALUE" value="${pd.P_VALUE}" maxlength="20" placeholder="这里输入P_VALUE" title="P_VALUE" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">P_NAME:</td>
								<td><input type="text" name="P_NAME" id="P_NAME" value="${pd.P_NAME}" maxlength="50" placeholder="这里输入P_NAME" title="P_NAME" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">P_DES:</td>
								<td><input type="text" name="P_DES" id="P_DES" value="${pd.P_DES}" maxlength="100" placeholder="这里输入P_DES" title="P_DES" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">STATUS:</td>
								<td><input type="text" name="STATUS" id="STATUS" value="${pd.STATUS}" maxlength="1" placeholder="这里输入STATUS" title="STATUS" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">START_DATE:</td>
								<td><input class="span10 date-picker" name="START_DATE" id="START_DATE" value="${pd.START_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="START_DATE" title="START_DATE" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">END_DATE:</td>
								<td><input class="span10 date-picker" name="END_DATE" id="END_DATE" value="${pd.END_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="END_DATE" title="END_DATE" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">REMARK:</td>
								<td><input type="text" name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="100" placeholder="这里输入REMARK" title="REMARK" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#P_CODE").val()==""){
				$("#P_CODE").tips({
					side:3,
		            msg:'请输入P_CODE',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#P_CODE").focus();
			return false;
			}
			if($("#P_VALUE").val()==""){
				$("#P_VALUE").tips({
					side:3,
		            msg:'请输入P_VALUE',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#P_VALUE").focus();
			return false;
			}
			if($("#P_NAME").val()==""){
				$("#P_NAME").tips({
					side:3,
		            msg:'请输入P_NAME',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#P_NAME").focus();
			return false;
			}
			if($("#P_DES").val()==""){
				$("#P_DES").tips({
					side:3,
		            msg:'请输入P_DES',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#P_DES").focus();
			return false;
			}
			if($("#STATUS").val()==""){
				$("#STATUS").tips({
					side:3,
		            msg:'请输入STATUS',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STATUS").focus();
			return false;
			}
			if($("#START_DATE").val()==""){
				$("#START_DATE").tips({
					side:3,
		            msg:'请输入START_DATE',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#START_DATE").focus();
			return false;
			}
			if($("#END_DATE").val()==""){
				$("#END_DATE").tips({
					side:3,
		            msg:'请输入END_DATE',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#END_DATE").focus();
			return false;
			}
			if($("#REMARK").val()==""){
				$("#REMARK").tips({
					side:3,
		            msg:'请输入REMARK',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REMARK").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>