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
			
					<form action="trainjoin/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="TRAINJOIN_ID" id="TRAINJOIN_ID" value="${pd.TRAINJOIN_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
						<c:forEach items="${pd.pd2}" var="var" varStatus="vs" >
							<tr>
<%-- 								<td style="width:150px;text-align: center;padding-top: 13px;"> ${var.SCORE_TYPE }:</td>
								<td><input type="number" name="REMARK${vs.index+1}" class="REMARK sum${vs.index+1 }" value="${var.TRAINSCORE_ID }" maxlength="32" placeholder="这里输入分数" title="打分" style="width:98%;" oninput="value=value.replace(/[^\d]/g,'')" onchange="sum100()"/></td> --%>
							
							<c:if test="${var.SCORE_TYPE !='其他' }">
							<td>
							<div class="control-group">
								<div class="radio">
									<label>
										<input name="SCORE" type="radio" class="ace" value="${var.SCORE_TYPE }" <c:if test="${pd.pd3.SCORE==var.SCORE_TYPE }"> checked </c:if> />
										<span class="lbl">${var.SCORE_TYPE }</span>
									</label>
								</div>
							</div>
							</td>
							</c:if>
							
							</tr>
						</c:forEach>
						<tr>
						<td>
						<div class="control-group">
								<div class="radio">
									<label>
										<input name="SCORE" type="radio" class="ace" value="其他" <c:if test="${fn:contains(pd.pd2,pd.pd3.SCORE)==false}">checked</c:if> />
										<span class="lbl">${var.SCORE_TYPE }</span>
										<input type="text" name="SCORE" id="elsescore"
										<c:if test="${fn:contains(pd.pd2,pd.pd3.SCORE)==false}">value="${pd.pd3.SCORE }"</c:if>
												 maxlength="255"
												placeholder="其他评价" title="其他评价" style="width: 70%;"  disabled="disabled" />
										
									</label>
								</div>
							</div>
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
		
		$(':radio').click(function(){
			console.log($("input[name='SCORE']:checked").val());
			if($("input[name='SCORE']:checked").val()=="其他"){
				console.log("qitala")
				$("#elsescore").removeAttr("disabled");
			}
			else
				$("#elsescore").attr('disabled','disabled');
		});
		
		
		
		
		$(top.hangge());
		//保存
		function save(){
			var type = $("input[name='SCORE']:checked").val();
			if($("#REMARK").val()==""){
				$("#REMARK").tips({
					side:3,
		            msg:'请输入培训打分',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REMARK").focus();
			return false;
			}
			console.log(type);
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		function sum100(){
			var sum=0;
			for(var a=1;a<100;a++){
				if($(".sum"+a).val()!=null){
				sum+=parseInt($(".sum"+a).val());
				}
			}
			if(sum>100){
				alert("分数总和大于100，请重新输入");
				$("#save").addClass("disabled");
			}
			else
				$("#save").removeClass("disabled");
				
		}
		</script>
</body>
</html>