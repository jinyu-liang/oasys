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
<script type="text/javascript" src="static/js/myjs/head.js"></script>
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link rel="stylesheet" href="static/html_UI/dist/css/ace.min.css" />
<style type="text/css">
.popover {max-width: 750px;}
</style>
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
						<form action="reqm/dolist.do" method="post" name="Form" id="Form">
						
						<!-- 检索  -->
						<fieldset class="widget-box">
							<div class="widget-header">
								<h4 class="smaller">查询条件</h4>
							</div>
							<div class="widget-body">
								<div class="widget-main padding-8 no-padding-left ">

								   <div class="form-group">
			                          
			                          <label class="col-sm-1 control-label" for="REQ_SDPID">需求编号:</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="REQ_SDPID" name="REQ_ID" value="${pd.REQ_ID}" type="text" placeholder="请输入需求编号"/>
			                          </div>
			                          <label class="col-sm-1 control-label " for="REQ_TITLE">需求名称:</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="REQ_TITLE" name="REQ_TITLE" value="${pd.REQ_TITLE}" type="text" placeholder="请输入需求名称"/>
			                          </div>
			                          <label class="col-sm-1 control-label" for="STAFF_NAME">需求开发人:</label>
			                          <div class="col-sm-3">
			                            

										<select class="chosen-select form-control" name="STAFF_NAME" id="STAFF_NAME" data-placeholder="请选择" style="vertical-align:top;width: 98%;">
											<option value=""></option>
											<c:forEach items="${userlist}" var="var" varStatus="vs">
											<option value="${var.NAME }" <c:if test="${var.NAME == pd.STAFF_NAME }">selected</c:if>>${var.NAME } </option>
											</c:forEach>
									  	</select>
			                          </div>
			                       </div>

									<div class="form-group">
			                          <label class="col-sm-1 control-label" for="START_DATE">开始时间:</label>
			                          <div class="col-sm-3">
 										<div class="input-group">
											<input class="form-control date-picker" id="START_DATE" name="START_DATE" value="${pd.START_DATE}"  type="text" data-date-format="yyyy-mm-dd">
											<span class="input-group-addon">
												<i class="fa fa-calendar bigger-110"></i>
											</span>
										</div>
			                          </div>
			                           <label class="col-sm-1 control-label" for="END_DATE">结束时间:</label>
			                          <div class="col-sm-3">
			                            <div class="input-group">
											<input class="form-control date-picker" id="END_DATE" name="END_DATE" value="${pd.END_DATE}"  type="text" data-date-format="yyyy-mm-dd">
											<span class="input-group-addon">
												<i class="fa fa-calendar bigger-110"></i>
											</span>
										</div>
			                          </div>
			                          
			                          <label class="col-sm-1 control-label" for="P_VALUE">需求类别:</label>
			                          <div class="col-sm-3">
			                             <select class="chosen-select form-control" name="REQ_TYPE" id="REQ_TYPE" data-placeholder="请选择类型" style="vertical-align:top;" style="width:98%;" >
											<option value=""></option>
											<c:forEach items="${reqstatrolelist}" var="var">
												<option value="${var.P_VALUE}"  <c:if test="${var.P_VALUE == pd.REQ_TYPE }">selected</c:if> >${var.P_NAME }</option>
											</c:forEach>
										 </select>
			                          </div>
			                       </div>

									<div class="form-group">
			                          <label class="col-sm-1 control-label" for="all">需求状态:</label>
			                          <div class="col-sm-10">
											<div class="checkbox">
												<c:forEach items="${reqstatlist}" var="var">	
													<label>												
														<input name="sches" type="checkbox" class="ace" value="${var.P_VALUE }" <c:if test="${var.RSRV_STR1 == 1 }">checked</c:if> />
														<span class="lbl" title="${var.P_DES}"  >${var.P_NAME }</span>
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
						<!-- 检索  -->
					
					
<!-- 				
<div class="row">
	<div class="col-xs-12">
		<h3 class="header smaller lighter blue">jQuery dataTables</h3>

		<div class="clearfix">
			<div class="pull-right tableTools-container"></div>
		</div>
		<div class="table-header">
			Results for "Latest Registered Domains"
		</div>
		<div>
			<table id="dynamic-table" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>

						<th class="center" style="width:3%;">序号</th>
						<th class="center hidden-480" style="width:8%;">需求编号</th>
						<th class="center" style="width:8%;">需求标题</th>
						<th class="center" style="width:8%;"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>需求开始时间</th>
						<th class="center" style="width:8%;"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>开发完成时间</th>
						<th class="center" style="width:8%;"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>上线时间</th>
						<th class="center" style="width:8%;">需求状态</th>
						<th class="center" style="width:8%;">移动责任人</th>
						<th class="center" style="width:8%;">需求开发人</th>
						<th class="center" style="width:8%;">需求类别</th>
					</tr>
				</thead>

				<tbody>
							<c:choose>
								<c:when test="${not empty reqlist}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${reqlist}" var="var" varStatus="vs">
										<tr>
											
											<td class='center'>${vs.index+1}</td>
											<td class='center'>${var.REQ_ID}</td>
											<td class="hidden-480" title="${var.REQ_TITLE} 
${var.REQ_NOTE} " style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${var.REQ_TITLE}</td>
											<td class='center'>${var.ACCEPT_DATE}</td>
											<td class='center' >${var.DEVELOP_FINISH_DATE}</td>
											<td class='center'>${var.ONLINE_DATE}</td>
											<td class='center'>
											<c:forEach items="${reqstatlist}" var="rvar">
												<c:if test="${rvar.P_VALUE == var.REQ_STATE }">${rvar.P_NAME }</c:if>
											</c:forEach>
											</td>
											<td class='center'>${var.MOBOLE_STAFF}</td>
											<td class='center'>${var.STAFF_NAME}</td>
											<td class='center'>
											<c:forEach items="${reqstatrolelist}" var="rvar">
												<c:if test="${rvar.P_VALUE == var.REQ_TYPE }">${rvar.P_NAME }</c:if>
											</c:forEach>
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
		</div>
	</div>
</div>
 -->	


					
					    <h4 class="header green">查询结果</h4>
						<table id="simple-table" class="table table-striped table-bordered table-hover">	
							<thead>
								<tr>
									<th class="center" style="width:5%;">序号</th>
									<th class="center" style="width:8%;">需求编号</th>
									<th class="center" style="width:20%;">需求标题</th>
									<th class="center" >需求开始时间</th>
									<th class="center" >开发完成时间</th>
									<th class="center" >上线时间</th>
									<th class="center" >需求状态</th>
									<th class="center" >移动责任人</th>
									<th class="center" >需求开发人</th>
									<th class="center" >需求类别</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty reqlist}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${reqlist}" var="var" varStatus="vs">
										<tr >
											<td class='center'>${vs.index+1}</td>
											
											<td class='center'><a href="javascript:void(0);" class="RemarkInfo" index="${var.REQ_SDPID}" onclick="RemarkToggle('${var.REQ_SDPID}',this)">${var.REQ_ID}</a></td>
											
											<td class='left '><span class="popover-success" data-rel="popover" data-placement="right" 
												title="${var.REQ_TITLE}" data-content="${var.REQ_NOTE}">${var.REQ_TITLE}</span></td>
											<td class="center ">${var.ACCEPT_DATE}</td>
											<td class='center ${var.redOrNotdevelopCss}'>${var.DEVELOP_FINISH_DATE}</td>
											<td class='center ${var.redOrNotonlineCss}'>${var.ONLINE_DATE}</td>
											<td class='center '>
											<c:choose>
												   <c:when test="${var.REQ_STATE == '09'}"><span class="label label-lg label-danger arrowed arrowed-right"></c:when>
											       <c:when test="${var.REQ_STATE == '10'}"><span class="label label-lg label-primary arrowed arrowed-right"></c:when>
											       <c:when test="${var.REQ_STATE == '11' || var.REQ_STATE == '12'|| var.REQ_STATE == '13'}"><span class="label label-lg label-grey arrowed arrowed-right"></c:when>
											       <c:otherwise><span class="label label-lg label-success arrowed arrowed-right"></c:otherwise>
											</c:choose>
											<c:forEach items="${reqstatlist}" var="rvar">
												<c:if test="${rvar.P_VALUE == var.REQ_STATE }">${rvar.P_NAME }</c:if>
											</c:forEach>
											</span>
											</td>
											<td class='center'>${var.MOBOLE_STAFF}</td>
											<td class='center'>${var.STAFF_NAME}</td>
											<td class='center'>
											<c:forEach items="${reqstatrolelist}" var="rvar">
												<c:if test="${rvar.P_VALUE == var.REQ_TYPE }">${rvar.P_NAME }</c:if>
											</c:forEach>
											</td>
											
											 <td class="center">
												<div class="hidden-sm hidden-xs btn-group">
													<button class="btn btn-xs btn-success tooltip-success" data-rel="tooltip" data-placement="bottom" title="主需求信息" onclick="siMenu('reqedit','reqedit','主需求信息','reqm/editReqInfo.do?REQ_ID=${var.REQ_ID}')">
														<i class="ace-icon fa fa-search-plus bigger-120"></i>
													</button>

													<button class="btn btn-xs btn-info tooltip-info" data-rel="tooltip" data-placement="bottom" title="子需求管理" onclick="siMenu('reqplus','reqplus','子需求管理','reqplus/pluslist.do?REQ_SDPID=${var.REQ_SDPID}')">
														<i class="ace-icon fa fa-plus-square-o bigger-120"></i>
													</button>
													<c:if test="${QX.add != 1 }">
														<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限新增子需求"></i></span>
													</c:if>
												    <c:if test="${QX.add == 1 }">
														<button class="btn btn-xs btn-warning tooltip-warning" data-rel="tooltip" data-placement="bottom" title="新增子需求" onclick="siMenu('reqplus_edit','reqplus_edit','新增子需求','reqplus/editReqPlusInfo.do?REQ_SDPID=${var.REQ_SDPID}')">
															<i class="ace-icon fa fa-external-link bigger-120"></i>
														</button>
													</c:if>
												</div>
										
												<!--  隐藏展示
												<div class="hidden-md btn-group hidden-lg hidden-md">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
	
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<li>
																<a class="tooltip-info" data-rel="tooltip" title="主需求信息" onclick="siMenu('reqedit','reqedit','主需求信息','reqm/editReqInfo.do?REQ_ID=${var.REQ_ID}')">
																	<span class="blue">
																		<i class="ace-icon fa fa-search-plus bigger-120"></i>
																	</span>
																</a>
															</li>
	
															<li>
																<a class="tooltip-success" data-rel="tooltip" title="子需求管理" onclick="siMenu('reqplus','reqplus','子需求管理','reqplus/pluslist.do?REQ_SDPID=${var.REQ_SDPID}')">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
	
															
														</ul>
													</div>
												</div>
												 -->
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
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-sm btn-success" onclick="siMenu('reqedit','reqedit','主需求信息','reqm/editReqInfo.do?REQ_STATE=02')">新增</a>
									</c:if>
									<%--
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
	
	
	
	<!--
		<script src="static/ace/js/dataTables/jquery.dataTables.js"></script>
		<script src="static/ace/js/dataTables/jquery.dataTables.bootstrap.js"></script>
		<script src="static/ace/js/dataTables/extensions/TableTools/js/dataTables.tableTools.js"></script>
		<script src="static/ace/js/dataTables/extensions/ColVis/js/dataTables.colVis.js"></script>


		<script src="static/ace/js/ace/elements.scroller.js"></script>
		<script src="static/ace/js/ace/elements.colorpicker.js"></script>
		<script src="static/ace/js/ace/elements.fileinput.js"></script>
		<script src="static/ace/js/ace/elements.typeahead.js"></script>
		<script src="static/ace/js/ace/elements.wysiwyg.js"></script>
		<script src="static/ace/js/ace/elements.spinner.js"></script>
		<script src="static/ace/js/ace/elements.treeview.js"></script>
		<script src="static/ace/js/ace/elements.wizard.js"></script>
		<script src="static/ace/js/ace/elements.aside.js"></script>
		<script src="static/ace/js/ace/ace.js"></script>
		<script src="static/ace/js/ace/ace.ajax-content.js"></script>
		<script src="static/ace/js/ace/ace.touch-drag.js"></script>
		<script src="static/ace/js/ace/ace.sidebar.js"></script>
		<script src="static/ace/js/ace/ace.sidebar-scroll-1.js"></script>
		<script src="static/ace/js/ace/ace.submenu-hover.js"></script>
		<script src="static/ace/js/ace/ace.widget-box.js"></script>
		<script src="static/ace/js/ace/ace.settings.js"></script>
		<script src="static/ace/js/ace/ace.settings-rtl.js"></script>
		<script src="static/ace/js/ace/ace.settings-skin.js"></script>
		<script src="static/ace/js/ace/ace.widget-on-reload.js"></script>
		<script src="static/ace/js/ace/ace.searchbox-autocomplete.js"></script>
 -->	
	<script type="text/javascript">
	
	var aid="";//全局参数，传递ID
	function RemarkToggle(a,obj) {
	    aid = a;
	    RemarkStart(a);//初始化popover
	    $(obj).popover('show');
	};
	function RemarkStart(a) {
	//初始化popover
	    $(".RemarkInfo[index='"+a+"']").popover({
	        trigger: 'click|focus',
	        placement: 'top',
	        title: '子需求信息',
	        html: 'true',
	        container: 'body',
	        content: RemarkMethod(a)
	    });

	};
	//获取popover中的内容
	
	function RemarkMethod(obj){   
		var html='<table id="simple-table" class="table table-striped table-bordered table-hover"><tbody><thead><tr><th class="center" >开发者</th><th class="center" >子需求状态</th><th class="center" >工作量</th></tr></thead>';
		$.ajax({
			  type : "POST",
			  async : false,            //同步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			  url: 'reqm/plus.do?REQ_SDPID='+obj,
			  dataType:'json',
			  cache: false,
			  success : function(data) {
			      //请求成功时执行该函数内容，result即为服务器返回的json对象
				  if("success" == data.msgcode){
					  if(data.list.length>0){
						  for(var i=0;i<data.list.length;i++){
							  html=html+'<tr><td class="center">'+data.list[i].CODE_STAFF+'</td><td class="center">'+data.list[i].REQ_STATE+'</td><td class="center">'+data.list[i].WORKLOAD1+'</td></tr>';
						  }
					  }else{
						  html=html+'<tr><td colspan="3" class="center">无子需求</td></tr>';
					  }
					  
			      } else{
			    	  html=html+'<tr><td colspan="3" class="center">无子需求</td></tr>';
			      }   
			  },
			  error : function(errorMsg) {
				  html=html+'<tr><td colspan="3" class="center">无子需求</td></tr>';
			  }
		});
		html=html+"</tbody></table>";
		return html;
	};
	
	
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		$(function() {
			
			$("input[name='all']").click(function(){
				var flag = this.checked;
				$("input[name='sches']").each(function(){
					this.checked = flag;
				});
			});
			
			$('[data-rel=tooltip]').tooltip();
			$('[data-rel=popover]').popover({html:true});
		
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
		
		
		
		
		
		
		
	</script>


</body>
</html>