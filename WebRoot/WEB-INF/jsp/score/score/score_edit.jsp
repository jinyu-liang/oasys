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
	<link rel="stylesheet" href="static/ace/css/ace.css" />
	
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
					
					<form action="score/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="SCORE_ID" id="SCORE_ID" value="${pd.SCORE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">积分标题:</td>
								<td><input type="text" name="SCORE_NAME" id="SCORE_NAME" value="${pd.SCORE_NAME}" maxlength="255" placeholder="这里输入积分标题" title="积分标题" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">积分原始总量:</td>
								<td><input type="number" name="SCORE_VALUE" id="SCORE_VALUE" value="${pd.SCORE_VALUE}" maxlength="32" placeholder="这里输入积分原始总量" title="积分原始总量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目ID:</td>
								<td><input type="text" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}" maxlength="255" placeholder="这里输入项目ID" title="项目ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目名称:</td>
								<td><input type="text" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME}" maxlength="255" placeholder="这里输入项目名称" title="项目名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目金额:</td>
								<td><input type="number" name="PROJECT_AMOUNT" id="PROJECT_AMOUNT" value="${pd.PROJECT_AMOUNT}" maxlength="32" placeholder="这里输入项目金额" title="项目金额" style="width:98%;"/></td>
							</tr>
							<%-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">积分与项目金额比例:</td>
								<td><input type="text" name="SCORE_PROPORTION" id="SCORE_PROPORTION" value="${pd.SCORE_PROPORTION}" maxlength="255" placeholder="这里输入积分与项目金额比例" title="积分与项目金额比例" style="width:98%;"/></td>
							</tr> --%>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">生效时间:</td>
								<td><input class="span10 date-picker" name="START_DATE" id="START_DATE" value="${pd.START_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="生效时间" title="生效时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">失效时间:</td>
								<td><input class="span10 date-picker" name="END_DATE" id="END_DATE" value="${pd.END_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="失效时间" title="失效时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" value="${reason }" id="reason">${reason }</td>
								<td><textarea id="form-field-11" class="autosize-transition form-control" name="REMARK"  value="${pd.REMARK}" maxlength="255" placeholder="${reason }" title="${reason }"></textarea>
								</td>
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
			if($("#reason").html().localeCompare("修改原因：")==0){
				if($("#form-field-11").val()==""){
					$("#form-field-11").tips({
						side:3,
			            msg:'请输修改原因',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#form-field-11").focus();
				return false;
				}
			}
			if($("#SCORE_NAME").val()==""){
				$("#SCORE_NAME").tips({
					side:3,
		            msg:'请输入积分标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_NAME").focus();
			return false;
			}
			if($("#SCORE_VALUE").val()==""){
				$("#SCORE_VALUE").tips({
					side:3,
		            msg:'请输入积分原始总量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_VALUE").focus();
			return false;
			}
			if($("#PROJECT_ID").val()==""){
				$("#PROJECT_ID").tips({
					side:3,
		            msg:'请输入项目ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_ID").focus();
			return false;
			}
			if($("#PROJECT_NAME").val()==""){
				$("#PROJECT_NAME").tips({
					side:3,
		            msg:'请输入项目名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_NAME").focus();
			return false;
			}
			if($("#PROJECT_AMOUNT").val()==""){
				$("#PROJECT_AMOUNT").tips({
					side:3,
		            msg:'请输入项目金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_AMOUNT").focus();
			return false;
			}
			if($("#SCORE_PROPORTION").val()==""){
				$("#SCORE_PROPORTION").tips({
					side:3,
		            msg:'请输入积分与项目金额比例',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_PROPORTION").focus();
			return false;
			}
			if($("#START_DATE").val()==""){
				$("#START_DATE").tips({
					side:3,
		            msg:'请输入生效时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#START_DATE").focus();
			return false;
			}
			if($("#END_DATE").val()==""){
				$("#END_DATE").tips({
					side:3,
		            msg:'请输入失效时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#END_DATE").focus();
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