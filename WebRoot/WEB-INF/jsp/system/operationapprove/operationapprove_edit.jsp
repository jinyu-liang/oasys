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
	<style>
	.search_input::-webkit-input-placeholder{
	    color:#b6b6b6;
	}
	.search_input:-moz-placeholder{
	    color:#b6b6b6;
	}
	.search_input::-moz-placeholder{
	    color:#b6b6b6;
	}
	.search_input:-ms-input-placeholder{
	    color:#b6b6b6;
	}
	
	

	
	</style>
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
					
					<form action="operationapprove/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="APPROVE_ID" id="APPROVE_ID" value="${pd.APPROVE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							
							<!-- 
							   <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">流水号:</td>
								<td><input type="text" name="APPROVE_ID" id="APPROVE_ID" value="${pd.APPROVE_ID}" maxlength="30" placeholder="这里输入流水号" title="流水号" style="width:98%;"/></td>
							</tr>
							
							 -->
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">提交人ID:</td>
								<td><input type="text" name="SUBMITID" id="SUBMITID" value="${pd.SUBMITID}" maxlength="50" placeholder="这里输入提交人ID" title="提交人ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">提交人:</td>
								<td><input type="text" name="SUBMITTER" id="SUBMITTER" value="${pd.SUBMITTER}" maxlength="20" placeholder="这里输入提交人" title="提交人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">提交时间:</td>
								<td><input class="span10 date-picker" name="SUBMINT_DATE" id="SUBMINT_DATE" value="${pd.SUBMINT_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="提交时间" title="提交时间" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">更新人:</td>
								<td><input type="text" name="UPDATE_PEOPLE" id="UPDATE_PEOPLE" value="${pd.UPDATE_PEOPLE}" maxlength="20" placeholder="这里输入更新人" title="更新人" style="width:98%;"/></td>
							</tr>
							
						    <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">更新时间:</td>
								<td><input class="span10 date-picker" name="UPDATE_DATE" id="UPDATE_DATE" value="${pd.UPDATE_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="更新时间" title="更新时间" style="width:98%;"/></td>
							</tr>
								
							
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">问题描述:</td>
								<!--  <td><input type="text" name="QUES_DESCRIBE" id="QUES_DESCRIBE" value="${pd.QUES_DESCRIBE}" maxlength="255" placeholder="这里输入问题描述" title="问题描述" style="width:98%;"/></td>
							-->
							<td>
							<textarea class="search_input" rows="5" cols="55" name="QUES_DESCRIBE" id="QUES_DESCRIBE"  placeholder="这里输入问题描述"  style="resize:none" >${pd.QUES_DESCRIBE}</textarea>
							</td>
							</tr>
							
							
							
							<!-- 这里根据不同的情况设定textarea的样式 并且定死，禁止拉伸 none -->
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">解决方案:</td>
								<!--  <td><input type="text" name="SOLUTION" id="SOLUTION" value="${pd.SOLUTION}" maxlength="255" placeholder="这里输入解决方案" title="解决方案" style="width:98%;"/></td>
							-->
							<td>
							<textarea class="search_input" rows="5" cols="55" name="SOLUTION" id="SOLUTION"  placeholder="这里输入解决方案"  style="resize:none" >${pd.SOLUTION}</textarea>
							</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">风险评估:</td>
								<td><input type="text" name="RISK_ASSESS" id="RISK_ASSESS" value="${pd.RISK_ASSESS}" maxlength="100" placeholder="这里输入风险评估" title="风险评估" style="width:98%;"/></td>
							</tr>
							
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">更新内容:</td>
							<!--  	<td><input type="text" name="UPDATE_CONTENT" id="UPDATE_CONTENT" value="${pd.UPDATE_CONTENT}" maxlength="255" placeholder="这里输入更新内容" title="更新内容" style="width:98%;"/></td>
							-->
							<td>
							<textarea  class="search_input" style="color:gray;resize:none"  rows="5" cols="55" name="UPDATE_CONTENT" id="UPDATE_CONTENT"  placeholder="这里输入更新内容"    >${pd.UPDATE_CONTENT}</textarea>
							</td>
							</tr>
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">更新步骤:</td>
								<!--  <td><input type="text" name="UPDATE_STEP" id="UPDATE_STEP" value="${pd.UPDATE_STEP}" maxlength="255" placeholder="这里输入更新步骤" title="更新步骤" style="width:98%;"/></td>-->
								<td>
							<textarea class="search_input" rows="2" cols="55" name="UPDATE_STEP" id="UPDATE_STEP"  placeholder="这里输入更新步骤"  style="color：gray;resize:none" >${pd.UPDATE_STEP}</textarea>
							</td>
							
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">验证方法:</td>
								<td><input type="text" name="TEST_METHOD" id="TEST_METHOD" value="${pd.TEST_METHOD}" maxlength="255" placeholder="这里输入验证方法" title="验证方法" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">局方主管:</td>
								<td><input type="text" name="OFFICE_SUPERVISOR" id="OFFICE_SUPERVISOR" value="${pd.OFFICE_SUPERVISOR}" maxlength="20" placeholder="这里输入局方主管" title="局方主管" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">局方经理:</td>
								<td><input type="text" name="OFFICE_MANAGER" id="OFFICE_MANAGER" value="${pd.OFFICE_MANAGER}" maxlength="20" placeholder="这里输入局方经理" title="局方经理" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">局方审批状态:</td>
								<!--  <td><input type="text" name="APPROVE_STATE" id="APPROVE_STATE" value="${pd.APPROVE_STATE}" maxlength="20" placeholder="这里输入局方审批状态" title="局方审批状态" style="width:98%;"/></td>-->
							<td>
							
							<!--  <select class="chosen-select form-control" name="APPROVE_STATE" id="APPROVE_STATE" data-placeholder="请选择局方审批状态" style="vertical-align:top;width: 120px;">
													<option value="" <c:if test="${pd.APPROVE_STATE==null}">selected</c:if>>——请选择——</option> 
													<option value="审批" <c:if test="${pd.APPROVE_STATE==审批}">selected</c:if>>审批</option>  
													<option value="审批不通过" <c:if test="${pd.APPROVE_STATE==审批不通过}">selected</c:if>>审批不通过</option>
													<option value="已审批" <c:if test="${pd.APPROVE_STATE==已审批}">selected</c:if>>已审批</option>
											  	</select>  -->
							
							
									<select class="chosen-select form-control" name="APPROVE_STATE" id="APPROVE_STATE" data-placeholder="请选择局方审批状态" style="vertical-align:top;width: 130px;">
									 
									 <option value=""<c:if test="${pd.APPROVE_STATE eq ''}">selected</c:if>>——请选择——</option>
									<option value="审批" <c:if test="${pd.APPROVE_STATE eq '审批'}">selected</c:if>>审批</option>  
									<option value="审批不通过" <c:if test="${pd.APPROVE_STATE eq '审批不通过'}">selected</c:if>>审批不通过</option>
									<option value="已审批" <c:if test="${pd.APPROVE_STATE eq '已审批'}">selected</c:if>>已审批</option>
								  	</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">局方审批意见:</td>
								<td><input type="text" name="APPROVE_SUGGES" id="APPROVE_SUGGES" value="${pd.APPROVE_SUGGES}" maxlength="255" placeholder="这里输入局方审批意见" title="局方审批意见" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">亚信主管:</td>
								<td><input type="text" name="ASI_OFFICE_SUPERVISOR" id="ASI_OFFICE_SUPERVISOR" value="${pd.ASI_OFFICE_SUPERVISOR}" maxlength="20" placeholder="这里输入亚信主管" title="亚信主管" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">亚信经理:</td>
								<td><input type="text" name="ASI_OFFICE_MANAGER" id="ASI_OFFICE_MANAGER" value="${pd.ASI_OFFICE_MANAGER}" maxlength="20" placeholder="这里输入亚信经理" title="亚信经理" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">亚信审批状态:</td>
								<!--  <td><input type="text" name="ASI_APPROVE_STATE" id="ASI_APPROVE_STATE" value="${pd.ASI_APPROVE_STATE}" maxlength="20" placeholder="这里输入亚信审批状态" title="亚信审批状态" style="width:98%;"/></td>
							-->
							<td>
								 	<select class="chosen-select form-control" name="ASI_APPROVE_STATE" id="ASI_APPROVE_STATE" data-placeholder="请选择亚信审批状态" style="vertical-align:top;width: 130px;">
									 
									 <option value=""<c:if test="${pd.ASI_APPROVE_STATE eq ''}">selected</c:if>>——请选择——</option>
									<option value="审批" <c:if test="${pd.ASI_APPROVE_STATE eq '审批'}">selected</c:if>>审批</option>  
									<option value="审批不通过" <c:if test="${pd.ASI_APPROVE_STATE eq '审批不通过'}">selected</c:if>>审批不通过</option>
									<option value="已审批" <c:if test="${pd.ASI_APPROVE_STATE eq '已审批'}">selected</c:if>>已审批</option>
								  	</select>
								</td>
							
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">亚信审批意见:</td>
								<td><input type="text" name="ASI_APPROVE_SUGGES" id="ASI_APPROVE_SUGGES" value="${pd.ASI_APPROVE_SUGGES}" maxlength="20" placeholder="这里输入亚信审批意见" title="亚信审批意见" style="width:98%;"/></td>
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
			 /* if($("#APPROVE_ID").val()==""){
				$("#APPROVE_ID").tips({
					side:3,
		            msg:'请输入流水号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#APPROVE_ID").focus();
			return false;
			} */
		/* 	if($("#SUBMITID").val()==""){
				$("#SUBMITID").tips({
					side:3,
		            msg:'请输入提交人ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SUBMITID").focus();
			return false;
			} */
			if($("#SUBMITTER").val()==""){
				$("#SUBMITTER").tips({
					side:3,
		            msg:'请输入提交人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SUBMITTER").focus();
			return false;
			}
			if($("#SUBMINT_DATE").val()==""){
				$("#SUBMINT_DATE").tips({
					side:3,
		            msg:'请输入提交时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SUBMINT_DATE").focus();
			return false;
			}
			 
			
			if($("#UPDATE_PEOPLE").val()==""){
				$("#UPDATE_PEOPLE").tips({
					side:3,
		            msg:'请输入更新人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATE_PEOPLE").focus();
			return false;
			}
			
		
			
			if($("#UPDATE_DATE").val()==""){  //我他娘竟然在if前边多打了一个阿拉伯数字1.。。。差点爆炸，记录一下。。。。
				$("#UPDATE_DATE").tips({
					side:3,
		            msg:'请输入更新时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATE_DATE").focus();
			return false;
			}
			
			
			
/* 			if($("#QUES_DESCRIBE").val()==""){
				$("#QUES_DESCRIBE").tips({
					side:3,
		            msg:'请输入问题描述',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#QUES_DESCRIBE").focus();
			return false;
			}
			if($("#SOLUTION").val()==""){
				$("#SOLUTION").tips({
					side:3,
		            msg:'请输入解决方案',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SOLUTION").focus();
			return false;
			}
			if($("#RISK_ASSESS").val()==""){
				$("#RISK_ASSESS").tips({
					side:3,
		            msg:'请输入风险评估',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RISK_ASSESS").focus();
			return false;
			}
			if($("#UPDATE_CONTENT").val()==""){
				$("#UPDATE_CONTENT").tips({
					side:3,
		            msg:'请输入更新内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATE_CONTENT").focus();
			return false;
			}
			if($("#UPDATE_STEP").val()==""){
				$("#UPDATE_STEP").tips({
					side:3,
		            msg:'请输入更新步骤',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATE_STEP").focus();
			return false;
			}
			if($("#TEST_METHOD").val()==""){
				$("#TEST_METHOD").tips({
					side:3,
		            msg:'请输入验证方法',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TEST_METHOD").focus();
			return false;
			}
			if($("#OFFICE_SUPERVISOR").val()==""){
				$("#OFFICE_SUPERVISOR").tips({
					side:3,
		            msg:'请输入局方主管',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OFFICE_SUPERVISOR").focus();
			return false;
			}
			if($("#OFFICE_MANAGER").val()==""){
				$("#OFFICE_MANAGER").tips({
					side:3,
		            msg:'请输入局方经理',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OFFICE_MANAGER").focus();
			return false;
			} */
			if($("#APPROVE_STATE").val()==""){
				$("#APPROVE_STATE").tips({
					side:3,
		            msg:'请输入局方审批状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#APPROVE_STATE").focus();
			return false;
			}
			/* if($("#APPROVE_SUGGES").val()==""){
				$("#APPROVE_SUGGES").tips({
					side:3,
		            msg:'请输入局方审批意见',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#APPROVE_SUGGES").focus();
			return false;
			} */
			/* if($("#ASI_OFFICE_SUPERVISOR").val()==""){
				$("#ASI_OFFICE_SUPERVISOR").tips({
					side:3,
		            msg:'请输入亚信主管',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ASI_OFFICE_SUPERVISOR").focus();
			return false;
			}
			if($("#ASI_OFFICE_MANAGER").val()==""){
				$("#ASI_OFFICE_MANAGER").tips({
					side:3,
		            msg:'请输入亚信经理',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ASI_OFFICE_MANAGER").focus();
			return false;
			}
			if($("#ASI_APPROVE_STATE").val()==""){
				$("#ASI_APPROVE_STATE").tips({
					side:3,
		            msg:'请输入亚信审批状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ASI_APPROVE_STATE").focus();
			return false;
			}
			if($("#ASI_APPROVE_SUGGES").val()==""){
				$("#ASI_APPROVE_SUGGES").tips({
					side:3,
		            msg:'请输入亚信审批意见',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ASI_APPROVE_SUGGES").focus();
			return false;
			} */
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