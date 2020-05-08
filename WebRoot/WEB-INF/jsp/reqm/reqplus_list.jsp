<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script type="text/javascript" src="static/js/myjs/head.js"></script>
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link rel="stylesheet" href="static/html_UI/dist/css/ace.min.css" />
 
		
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-md-12 form-horizontal">
						<form action="reqplus/dolist.do" method="post" name="Form" id="Form">
						
						<!-- 检索  -->
						<fieldset class="widget-box">
							<div class="widget-header">
								<h4 class="smaller">查询条件</h4>
							</div>
							<div class="widget-body">
								<div class="widget-main padding-8 no-padding-left ">

								   <div class="form-group">
								   
								   <label class="col-sm-1 control-label text-nowrap" for="REQ_SDPID" >SDP需求编号:</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="REQ_SDPID" name="REQ_SDPID" value="${pd.REQ_SDPID}" type="text" placeholder="请输入SDP需求编号"/>
			                          </div>
			                          
			                          <label class="col-sm-1 control-label text-nowrap" for="REQ_TITLE">需求名称:</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="REQ_TITLE" name="REQ_TITLE" value="${pd.REQ_TITLE}" type="text" placeholder="请输入需求名称"/>
			                          </div>
			                          
			                          <label class="col-sm-1 control-label text-nowrap" for="CODE_STAFF">需求开发人:</label>
			                          <div class="col-sm-3">
			                            

										<select class="chosen-select form-control" name="CODE_STAFF" id="CODE_STAFF" data-placeholder="请选择" style="vertical-align:top;width: 98%;">
											<option value=""></option>
											<c:forEach items="${userlist}" var="var" varStatus="vs">
											<option value="${var.NAME }" <c:if test="${var.NAME == pd.CODE_STAFF }">selected</c:if>>${var.NAME } </option>
											</c:forEach>
									  	</select>
			                          </div>
			                       </div>

									<div class="form-group">
			                          <label class="col-sm-1 control-label text-nowrap" for="START_DATE">开始时间:</label>
			                          <div class="col-sm-3">
 										<div class="input-group">
											<input class="form-control date-picker" id="START_DATE" name="START_DATE" value="${pd.START_DATE}"  type="text" data-date-format="yyyy-mm-dd">
											<span class="input-group-addon">
												<i class="fa fa-calendar bigger-110"></i>
											</span>
										</div>
			                          </div>
			                           <label class="col-sm-1 control-label text-nowrap" for="END_DATE">结束时间:</label>
			                          <div class="col-sm-3">
			                            <div class="input-group">
											<input class="form-control date-picker" id="END_DATE" name="END_DATE" value="${pd.END_DATE}"  type="text" data-date-format="yyyy-mm-dd">
											<span class="input-group-addon">
												<i class="fa fa-calendar bigger-110"></i>
											</span>
										</div>
			                          </div>

			                       </div>

									<div class="form-group">
			                          <label class="col-sm-1 control-label text-nowrap" for="all">需求状态:</label>
			                          <div class="col-sm-10">
											<div class="checkbox">
												<c:forEach items="${reqstatlist}" var="var">	
													<label>												
														<input name="sches" type="checkbox" class="ace" value="${var.P_VALUE }" <c:if test="${var.RSRV_STR3 == 1 }">checked</c:if> />
														<span class="lbl"  title="${var.P_DES}" >${var.P_NAME }</span>
													</label>	
												</c:forEach>
													<label>
														<input name="all" id="all"  class="ace ace-switch ace-switch-2" type="checkbox" />
														<span class="lbl" >全选</span>
													</label>
											</div>
											
													
			                          </div>
			                      </div>
    
									<c:if test="${QX.cha == 1 }">
										<div class="text-right">
											<button type="button" class="btn btn-primary btn-sm"
												style="text-shadow: black 5px 3px 3px;"
												onclick="tosearch();">查询</button>
										</div>
								    </c:if>	
								    	
								</div>
										
							</div>
						</fieldset>

					    <h4 class="header green">查询结果</h4>
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="width: 100%;height: 100%;table-layout: fixed;">	
							<thead>
								<tr>
									<th class="center" style="width:4%;">序号</th>
									<th class="center" style="width:18%;">SDP需求编号</th>
									<th class="center" >需求标题</th>
									<th class="center" >开发负责人</th>
									<th class="center" >子需求状态</th>
									<th class="center" >工作量（天）</th>
									<th class="center" >经营单元</th>
									<th class="center" >比例（%）</th>
									<th class="center" >计划开始时间</th>
									<th class="center" >计划完成时间</th>
									<th class="center" style="width:5%;">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty plusList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${plusList}" var="var" varStatus="vs">
										<tr>
											<td class='center '>${vs.index+1}</td>
											<td class='center '>${var.REQ_SDPID}</td>
											<td class='left ' title="${var.REQ_TITLE} 
${var.REQ_NOTE} " style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${var.REQ_TITLE}</td>
											<td class="center ">${var.CODE_STAFF}</td>
											<td class='center '>
												<c:choose>
													   <c:when test="${var.REQ_STATE_PLUS == '09'}"><span class="label label-lg label-danger arrowed arrowed-right"></c:when>
												       <c:when test="${var.REQ_STATE_PLUS == '10'}"><span class="label label-lg label-primary arrowed arrowed-right"></c:when>
												       <c:when test="${var.REQ_STATE_PLUS == '11' || var.REQ_STATE_PLUS == '12'|| var.REQ_STATE_PLUS == '13'}"><span class="label label-lg label-grey arrowed arrowed-right"></c:when>
												       <c:otherwise><span class="label label-lg label-success arrowed arrowed-right"></c:otherwise>
												</c:choose>
												<c:forEach items="${reqstatlist}" var="rvar">
													<c:if test="${rvar.P_VALUE == var.REQ_STATE_PLUS }">${rvar.P_NAME }</c:if>
												</c:forEach>
												</span>
											</td>
											<td class='center '>${var.WORKLOAD}</td>
											<td class='center '>${var.TONGJI_TAG}</td>
											<td class='center '>${var.TONGJI}<c:if test="${not empty var.TONGJI}">%</c:if></td>
											<td class='center ${var.redOrNotCss}'>${var.START_DATE}</td>
											<td class='center ${var.redOrNotCss}'>${var.FINISH_DATE}</td>
											
											 <td class="center ">
												<div class="hidden-sm hidden-xs action-buttons">
													<c:if test="${var.CODE_STAFF != pd.STAFF_NAME && QX.edit != 1 }">
													<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
													</c:if>
													<!-- 
													<c:if test="${QX.add == 1 }">
													    <a class="tooltip-success" data-rel="tooltip" title="新增子需求" onclick="siMenu('reqplus_edit','reqplus_edit','新增子需求','reqplus/editReqPlusInfo.do?REQ_ID=${var.REQ_ID}')">
															<span class="blue">
																<i class=" ace-icon fa fa-plus  bigger-130 blue"></i>
															</span>
														</a>
													</c:if>
													 -->
													<c:if test="${var.CODE_STAFF == pd.STAFF_NAME  || QX.edit == 1}">
														<a class="tooltip-success" data-rel="tooltip" title="子需求信息" onclick="siMenu('reqplus_edit','reqplus_edit','子需求信息','reqplus/editReqPlusInfo.do?REQ_SDPIDPLUS=${var.REQ_SDPIDPLUS}&REQ_SDPID=${var.REQ_SDPID}')">
															<span class="green">
																<i class="ace-icon fa fa-pencil bigger-130"></i>
															</span>
														</a>
													</c:if>
													 
												</div>
											</td> 
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="11" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="11" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<%--
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-sm btn-success" onclick="siMenu('reqedit','reqedit','主需求信息','reqm/editReqInfo.do')">新增</a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-sm btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
									 --%>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
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
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

		<input type="hidden" id="STAFF_NAME" name="STAFF_NAME" value="${pd.STAFF_NAME}" />
		
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	

	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
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
			
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		
		
		$("input[name='all']").click(function(){
			var flag = this.checked;
			$("input[name='sches']").each(function(){
				this.checked = flag;
			});
		});
		
		
	</script>


</body>
</html>