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
					
					<form action="teambuildingjoin/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="TEAMBUILDINGJOIN_ID" id="TEAMBUILDINGJOIN_ID" value="${pd.TEAMBUILDINGJOIN_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
						<c:forEach items="${pd.pd2}" var="var" varStatus="vs">
						<c:if test="${var.SCORETYPE!='其他'}">
						<tr>
						<td>
							<input name="SCORETYPE" type="radio" value="${var.SCORETYPE }" class="ace" <c:if test="${pd.pd3.SCORE==var.SCORETYPE}"> checked </c:if> />
							<span class="lbl">${var.SCORETYPE }</span>
						</td>
                        </tr>
                        </c:if>
						</c:forEach>
						<tr>
						<td>
						<input name="SCORETYPE" type="radio" id="others" value="其他" class="ace" 
						<c:if test="${fn:contains(pd.pd2,pd.pd3.SCORE)==false}">
						checked
						</c:if>
						/>
						<span class="lbl">其他</span><input type="text" name="SCORETYPE" style="margin-left: 15px;" id="other" disabled="disabled"
						<c:if test="${fn:contains(pd.pd2,pd.pd3.SCORE)==false}">
						value="${pd.pd3.SCORE}"
						</c:if>
						>
						</td>
						</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a id="save" class="btn btn-mini btn-primary" onclick="save();">保存</a>
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
			if($("#BUILDING_ID").val()==""){
				$("#BUILDING_ID").tips({
					side:3,
		            msg:'请输入建设ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BUILDING_ID").focus();
			return false;
			}
			if($("#USER_ID").val()==""){
				$("#USER_ID").tips({
					side:3,
		            msg:'请输入用户ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USER_ID").focus();
			return false;
			}
			if($("#JOINDATE").val()==""){
				$("#JOINDATE").tips({
					side:3,
		            msg:'请输入报名时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#JOINDATE").focus();
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
		
		$(function(){
			  $(":radio").click(function(){
			   if($(this).val()=='其他'){
				   $("#other").removeAttr("disabled");
			   }else
				   $("#other").attr("disabled","disabled");
			  });
			 });
		</script>
</body>
</html>