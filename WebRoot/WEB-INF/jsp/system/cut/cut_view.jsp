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
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 日期框 -->

		
<script type="text/javascript">
	
	


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
								<form action="cut/${msg }.do" name="Form" id="Form" method="post">
									<input type="hidden" name="CUT_ID" id="CUT_ID" value="${pd.CUT_ID}"/>

									<input type="hidden" name="msg" id="msg" value="${pd.msg}"/>
									<div id="zhongxin" style="padding-top: 13px;">

										<table id="table_report" class="table table-striped table-bordered table-hover">
											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">割接标题:</td>
												<td>
													<input style="width:95%;" type="text" name="CUT_TITLE" id="CUT_TITLE" value="${pd.CUT_TITLE}" maxlength="500" placeholder="这里输入标题"  disabled="disabled" title="标题"/>
												</td>
											</tr>
											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">割接负责人:</td>
												<td>
													<select class="chosen-select form-control" name="CUT_RESP_P" id="CUT_RESP_P" data-placeholder="请选择故障处理人"  disabled="disabled" style="vertical-align:top;" style="width:98%;" >
														<option value=""></option>
														<c:forEach items="${userList}" var="user">
															<option value="${user.USERNAME}" <c:if test="${user.USERNAME == pd.CUT_RESP_P }">selected</c:if>>${user.NAME }</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">IT负责人:</td>
												<td>
													<select class="chosen-select form-control" name="IT_CUT_RESP_P" id="IT_CUT_RESP_P" data-placeholder="请选择故障报告人"   disabled="disabled" style="vertical-align:top;" style="width:98%;" >
														<option value=""></option>
														<c:forEach items="${userList}" var="user">
															<option value="${user.USERNAME}" <c:if test="${user.USERNAME == pd.IT_CUT_RESP_P }">selected</c:if>>${user.NAME }</option>
														</c:forEach>
													</select>
												</td>
											</tr>

											<tr>
												<td style="padding-top: 13px;">割接时间</td>
												<td>
													<input class="span10 date-picker" name="CUT_TIME" id="CUT_TIME"  value="${pd.CUT_TIME}"    disabled="disabled"
														   type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="故障时间" title="故障时间"/>
												</td>
											</tr>

											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">割接成员:</td>
												<td>
													<textarea style="width:95%;height:100px;" rows="10" cols="10" name="CUT_MEMBER" id="CUT_MEMBER" title="切割成员" maxlength="500" disabled="disabled" placeholder="这里输入内容">${pd.CUT_MEMBER}</textarea>
													<div><font color="#808080">请不要多于100字否则无法发送</font></div>
												</td>
											</tr>

											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">割接IT验证人:</td>
												<td>
													<select class="chosen-select form-control" name="CUT_IT_VERIFIER" id="CUT_IT_VERIFIER" disabled="disabled" data-placeholder="请选择切割IT验证人" style="vertical-align:top;" style="width:98%;"  >
														<option value=""></option>
														<c:forEach items="${userList}" var="user">
															<option value="${user.USERNAME}" <c:if test="${user.USERNAME == pd.CUT_IT_VERIFIER }">selected</c:if>>${user.NAME }</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">割接详细描述:</td>
												<td>
													<textarea style="width:95%;height:100px;" rows="10" cols="10" name="CUT_DETAIL_DESCI" id="CUT_DETAIL_DESCI" disabled="disabled" title="切割详细描述" maxlength="500" placeholder="这里输入内容">${pd.CUT_DETAIL_DESCI}</textarea>
													<div><font color="#808080">请不要多于500字否则无法发送</font></div>
												</td>
											</tr>
											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">割接影响:</td>
												<td>
													<textarea style="width:95%;height:100px;" rows="10" cols="10" name="CUT_INFLU" id="CUT_INFLU" title="割接影响" maxlength="500" placeholder="这里输入内容" disabled="disabled">${pd.CUT_INFLU}</textarea>
													<div><font color="#808080">请不要多于500字否则无法发送</font></div>
												</td>
											</tr>
											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">割接处理过程:</td>
												<td>
													<textarea style="width:95%;height:100px;" rows="10" cols="10" name="CUT_PROCE_PROCE" id="CUT_PROCE_PROCE" title="割接处理过程" maxlength="500" placeholder="这里输入内容" disabled="disabled">${pd.CUT_PROCE_PROCE}</textarea>
													<div><font color="#808080">请不要多于500字否则无法发送</font></div>
												</td>
											</tr>
											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">割接分析和总结:</td>
												<td>
													<textarea style="width:95%;height:100px;" rows="10" cols="10" name="CUT_ANALYSISANDSUMMARY" id="CUT_ANALYSISANDSUMMARY" title="切割分析和总结" maxlength="500" placeholder="这里输入内容" disabled="disabled">${pd.CUT_ANALYSISANDSUMMARY}</textarea>
													<div><font color="#808080">请不要多于500字否则无法发送</font></div>
												</td>
											</tr>
											<tr>
												<td style="width:70px;text-align: right;padding-top: 13px;">后续工作安排:</td>
												<td>
													<textarea style="width:95%;height:100px;" rows="10" cols="10" name="CUT_AFTERANDARRANGE" id="CUT_AFTERANDARRANGE" title="后续工作安排" maxlength="500" placeholder="这里输入内容" disabled="disabled">${pd.CUT_AFTERANDARRANGE}</textarea>
													<div><font color="#808080">请不要多于500字否则无法发送</font></div>
												</td>
											</tr>




												<td  style="text-align: center;" colspan="10">

													<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">关闭</a>
												</td>
											</tr>
										</table>

									</div>

									<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>

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
</body>
	<script type="text/javascript">



		$(top.hangge());


		$(function() {


        //日期框
        $('.date-picker').datepicker({
            autoclose: true,
            todayHighlight: true
        });
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

</html>