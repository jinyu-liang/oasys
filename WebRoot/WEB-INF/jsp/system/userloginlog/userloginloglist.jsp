<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
						<div class="col-xs-12 form-horizontal">
							
						<!-- 检索  -->
						<form action="userloginlog/list.do" method="post" name="Form" id="Form">
						
						
						<fieldset class="widget-box">
							<div class="widget-header">
								<h4 class="smaller">查询条件</h4>
								<input type="hidden" id="FLAG" name="FLAG" value="${pd.FLAG}" />
								
							</div>
							<div class="widget-body">
								<div class=" widget-main padding-8 no-padding-left">
									<div class="form-group">
			                          <label class="col-sm-1 control-label" for="P_VALUE">考勤类型:</label>
			                          <div class="col-sm-3">
			                            <select class="chosen-select form-control" name="LOG_TYPE" id="LOG_TYPE" data-placeholder="请选择考勤类型" style="vertical-align:top;width: 150px;">
											<option value=""></option>
											<option value="签到" <c:if test="${pd.LOG_TYPE == '签到' }">selected</c:if>>签到</option>
											<option value="迟到" <c:if test="${pd.LOG_TYPE == '迟到' }">selected</c:if>>迟到</option>
											<option value="签到->签退" <c:if test="${pd.LOG_TYPE == '签到->签退' }">selected</c:if>>签到->签退</option>
											<option value="迟到->签退" <c:if test="${pd.LOG_TYPE == '迟到->签退' }">selected</c:if>>迟到->签退</option>
									  	</select>
			                          </div>
			                          
			                          <label class="col-sm-1 control-label" for="USER_NAME" >用户名:</label>
			                          <div class="col-sm-3">
			                            <select class="chosen-select form-control" name="USER_NAME" id="USER_NAME" data-placeholder="请选择" style="vertical-align:top;width: 98%;">
											<option value=""></option>
											<c:forEach items="${userlist}" var="var" varStatus="vs">
											<option value="${var.NAME }" <c:if test="${var.NAME == pd.USER_NAME }">selected</c:if>>${var.NAME } </option>
											</c:forEach>
									  	</select>
			                          </div>
			                          
			                           <label class="col-sm-1 control-label" for="GROUP_ID" >组别:</label>
			                          <div class="col-sm-3">
			                            <select class="chosen-select form-control" name="GROUP_ID" id="GROUP_ID" data-placeholder="请选择组别" style="vertical-align: top;" style="width:98%;">
												<option value=""></option>
												<c:forEach items="${grouplist}" var="group">
													<option value="${group.GROUP_ID }" <c:if test="${group.GROUP_ID == pd.GROUP_ID }">selected</c:if> >${group.GROUP_NAME }(${group.REMARK })</option>
												</c:forEach>
										</select>
			                          </div>
			                          
			                       </div>
			                       
									<div class="form-group">
			                          <label class="col-sm-1 control-label" for="START_DATE" >开始时间:</label>
			                          <div class="col-sm-3">
 										<div class="input-group">
											<input class="form-control date-picker" id="START_DATE" name="START_DATE" value="${pd.START_DATE}"  type="text" data-date-format="yyyy-mm-dd">
											<span class="input-group-addon">
												<i class="fa fa-calendar bigger-110"></i>
											</span>
										</div>
			                          </div>
			                           <label class="col-sm-1 control-label" for="END_DATE" >结束时间:</label>
			                          <div class="col-sm-3">
			                            <div class="input-group">
											<input class="form-control date-picker" id="END_DATE" name="END_DATE" value="${pd.END_DATE}"  type="text" data-date-format="yyyy-mm-dd">
											<span class="input-group-addon">
												<i class="fa fa-calendar bigger-110"></i>
											</span>
										</div>
			                          </div>
			                       </div>
			                       
			                       <div class="text-right">
			                       <button type="button" class="btn btn-primary btn-sm" style="text-shadow: black 5px 3px 3px;" onclick="tosearch();">
									查询
									</button>
									<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
									
			                       </div>
								</div>
							</div>
						</fieldset>
						
						
						</form>
						<!-- 检索  -->
					<h4 class="header green">查询结果</h4>
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<!-- <th class="center" style="display:hidden;">用户ID</th> -->
									<th class="center">用户名</th>
									<th class="center">考勤类型</th>
									<th class="center">登录IP</th>
									<th class="center">登录时间</th>
									<th class="center">签退时间</th>
									<th class="center">缺勤时长(分钟)</th>
									<!-- <th class="center">备注</th> -->
									<!-- <th class="center">更新ID</th> -->
									<th class="center">考勤日期</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.USER_LOGIN_LOG_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<%-- <td class='center' style="display:hidden;">${var.USER_ID}</td> --%>
											<td class='center'>${var.USER_NAME}</td>
											<td class='center'>${var.LOG_TYPE}</td>
											<td class='center'>${var.LOG_IP}</td>
											<td class='center'>${var.IN_DATE}</td>
											<td class='center'>${var.OUT_DATE}</td>
											<td class='center'>${var.ABS_TIMES}</td>
											<%-- <td class='center'>${var.REMARK}</td> --%>
											<%-- <td class='center'>${var.UPDATE_ID}</td> --%>
											<td class='center'>${var.UPDATE_TIME}</td>
											
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<c:if test="${var.show==1}">
													<a class="btn btn-xs btn-danger" title="签退" onclick="signout('${var.USER_LOGIN_LOG_ID}','${var.USER_ID}');">
														<i>签退</i>
													</a>
													</c:if>
													</c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="signout('${var.USER_LOGIN_LOG_ID}','${var.USER_ID}');" class="tooltip-success" data-rel="tooltip" title="签退">
																	<span class="red">
																		<i>签退</i>
																	</span>
																</a>
															</li>
															</c:if>
															<%-- <c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.USER_LOGIN_LOG_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if> --%>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<%-- <td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-sm btn-success" onclick="add();">新增</a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-sm btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
								</td> --%>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
						
					
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

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
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
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>user_login_log/goAdd.do';
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>user_login_log/delete.do?USER_LOGIN_LOG_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//签退
 		function signout(Id,userId){
 					var data={"id":Id,"name":userId}
					var url = "<%=basePath%>userloginlog/signout.do";
					$.post(url,data,function(data){
						nextPage(${page.currentPage});
					});
		} 
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>user_login_log/goEdit.do?USER_LOGIN_LOG_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>user_login_log/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}
					}
				}
			});
		};
		
		//导出excel
		function toExcel(){
			var logtype = $("#LOG_TYPE").val();
			var username = $("#USER_NAME").val();
			var groupid = $("#GROUP_ID").val();
			var startdate = $("#START_DATE").val();
			var enddate = $("#END_DATE").val();
			var url='<%=basePath%>userloginlog/excel.do?LOG_TYPE='+logtype+'&USER_NAME='+username+'&GROUP_ID='+groupid+'&START_DATE='+startdate+'&END_DATE='+enddate;
			window.location.href=url;
			
		}
	</script>


</body>
</html>