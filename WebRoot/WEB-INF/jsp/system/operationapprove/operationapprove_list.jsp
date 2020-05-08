﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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


<!-- 根据页面需求自己定义的css样式 -->


<style>   
.th{width:150px;overflow:hidden;text-align:center}
.th1{width:90px;overflow:hidden;text-align:center}
.th2{width:75px;overflow:hidden;text-align:center}
.th3{width:135px;overflow:hidden;text-align:center}
.th4{width:110px;overflow:hidden;text-align:center}
 table { table-layout:fixed; word-break: break-all; word-wrap: break-word;} 
.award-name{-o-text-overflow:ellipsis;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;width:100%; //超出部分显示省略号}

</style>

</head>
<body class="no-skin" style="width:100%; background-color:white;">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							
<%-- 						<!-- 检索  -->
						<form action="operationapprove/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="请输入提交人,提交人工号" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="请输入提交人,提交人工号"style="width:200px;"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="SUBMINT_DATE" id="SUBMINT_DATE"  value="" type="text" data-date-format="yyyy-mm-dd " readonly="readonly" style="width:100px;" placeholder="提交日期" title="提交日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="UPDATE_DATE" name="UPDATE_DATE"  value="" type="text" data-date-format="yyyy-mm-dd " readonly="readonly" style="width:100px;" placeholder="更新日期" title="更新日期"/></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="APPROVE_STATE" id="APPROVE_STATE" data-placeholder="局方审批状态" style="vertical-align:top;width: 120px;">
									<option value=""></option> 
									<option value="">—请选择—</option>
									<option value="审批" <c:if test="${var.APPROVE_STATE eq '审批'}">selected</c:if>>审批</option>  
									<option value="审批不通过" <c:if test="${var.APPROVE_STATE eq '审批不通过'}">selected</c:if>>审批不通过</option>
									<option value="已审批" <c:if test="${var.APPROVE_STATE eq '已审批'}">selected</c:if>>已审批</option>
								  	</select>
								</td>
								
								
								
								
								
								
								
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="ASI_APPROVE_STATE" id="ASI_APPROVE_STATE" data-placeholder="亚信审批状态" style="vertical-align:top;width: 120px;">
									<option value=""></option> 
									<option value="">—请选择—</option>
									<option value="审批" <c:if test="${var.ASI_APPROVE_STATE eq '审批'}">selected</c:if>>审批</option>  
									<option value="审批不通过" <c:if test="${var.ASI_APPROVE_STATE eq '审批不通过'}">selected</c:if>>审批不通过</option>
									<option value="已审批" <c:if test="${var.ASI_APPROVE_STATE eq '已审批'}">selected</c:if>>已审批</option>
								  	</select>
								</td>
								
								
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  --> --%>
						
						<form action="operationapprove/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
			<!-- 查询栏及检索 -->
			
			 <fieldset class="widget-box" style="width:62%"> 
							<div class="widget-header">
								<h4 class="smaller">查询检索</h4>
							</div>
							<div class="widget-body">
								<div class="widget-main ">
									<div class="form-group" style="height:8vh;">      <!-- 定义form_group的高度  避免页面错乱 -->                
			                          <label class="col-sm-1 control-label" for="APPROVE_STATE">局方审批状态</label>
			                          <div class="col-sm-3">                         
			                             <select class="chosen-select form-control" name="APPROVE_STATE" id="APPROVE_STATE" data-placeholder="请选择局方审批状态" style="vertical-align:top;" style="width:70%;" >
										<option value=""></option> 
									
									<option value="审批" <c:if test="${var.APPROVE_STATE eq '审批'}">selected</c:if>>审批</option>  
									<option value="审批不通过" <c:if test="${var.APPROVE_STATE eq '审批不通过'}">selected</c:if>>审批不通过</option>
									<option value="已审批" <c:if test="${var.APPROVE_STATE eq '已审批'}">selected</c:if>>已审批</option>
										 </select>	 
			                          </div>
			                          
			                         <label class="col-sm-1 control-label" for="ASI_APPROVE_STATE" style="padding:4px 8px;"style="width:8%">亚信审批状态</label>  
			                            <div class="col-sm-3">	                                
			                             <select class="chosen-select form-control" name="ASI_APPROVE_STATE" id="ASI_APPROVE_STATE" data-placeholder="请选择亚信审批状态" style="vertical-align:top;" style="width:98%;" >
										<option value=""></option>
									<option value="审批" <c:if test="${var.ASI_APPROVE_STATE eq '审批'}">selected</c:if>>审批</option>  
									<option value="审批不通过" <c:if test="${var.ASI_APPROVE_STATE eq '审批不通过'}">selected</c:if>>审批不通过</option>
									<option value="已审批" <c:if test="${var.ASI_APPROVE_STATE eq '已审批'}">selected</c:if>>已审批</option>
										 </select>
										 
										 
										 
			                          </div>
			                          
			                          <label class="col-sm-1 control-label" for="SUBMITTER">提交人</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="SUBMITTER" name="SUBMITTER" value="${pd.SUBMITTER}" type="text" placeholder="请输入提交人"/>
			                          </div>
			                         
			                       </div>
									<div class="form-group">
									  <label class="col-sm-1 control-label" for="SUBMITID">提交人ID</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="SUBMITID" name="SUBMITID" value="${pd.SUBMITID}"  type="text" placeholder="请输入提交人id"/>
			                          </div>
			                          <label class="col-sm-1 control-label" for="SUBMINT_DATE">提交日期</label>
			                          <div class="col-sm-3">
 										<div class="input-group">
											<input class="form-control date-picker" id="SUBMINT_DATE" name="SUBMINT_DATE" value="${pd.SUBMINT_DATE}"  type="text" data-date-format="yyyy-mm-dd">
											<span class="input-group-addon">
												<i class="fa fa-calendar bigger-110"></i>
											</span>
										</div>
			                          </div>
			                           <label class="col-sm-1 control-label" for="UPDATE_DATE">更新日期</label>
			                          <div class="col-sm-3">
			                            <div class="input-group">
											<input class="form-control date-picker" id="UPDATE_DATE" name="UPDATE_DATE" value="${pd.UPDATE_DATE}"  type="text" data-date-format="yyyy-mm-dd">
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
			                       </div>
								</div>
							</div>
						</fieldset> 
	
						
						<!-- 检索  -->
			
						
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<!--  <th class="center">流水号</th>-->
									<th class="th2">提交人ID</th>
									<th class="th2">提交人</th>
									<th class="th1" aligin="center">提交时间</th>
									<th class="th2">更新人</th>
									<th class="th1" aligin="center">更新时间</th>
									<th class="th" aligin="center">问题描述</th>
									<th class="th1" aligin="center" >解决方案</th>
									<th class="th1" aligin="center">风险评估</th>
									<th class="th">更新内容</th>
									<th class="th3" aligin="center">更新步骤</th>
									<th class="th3" aligin="center">验证方法</th>
									<th class="th2">局方主管</th>
									<th class="th2">局方经理</th>
									<th class="th4">局方审批状态</th>
									<th class="th4">局方审批意见</th>
									<th class="th2">亚信主管</th>
									<th class="th2">亚信经理</th>
									<th class="th4">亚信审批状态</th>
									<th class="th4">亚信审批意见</th>
									<th class="th2">操作</th>
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
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.APPROVE_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 50px;">${vs.index+1}</td>
											  <!--  <td class='center'>${var.APPROVE_ID}</td>  -->
											<%-- <td class='center'>${var.SUBMITID}</td> --%>
											 <td class='center'>	<a href = "javascript:;" onclick="look('${var.APPROVE_ID}');">${var.SUBMITID}</a></td>
											<td class='center'>${var.SUBMITTER}</td>
											<td class='center'>${var.SUBMINT_DATE}</td>
											<td class='center'>${var.UPDATE_PEOPLE}</td>
											<td class='center'>${var.UPDATE_DATE}</td>
											<td class='center'>${var.QUES_DESCRIBE}</td>
											<td  class='award-name'>${var.SOLUTION}</td>
											<td class='center'>${var.RISK_ASSESS}</td>
											<td class='award-name'>${var.UPDATE_CONTENT}</td>
											<td class='award-name'>${var.UPDATE_STEP}</td>
											<td class='award-name'>${var.TEST_METHOD}</td>
											<td class='center'>${var.OFFICE_SUPERVISOR}</td>
											<td class='center'>${var.OFFICE_MANAGER}</td>
											<td class='center'>${var.APPROVE_STATE}</td>
											<td class='center'>${var.APPROVE_SUGGES}</td>
											<td class='center'>${var.ASI_OFFICE_SUPERVISOR}</td>
											<td class='center'>${var.ASI_OFFICE_MANAGER}</td>
											<td class='center'>${var.ASI_APPROVE_STATE}</td>
											<td class='center'>${var.ASI_APPROVE_SUGGES}</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.APPROVE_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.APPROVE_ID}');">
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
																<a style="cursor:pointer;" onclick="edit('${var.APPROVE_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.APPROVE_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
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
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-sm btn-success" onclick="add();">新增</a>   
									</c:if>
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
			 diag.URL = '<%=basePath%>operationapprove/goAdd.do';
			 diag.Width = 600;
			 diag.Height = 480;
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
					var url = "<%=basePath%>operationapprove/delete.do?APPROVE_ID="+Id+"&tm="+new Date().getTime(); //修改处
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
			 diag.URL = '<%=basePath%>operationapprove/goEdit.do?APPROVE_ID='+Id;   
			 diag.Width = 600;
			 diag.Height =480;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		
 		//点击工号跳转到查看详细信息的页面
	  function look(Id){
	        top.jzts();
	        var diag = new top.Dialog();
	        diag.Drag=true;
	        diag.Title ="详细信息";
	        diag.URL = '<%=basePath%>operationapprove/golook.do?APPROVE_ID='+Id;
	        diag.Width = 600;
	        diag.Height = 480;

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
								url: '<%=basePath%>operationapprove/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>operationapprove/excel.do';
		}
	</script>


</body>
</html>