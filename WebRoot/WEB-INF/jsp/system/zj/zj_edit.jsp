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
	<link rel="stylesheet" href="static/ace/css/chosen.css" /><style>
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
					
					<form action="zj/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ZJ_ID" id="ZJ_ID" value="${pd.ZJ_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机ip:</td>
								<td><input type="text" name="ZJ_IP" id="ZJ_IP" value="${pd.ZJ_IP}" maxlength="20" placeholder="这里输入主机ip" title="主机ip" style="width:98%;" onblur="SubmitCk()"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机用户:</td>
								<td><input type="text" name="HOST_USER" id="HOST_USER" value="${pd.HOST_USER}" maxlength="20" placeholder="这里输入主机用户" title="主机用户" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机密码:</td>
								<td><input type="text" name="HOST_PWD" id="HOST_PWD" value="${pd.HOST_PWD}" maxlength="20" placeholder="这里输入主机密码" title="主机密码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机类型:</td>
								<td>
								
							<!--  <input type="text" name="HOST_TYPE" id="HOST_TYPE" value="${pd.HOST_TYPE}" maxlength="1" placeholder="这里输入主机类型" title="主机类型" style="width:98%;"/>-->
							
							<select class="chosen-select form-control" name="HOST_TYPE" id="HOST_TYPE" data-placeholder="请选择主机类型" style="vertical-align:top;width: 120px;">
													
													<option value="0" <c:if test="${var.HOST_TYPE eq '0'}">selected</c:if>>生产</option>  
													<option value="1" <c:if test="${var.HOST_TYPE eq '1'}">selected</c:if>>测试</option>
													<option value="2" <c:if test="${var.HOST_TYPE eq '2'}">selected</c:if>>开发</option>
											  	</select> 
							
						       </td>
								
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机环境:</td>
								<td>
								
								<!--  <input type="text" name="HOST_ATTR" id="HOST_ATTR" value="${pd.HOST_ATTR}" maxlength="1" placeholder="这里输入主机环境" title="主机环境" style="width:98%;"/>-->
								
								<select class="chosen-select form-control" name="HOST_ATTR" id="HOST_ATTR" data-placeholder="请选择主机环境" style="vertical-align:top;width: 120px;">
													
													<option value="0" <c:if test="${pd.HOST_ATTR==0}">selected</c:if>>powerlinux</option>  
													<option value="1" <c:if test="${pd.HOST_ATTR==1}">selected</c:if>>aix</option>
													<option value="2" <c:if test="${pd.HOST_ATTR==2}">selected</c:if>>数据库</option>
											  	</select> 
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主要用途:</td>
								<td><input type="text" name="HOST_DES" id="HOST_DES" value="${pd.HOST_DES}" maxlength="100" placeholder="这里输入主要用途" title="主要用途" style="width:98%;"/></td>
							</tr>
							
							<!--  <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机用户端口:</td>
								<td><input type="text" name="HOST_USER_PORT" id="HOST_USER_PORT" value="${pd.HOST_USER_PORT}" maxlength="100" placeholder="这里输入主机用户端口" title="主机用户端口" style="width:98%;"/></td>
							</tr>-->
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">账户用途描述:</td>
								<td><input type="text" name="HOST_USER_DES" id="HOST_USER_DES" value="${pd.HOST_USER_DES}" maxlength="100" placeholder="这里输入账户用途描述" title="账户用途描述" style="width:98%;"/></td>
							</tr>
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">账户主要操作:</td>
								
								
								
								<td>
								
								
								
								<!--  <input type="text" name="HOST_USER_OPER" id="HOST_USER_OPER" value="${pd.HOST_USER_OPER}" maxlength="255" placeholder="这里输入账户主要操作" title="账户主要操作" style="width:98%;"/>-->
								
								<textarea rows="3" cols="80" name="HOST_USER_OPER" id="HOST_USER_OPER"  placeholder="这里输入账户主要操作" style="color：gray;resize:none">${pd.HOST_USER_OPER}</textarea>
								
								
								</td>
							</tr>
							
							
							
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机型号:</td>
								<td><input type="text" name="HOST_NOTE" id="HOST_NOTE" value="${pd.HOST_NOTE}" maxlength="50" placeholder="这里输入主机型号" title="主机型号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机名称:</td>
								<td><input type="text" name="HOST_NAME" id="HOST_NAME" value="${pd.HOST_NAME}" maxlength="50" placeholder="这里输入主机名称" title="主机名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机配置:</td>
								<td><input type="text" name="HOST_CONFIG" id="HOST_CONFIG" value="${pd.HOST_CONFIG}" maxlength="50" placeholder="这里输入主机配置" title="主机配置" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">更新员工:</td>
								<td><input type="text" name="UPDATE_STAFF_ID" id="UPDATE_STAFF_ID" value="${pd.UPDATE_STAFF_ID}" maxlength="10" placeholder="这里输入更新员工" title="更新员工" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">更新时间:</td>
								<td><input class="span10 date-picker" name="UPDATE_TIME" id="UPDATE_TIME" value="${pd.UPDATE_TIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="更新时间" title="更新时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主机状态:</td>
								<td>
								
								<select class="chosen-select form-control" name="HOST_STATUS" id="HOST_STATUS" data-placeholder="请选择主机状态" style="vertical-align:top;width: 120px;">
													
													<option value="0" <c:if test="${pd.HOST_STATUS==0}">selected</c:if>>在用</option>  
													<option value="1" <c:if test="${pd.HOST_STATUS==1}">selected</c:if>>停用</option>
												</select> 	
								<!--  <input type="text" name="HOST_STATUS" id="HOST_STATUS" value="${pd.HOST_STATUS}" maxlength="1" placeholder="这里输入主机状态" title="主机状态" style="width:98%;"/>-->
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">所属系统:</td>
								<td>
								<select class="chosen-select form-control" name="HOST_SYS" id="HOST_SYS" data-placeholder="请选择主机所属系统" style="vertical-align:top;width: 120px;">
													
													<option value="0" <c:if test="${pd.HOST_SYS==0}">selected</c:if>>CRM</option>  
													<option value="1" <c:if test="${pd.HOST_SYS==1}">selected</c:if>>BOSS</option>
													<option value="2" <c:if test="${pd.HOST_SYS==2}">selected</c:if>>ESOP</option>
													<option value="3" <c:if test="${pd.HOST_SYS==3}">selected</c:if>>客服</option>
													<option value="4" <c:if test="${pd.HOST_SYS==4}">selected</c:if>>iboss</option>
											  	</select> 
								
								<!--  <input type="text" name="HOST_SYS" id="HOST_SYS" value="${pd.HOST_SYS}" maxlength="10" placeholder="这里输入所属系统" title="所属系统" style="width:98%;"/>-->
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
		
		
		
		//IP正则校验方法
		function SubmitCk() {
        var reg =  /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/g;
        if (!reg.test($("pd.HOST_DES").val())) {
        alert("请按标准格式输入正确的IP地址，如 10.100.1.1")
        return false;
}
}
		
		
		
		function save(){
			//监听 如果为空弹出信息
			if($("#ZJ_IP").val()==""){
				$("#ZJ_IP").tips({
					side:3,
		            msg:'请输入主机ip',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ZJ_IP").focus();
			return false;
			}
			if($("#HOST_USER").val()==""){
				$("#HOST_USER").tips({
					side:3,
		            msg:'请输入主机用户',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_USER").focus();
			return false;
			}
			if($("#HOST_PWD").val()==""){
				$("#HOST_PWD").tips({
					side:3,
		            msg:'请输入主机密码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_PWD").focus();
			return false;
			}
			if($("#HOST_TYPE").val()==""){
				$("#HOST_TYPE").tips({
					side:3,
		            msg:'请输入主机类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_TYPE").focus();
			return false;
			}
			if($("#HOST_ATTR").val()==""){
				$("#HOST_ATTR").tips({
					side:3,
		            msg:'请输入主机环境',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_ATTR").focus();
			return false;
			}
	//		if($("#HOST_DES").val()==""){
    // 		$("#HOST_DES").tips({
	//				side:3,
	//	            msg:'请输入主要用途',
	//	            bg:'#AE81FF',
	//	            time:2
	//	        });
	//			$("#HOST_DES").focus();
	//		return false;
	//		}
			//if($("#HOST_USER_PORT").val()==""){
			//	$("#HOST_USER_PORT").tips({
			//		side:3,
		      //      msg:'请输入主机用户端口',
		     //       bg:'#AE81FF',
		     //       time:2
		    //    });
			//	$("#HOST_USER_PORT").focus();
			//return false;
			//}
	//		if($("#HOST_USER_DES").val()==""){
	//			$("#HOST_USER_DES").tips({
	//				side:3,
	//	            msg:'请输入账户用途描述',
	//	            bg:'#AE81FF',
	//	            time:2
	//	        });
	//			$("#HOST_USER_DES").focus();
	//		return false;
	//		}
			/* if($("#HOST_USER_OPER").val()==""){
				$("#HOST_USER_OPER").tips({
					side:3,
		            msg:'请输入账户主要操作',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_USER_OPER").focus();
			return false;
			}
			if($("#HOST_NOTE").val()==""){
				$("#HOST_NOTE").tips({
					side:3,
		            msg:'请输入主机型号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_NOTE").focus();
			return false;
			}
			if($("#HOST_NAME").val()==""){
				$("#HOST_NAME").tips({
					side:3,
		            msg:'请输入主机名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_NAME").focus();
			return false;
			}
			if($("#HOST_CONFIG").val()==""){
				$("#HOST_CONFIG").tips({
					side:3,
		            msg:'请输入主机配置',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_CONFIG").focus();
			return false;
			}
			if($("#UPDATE_STAFF_ID").val()==""){
				$("#UPDATE_STAFF_ID").tips({
					side:3,
		            msg:'请输入更新员工',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATE_STAFF_ID").focus();
			return false;
			}
			if($("#UPDATE_TIME").val()==""){
				$("#UPDATE_TIME").tips({
					side:3,
		            msg:'请输入更新时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATE_TIME").focus();
			return false;
			} */
			if($("#HOST_STATUS").val()==""){
				$("#HOST_STATUS").tips({
					side:3,
		            msg:'请输入主机状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_STATUS").focus();
			return false;
			}
			if($("#HOST_SYS").val()==""){
				$("#HOST_SYS").tips({
					side:3,
		            msg:'请输入所属系统',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOST_SYS").focus();
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