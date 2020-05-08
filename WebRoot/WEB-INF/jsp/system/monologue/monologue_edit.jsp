<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
		
<script type="text/javascript">
	
	
	//保存
	function save(){

		if($("#TAG_NAME").val()==""){
			$("#TAG_NAME").tips({
				side:3,
	            msg:'请输入内容',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TAG_NAME").focus();
			return false;
		}
        $("#zhongxin2").show();
		$("#Form").submit();
	}

</script>
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
								<form action="monologue/${msg }.do" name="Form" id="Form" method="post">
									<input type="hidden" name="STATUS" id="STATUS" value="${pd.STATUS}"/>
									<input type="hidden" name="TAG_ID" id="TAG_ID" value="${pd.TAG_ID}"/>
									<input type="hidden" name="TAG_AUTHOR" id="TAG_AUTHOR" value="${pd.TAG_AUTHOR}"/>
									<input type="hidden" name="msg" id="msg" value="${pd.msg}"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:70px;text-align: right;padding-top: 13px;">主题:</td>
											<td>
												<select class="chosen-select form-control" name="TOP_ID" id="TOP_ID" data-placeholder="请选择主题" style="vertical-align:top;" style="width:98%;" >
												<option value=""></option>
												<c:forEach items="${userList}" var="user">
													<option value="${user.P_VALUE}" <c:if test="${user.P_VALUE == pd.TOP_ID }">selected</c:if>>${user.P_NAME }</option>
												</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<td style="width:70px;text-align: right;padding-top: 13px;">内容:</td>
											<td>
											<textarea style="width:95%;height:100px;" rows="10" cols="10" name="TAG_NAME" id="TAG_NAME" title="内容" maxlength="500" placeholder="这里输入内容">${pd.TAG_NAME}</textarea>
											<div><font color="#808080">请不要多于500字否则无法发送</font></div>
											</td>
										</tr>
										<tr>
											<td style="width:70px;text-align: right;padding-top: 13px;">备注:</td>
											<td>
												<input style="width:95%;" type="text" name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="500" placeholder="这里输入备注" title="备注"/>
											</td>
										</tr>
										<tr>
											<td style="width:70px;text-align: right;padding-top: 13px;">匿名:</td>
											<td>
													<input id="ANONYMOUS" name="ANONYMOUS" checked="" type="checkbox" class="ace ace-switch ace-switch-5" />
													<span class="lbl middle"></span>
											</td>
										</tr>
										<c:if test="${pd.msg == editU }">
										<tr>
											<td style="width:70px;text-align: right;padding-top: 13px;">状态:</td>
											<td>
												<input id="PSTATUS" name="PSTATUS" checked="" type="checkbox" class="ace ace-switch ace-switch-5" />
												<span class="lbl middle"></span>
											</td>
										</tr>
										</c:if>
										<tr>
											<td style="text-align: center;" colspan="10">
												<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
												<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
											</td>
										</tr>
									</table>
									</div>
									
									<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
									<div id="loadgif"  style="width:150px;height:150px;position:absolute;top:80%;left:40%;">
										　　<img  alt="加载中..."  src="<%=basePath%>temp/defaultverificationcode.jpg"/>
									</div>
								</form>
								
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>	
</div>
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
	<script type="text/javascript">
	
	//修改
	if($("#TAG_AUTHOR").val()!=""){
		$("#ANONYMOUS").removeAttr("checked");
	}
	
	if($("#STATUS").val()!="0"){
		$("#PSTATUS").removeAttr("checked");
	}
	
	
	
	
	$(top.hangge());

    $(document).ready(function () { $("#loadgif").hide();});

	$(function() {
		//下拉框
		if(!ace.vars['touch']) {
			$('.chosen-select').chosen({allow_single_deselect:true}); 
			$(window)
			.off('resize.chosen')
			.on('resize.chosen', function() {
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			}).trigger('resize.chosen');
			$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
				if(event_name != 'sidebar_collapsed') return;
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			});
			$('#chosen-multiple-style .btn').on('click', function(e){
				var target = $(this).find('input[type=radio]');
				var which = parseInt(target.val());
				if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
				 else $('#form-field-select-4').removeClass('tag-input-style');
			});
		}
	});
</script>
</body>
</html>