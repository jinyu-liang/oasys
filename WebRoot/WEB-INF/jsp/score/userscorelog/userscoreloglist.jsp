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
						<form action="user_score_log/list.do" method="post" name="Form" id="Form">
						
						<!-- 检索  -->
						<fieldset class="widget-box">
							<div class="widget-header">
								<h4 class="smaller">查询条件</h4>
							</div>
							<div class="widget-body">
								<div class="widget-main ">
									<div class="form-group">
			                          <label class="col-sm-1 control-label" for="P_VALUE">日志类型</label>
			                          <div class="col-sm-3">
			                             <select class="chosen-select form-control" name="LOG_TYPE" id="LOG_TYPE" data-placeholder="请选择类型" style="vertical-align:top;" style="width:98%;" >
											<option value=""></option>
											<c:forEach items="${sysList}" var="sys">
												<option value="${sys.P_VALUE}" <c:if test="${sys.P_VALUE == pd.LOG_TYPE }">selected</c:if>>${sys.P_NAME }</option>
											</c:forEach>
										 </select>
			                          </div>
			                          <label class="col-sm-1 control-label" for="SCORE_NAME">积分名</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="SCORE_NAME" name="SCORE_NAME" value="${pd.SCORE_NAME}" type="text" placeholder="请输入积分名"/>
			                          </div>
			                           <label class="col-sm-1 control-label" for="USER_NAME">操作员工</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="USER_NAME" name="USER_NAME" value="${pd.USER_NAME}"  type="text" placeholder="请输入操作员工"/>
			                          </div>
			                       </div>
									<div class="form-group">
			                          <label class="col-sm-1 control-label" for="START_DATE">开始时间</label>
			                          <div class="col-sm-3">
 										<div class="input-group">
											<input class="form-control date-picker" id="START_DATE" name="START_DATE" value="${pd.START_DATE}"  type="text" data-date-format="yyyy-mm-dd">
											<span class="input-group-addon">
												<i class="fa fa-calendar bigger-110"></i>
											</span>
										</div>
			                          </div>
			                           <label class="col-sm-1 control-label" for="END_DATE">结束时间</label>
			                          <div class="col-sm-3">
			                            <div class="input-group">
											<input class="form-control date-picker" id="END_DATE" name="END_DATE" value="${pd.END_DATE}"  type="text" data-date-format="yyyy-mm-dd">
											<span class="input-group-addon">
												<i class="fa fa-calendar bigger-110"></i>
											</span>
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
						<!-- 检索  -->
					
					
					
					    <h4 class="header green">查询结果</h4>
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="width: 100%;height: 100%;table-layout: fixed;">	
							<thead>
								<tr>
									<th class="center" style="width:3%;">序号</th>
									<th class="center" style="width:8%;">业务流水</th>
									<th class="center" style="width:8%;">日志类型</th>
									<th class="center" style="width:8%;">积分名</th>
									<th class="center" style="width:8%;">源积分值</th>
									<th class="center" style="width:8%;">赠送人</th>
									<th class="center" style="width:8%;">赠送积分</th>
									<th class="center" style="width:8%;">被赠人</th>
									<th class="center" style="width:8%;">被赠积分</th>
									<th class="center" style="width:8%;">备注</th>
									<th class="center" style="width:8%;">操作员工</th>
									<th class="center" style="width:9%;">操作时间</th>
									<!-- <th class="center">操作</th> -->
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<%-- <td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.USER_SCORE_LOG_ID}" class="ace" /><span class="lbl"></span></label>
											</td> --%>
											<td class='center'>${vs.index+1}</td>
											<td class='center'>${var.USER_SCORE_LOG_ID}</td>
											<td class='center'>${var.LOG_TYPE_NAME}</td>
											<td class='center'>${var.SCORE_NAME}</td>
											<td class='center'>${var.SCORE_VALUE}</td>
											<td class='center'>${var.SCORE_IN_NAME}</td>
											<td class='center'>${var.SCORE_IN_VALUE}</td>
											<td class='center'>${var.SCORE_OUT_NAME}</td>
											<td class='center'>${var.SCORE_OUT_VALUE}</td>
											<td class='center ' title='${var.REMARK}' style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${var.REMARK}</td>
											<td class='center'>${var.USER_NAME}</td>
											<td class='center'>${var.UPDATE_DATE}</td>
											<%-- <td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.USER_SCORE_LOG_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.USER_SCORE_LOG_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
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
																<a style="cursor:pointer;" onclick="edit('${var.USER_SCORE_LOG_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.USER_SCORE_LOG_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td> --%>
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
			 diag.URL = '<%=basePath%>user_score_log/goAdd.do';
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
					var url = "<%=basePath%>user_score_log/delete.do?USER_SCORE_LOG_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>user_score_log/goEdit.do?USER_SCORE_LOG_ID='+Id;
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
								url: '<%=basePath%>user_score_log/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>user_score_log/excel.do';
		}
	</script>


</body>
</html>