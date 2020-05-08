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
<link rel="stylesheet" href="static/ace/css/bootstrap-datetimepicker.css" />
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
							
						<!-- 检索  -->
						<form action="activetask/search.do" method="post" name="Form" id="Form">
						<table style="margin-top: 5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="startdata" id="startdata" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:140px;" placeholder="开始时间" title="开始时间" value="${pd.startdata}"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="enddata" id="enddata" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:140px;" placeholder="结束时间" title="结束时间" value="${pd.enddata}"/></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="type" id="type" data-placeholder="任务类型" style="vertical-align:top;width: 250px;">
									<option value=""></option>
									<option value="">全部</option>
									<option value="绩效工时(不包括值班,节假日加班)" <c:if test="${pd.type eq '绩效工时(不包括值班,节假日加班)'}">selected</c:if>>绩效工时(不包括值班,节假日加班)</option>
									<option value="绩效工时(维护工时)" <c:if test="${pd.type eq '绩效工时(维护工时)'}">selected</c:if>>绩效工时(维护工时)</option>
									<option value="绩效工时(运维组_转发的工单池)" <c:if test="${pd.type eq '绩效工时(运维组_转发的工单池)'}">selected</c:if>>绩效工时(运维组_转发的工单池)</option>
									<option value="绩效工时(运维组_信息卡)" <c:if test="${pd.type eq '绩效工时(运维组_信息卡)'}">selected</c:if>>绩效工时(运维组_信息卡)</option>
									<option value="绩效工时(运维组_其他)" <c:if test="${pd.type eq '绩效工时(运维组_其他)'}">selected</c:if>>绩效工时(运维组_其他)</option>
									<option value="项目工时" <c:if test="${pd.type eq '项目工时'}">selected</c:if>>项目工时</option>
								  	</select>
								</td>
								<td style="padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;table-layout: fixed;">		
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">任务名称</th>
									<th class="center">任务类型</th>
									<th class="center">实际开始时间</th>
									<th class="center">实际工作量</th>
									<th class="center">员工</th>
									<th class="center">更新时间</th>
									<th class="center">备注</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.ACTIVETASK_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='left' style="width: 200px;"><a href = "javascript:;" onclick="detile('${var.ACTIVETASK_ID}');">${var.TASK_NAME}</a></td>
											<td class='center'>${var.TASK_TYPE}</td>
											<td style="text-align: right;width: 90px;">${var.START_DATE}</td>
											<td class='center'>${var.WORK_LOAD}</td>
											<td class='center' style="width: 60px;">${var.NAME}</td>
<%-- 										<td class='center' style="width: 60px;">${var.IT_NAME}</td> --%>
											<td style="text-align: right;width: 90px;">${var.UPDATE_TIME}</td>
											<td class='left' title='${var.REMARK}' style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" >${var.REMARK}</td>
											<td class="center" style="width: 80px;">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.ACTIVETASK_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.ACTIVETASK_ID}');">
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
																<a style="cursor:pointer;" onclick="edit('${var.ACTIVETASK_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.ACTIVETASK_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									
									</c:forEach>
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
								<td style="vertical-align:top;">
									<a class="btn btn-sm btn-success" onclick="add();">新增</a>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-sm btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
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
	<!-- 加减框 -->
	<script src="static/html_UI/assets/js/fuelux/fuelux.spinner.js"></script>
	<script src="static/html_UI/assets/js/ace/elements.spinner.js"></script>
    <!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<script src="static/ace/js/date-time/moment.js"></script>
	<script src="static/ace/js/date-time/bootstrap-datetimepicker.js"></script>
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
			
/* 			//当前时间
			var now = new Date();
			//当前年份
			var nowYear = now.getFullYear();
			//当前月份
			var nowMonth = now.getMonth()+1;
			//当前毫秒
			var nowTime = now.getTime();
			//本年第一天日期
			var first = new Date(nowYear+"/"+"1/1");
			//本年第一天是周几
			var firstDay = first.getDay();
			//判断补齐第一周
			if (firstDay>0) {
				var firstTime = first.getTime()+((firstDay-1)*24*60*60*1000);
			}
			else if (firstDay=0) {
				var firstTime = first.getTime()+(6*24*60*60*1000);
			}
			//当前周数
			var nowWeek = Math.ceil(((((((nowTime-firstTime)/1000)/60)/60)/24)/7)); */
			//加减框
			$('#spinner2').ace_spinner({
				value:"${pd.week}",
				min:0,
				max:53,
				step:1, 
				touch_spinner: true, 
				icon_up:'ace-icon fa fa-caret-up bigger-110', 
				icon_down:'ace-icon fa fa-caret-down bigger-110'
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
			 diag.URL = '<%=basePath%>activetask/goAdd.do';
			 diag.Width = 600;
			 diag.Height = 500;
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
					var url = "<%=basePath%>activetask/delete.do?ACTIVETASK_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if('${page.currentPage}' == '0'){
							 top.jzts();
							 setTimeout("self.location=self.location",0);
						 }else{
							 nextPage(${page.currentPage});
						 }
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
			 diag.URL = '<%=basePath%>activetask/goEdit.do?ACTIVETASK_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",0);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//详情
	    function detile(Id){
	        top.jzts();
	        var diag = new top.Dialog();
	        diag.Drag=true;
	        diag.Title ="详细信息";
	        diag.URL = '<%=basePath%>activetask/godetile.do?ACTIVETASK_ID='+Id;
	        diag.Width = 600;
	        diag.Height = 465;

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
								url: '<%=basePath%>activetask/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>activetask/excel.do';
		}
	</script>


</body>
</html>