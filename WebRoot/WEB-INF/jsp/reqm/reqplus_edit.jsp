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

<link rel="stylesheet" href="static/ace/css/jquery-ui.css" />
<link rel="stylesheet" href="static/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
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
						<form action="reqplus/${msg }.do" method="post" name="Form" id="Form" class="form-horizontal">
							


						<div class="tabbable">
							<ul class="nav nav-tabs padding-16">
								<li class="active">
									<a data-toggle="tab" href="#edit-basic">
										<i class="green ace-icon fa fa-pencil-square-o bigger-125"></i>
										子需求信息
										
									</a>
								</li>
								
							</ul>

							<div class="tab-content profile-edit-tab-content">
								<div id="edit-basic" class="tab-pane in active">
										<h4 class="header blue bolder smaller">General</h4>
										<div class="form-group">
											<label class="col-sm-2 control-label no-padding-right" for="REQ_SDPID"><i class=" fa fa-asterisk light-red"></i>SDP需求编号:</label>
											<div class="col-sm-3">
													<input type="text" id="REQ_SDPID" name="REQ_SDPID" placeholder="SDP需求编号" value="${pd.REQ_SDPID }" class="form-control"/>
											</div>

											<label class="col-sm-2 control-label no-padding-right" for="REQ_TITLE"><i class="menu-icon fa fa-asterisk light-red"></i>需求名称:</label>
											<div class="col-sm-3">
													<input type="text" id="REQ_TITLE" name="REQ_TITLE" placeholder="需求名称" value="${pd.REQ_TITLE }" class="form-control"/>
											</div>

										</div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label no-padding-right" for="REQ_NOTE"><i class="menu-icon fa fa-asterisk light-red"></i>需求描述:</label>
											<div class="col-sm-8">
													<textarea rows="10" id="REQ_NOTE" name="REQ_NOTE" placeholder="需求描述" class="form-control">${pd.REQ_NOTE}</textarea>
											</div>
										</div>
										
										<h4 class="header blue bolder smaller">Detail</h4>
										
										<div class="form-group">

											<label class="col-sm-2 control-label no-padding-right" for="CODE_STAFF"><i class="menu-icon fa fa-asterisk light-red"></i>需求开发人:</label>
											<div class="col-sm-3">
											
													<select class="chosen-select form-control" name="CODE_STAFF" id="CODE_STAFF" data-placeholder="请选择" placeholder="需求开发人" style="vertical-align:top;width: 98%;">
														<option value=""></option>
														<c:forEach items="${userlist}" var="var" varStatus="vs">
														<option value="${var.NAME }" <c:if test="${var.NAME == pd.CODE_STAFF }">selected</c:if>>${var.NAME } </option>
														</c:forEach>
												  	</select>
											</div>
											

											<label class="col-sm-2 control-label no-padding-right" for="REQ_STATE_PLUS"><i class=" fa fa-asterisk light-red"></i>需求状态:</label>
											<div class="col-sm-3"  >
													<select class="chosen-select form-control" name="REQ_STATE_PLUS" id="REQ_STATE_PLUS" placeholder="需求状态" data-placeholder="请选择类型"  <c:if test="${pd.REQ_STATE_PLUS != null }">disabled="true"</c:if> >
														<option value=""></option>
														<c:forEach items="${reqstatlist}" var="var">
															<option value="${var.P_VALUE}"  <c:if test="${var.P_VALUE == pd.REQ_STATE_PLUS }">selected</c:if> >${var.P_NAME }</option>
														</c:forEach>
													 </select>
											</div>		
										</div>
										

										
										<div class="form-group">

											<label class="col-sm-2 control-label no-padding-right" for="START_DATE"><i class="menu-icon fa fa-asterisk light-red"></i>计划开始时间:</label>
											<div class="col-sm-3">
													<div class="input-group">
														<input class="form-control date-picker" id="START_DATE" name="START_DATE" placeholder="计划开始时间" value="${pd.START_DATE}"  type="text" data-date-format="yyyy-mm-dd">
														<span class="input-group-addon">
															<i class="fa fa-calendar bigger-110"></i>
														</span>
													</div>
											</div>

											<label class="col-sm-2 control-label no-padding-right" for="FINISH_DATE"><i class="menu-icon fa fa-asterisk light-red"></i>计划完成时间:</label>
											<div class="col-sm-3">
													<div class="input-group">
														<input class="form-control date-picker" id="FINISH_DATE" name="FINISH_DATE" value="${pd.FINISH_DATE}"  placeholder="计划完成时间" type="text" data-date-format="yyyy-mm-dd">
														<span class="input-group-addon">
															<i class="fa fa-calendar bigger-110"></i>
														</span>
													</div>
											</div>
																				
										</div>
										
										<div class="form-group">	
											<label class="col-sm-2 control-label no-padding-right" for="WORKLOAD"><i class=" fa fa-asterisk light-red"></i>工作量(天):</label>
											<div class="col-sm-3">
													<input type="text" id="WORKLOAD" name="WORKLOAD" placeholder="工作量(天)" value="${pd.WORKLOAD }" class="form-control"  
															/>
											</div>
											
											<c:if test="${pd.TONGJI_STATUS == '1' || pd.TONGJI_STATUS == '2'}">
											<label class="col-sm-2 control-label no-padding-right" for="TONGJI"><i class=" fa fa-asterisk light-red"></i>工作量比例(%):</label>
											<div class="col-sm-3">
													<input type="text" id="TONGJI" name="TONGJI" placeholder="工作量比例" value="${pd.TONGJI }" class="form-control"
															<c:if test="${QX.edit != 1 }">disabled</c:if>/>

													<label>
														<input name="TONGJI_TAG" id="TONGJI_TAG" type="radio" class="ace" value="Crm" <c:if test="${pd.TONGJI_TAG == 'Crm' }">checked="true"</c:if> <c:if test="${QX.edit != 1 }">disabled</c:if>/>
														<span class="lbl"> Crm</span>
													</label>

													<label>
														<input name="TONGJI_TAG" id="TONGJI_TAG" type="radio" class="ace" value="Billing" <c:if test="${pd.TONGJI_TAG == 'Billing' }">checked="true"</c:if>    <c:if test="${QX.edit != 1 }">disabled</c:if> />
														<span class="lbl"> Billing</span>
													</label>
											</div>
											</c:if>
										</div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label no-padding-right" for="REQPLUS_NOTE"><i class="menu-icon fa fa-asterisk light-red"></i>子需求开发说明:</label>
											<div class="col-sm-8">
													<textarea rows="3" id="REQPLUS_NOTE" name="REQPLUS_NOTE" placeholder="子需求开发说明" class="form-control">${pd.REQPLUS_NOTE}</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label no-padding-right" for="FILE_LIST"><i class="menu-icon fa fa-asterisk light-red"></i>文件修改列表:</label>
											<div class="col-sm-8">
													<textarea rows="7" id="FILE_LIST" name="FILE_LIST" placeholder="文件修改列表(code、sql、procedure)" class="form-control">${pd.FILE_LIST}</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label no-padding-right" for="REMARK"><i class=""></i>备注:</label>
											<div class="col-sm-8">
													<input type="text" id="REMARK" name="REMARK"  placeholder="备注" value="${pd.REMARK}" class="form-control"/>
											</div>
										</div>
										
								</div>
							
							
							
							</div>
						</div>

						<div class="clearfix form-actions center">
						<input type="hidden" id="REQ_SDPIDPLUS" name="REQ_SDPIDPLUS" value="${pd.REQ_SDPIDPLUS}" />
						<input type="hidden" id="TONGJIMAX" name="TONGJIMAX" value="${pd.TONGJIMAX}" />
						<input type="hidden" id="TONGJI_STATUS" name="TONGJI_STATUS" value="${pd.TONGJI_STATUS}" />
							<c:if test="${QX.add == 1 }">
								<c:if test="${empty pd.REQ_SDPIDPLUS}">
									<button class="btn  btn-success" type="button" onclick="save()">
										<i class="ace-icon fa fa-floppy-o  bigger-110"></i>
										新增子需求
									</button>
								</c:if>
								<c:if test="${not empty pd.REQ_SDPIDPLUS}">
									<button id="del" class="btn btn-danger" type="button">
										<i class="ace-icon fa fa-times-circle-o  bigger-110"></i>
										删除子需求
									</button>
								</c:if>
							</c:if>
							
							
							
							
							<c:if test="${not empty pd.REQ_SDPIDPLUS}">		
							    &nbsp; &nbsp;
								<button class="btn btn-info" type="button" onclick='edit($("#REQ_STATE_PLUS").val())'>
									<i class="ace-icon fa fa-pencil-square-o bigger-110"></i>
									更新子需求
								</button>
								
									<c:if test="${pd.REQ_STATE_PLUS == '07' }">
										&nbsp; &nbsp;
										<button class="btn btn-primary" type="button" onclick='edit("08")'>
											<i class="ace-icon fa fa-arrow-right bigger-110"></i>
											测试子需求
										</button>
									</c:if>
									<c:if test="${pd.REQ_STATE_PLUS == '08' }">
										&nbsp; &nbsp;
										<button class="btn btn-primary" type="button" onclick='edit("09")'>
											<i class="ace-icon fa fa-arrow-right bigger-110"></i>
											上线子需求
										</button>
									</c:if>
	 								<c:if test="${pd.REQ_STATE_PLUS == '09' }">
										&nbsp; &nbsp;
										<button class="btn btn-success" type="button" onclick='edit("10")'>
											<i class="ace-icon fa fa-times-circle-o  bigger-110"></i>
											关闭子需求
										</button>
									</c:if>
									
							</c:if>
							
						</div>
												
						
						<!-- 隐藏屏蔽框 -->
								<div id="dialog-confirm" class="hide">
									<div class="alert alert-info bigger-110">
										${pd.REQ_TITLE}
									</div>
		
									<div class="space-6"></div>
		
									<p class="bigger-110 bolder center grey">
										<i class="ace-icon fa fa-hand-o-right blue bigger-120"></i>
										Are you sure?
									</p>
								</div>
								
								<div id="dialog-message" class="hide">
									<strong id="msg"></strong>
								</div>
										
								<div class="hide" id="alert_msg">
									<button type="button" class="close" data-dismiss="alert">
										<i class="ace-icon fa fa-times"></i>
									</button>

									<strong id="msg"></strong>
									<br />
								</div>
						<!-- 隐藏屏蔽框 -->
										
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
	
		<script src="static/ace/js/fuelux/fuelux.spinner.js"></script>
	<script src="static/ace/js/ace/ace.js"></script>
	<script src="static/ace/js/ace/elements.spinner.js"></script>
	
	<script src="static/ace/js/jquery-ui.js"></script>
	<script src="static/ace/js/jquery.ui.touch-punch.js"></script>
	
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
		$(function() {
		
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true,
				format: "yyyy-mm-dd"//设置格式
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
			
			
			$('#WORKLOAD').ace_spinner({value:0,min:0,max:1000,step:1, btn_up_class:'btn-info' , btn_down_class:'btn-info'})
			.closest('.ace-spinner').on('changed.fu.spinbox', function(){
			}); 
			var tongjimax=$('#TONGJIMAX').val();
			if(null == tongjimax || tongjimax==""){tongjimax="100";}
			$('#TONGJI').ace_spinner({value:0,min:0,max:tongjimax,step:5, on_sides: true, icon_up:'ace-icon fa fa-plus bigger-110', icon_down:'ace-icon fa fa-minus bigger-110', btn_up_class:'btn-success' , btn_down_class:'btn-danger'});
			
		});

		function chkelement(obj){
			if($.trim(obj.val())=="" || $.trim(obj.val())=="0"){
				obj.tips({
					side:3,
		            msg:obj.attr("placeholder")+"不能为空",
		            bg:'#AE81FF',
		            time:2
		        });
				obj.focus();
				return false;
			}else{
				return true;
			}
		}
		//保存
		function save(){
			
			var c = chkelement($("#CODE_STAFF")) && chkelement($("#START_DATE")) && chkelement($("#FINISH_DATE")) ;
			if(c){
				var status = $("#TONGJI_STATUS").val();
				if(status == 1){
					chkelement($("#TONGJI"));
					var val=$('input:radio[name="TONGJI_TAG"]:checked').val();
		            if(val==null){
		            	$("#TONGJI_TAG").tips({
							side:3,
				            msg:"请选择经营单元",
				            bg:'#AE81FF',
				            time:2
				        });
		            	$("#TONGJI_TAG").focus();
						return false;
		            }
				}
				$('#Form').attr('action','reqplus/save.do');
				$('#REQ_STATE_PLUS').attr("disabled",false);
				$('#REQ_STATE_PLUS').removeAttr("disabled");
				$('#REQ_STATE_PLUS').val("07");
				top.jzts();
				$("#Form").submit();
			}
		}
		
		//更新
		function edit(n){
			var c = chkelement($("#CODE_STAFF")) && chkelement($("#START_DATE")) && chkelement($("#FINISH_DATE"))  && chkelement($("#REQPLUS_NOTE")) && chkelement($("#FILE_LIST")) ;
			if(c){
				if(n == "10"){
					if(!chkelement($("#WORKLOAD"))){
						return;
					}
				}
				top.jzts();
				$('#REQ_STATE_PLUS').removeAttr("disabled");
				$("#REQ_STATE_PLUS").val(n);
				$("#Form").submit();
			}
		}
		
		
		//删除
		$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title || '&nbsp;'
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));
	
		$( "#del" ).on('click', function(e) {
			e.preventDefault();
		
			$( "#dialog-confirm" ).removeClass('hide').dialog({
				resizable: false,
				width: '320',
				modal: true,
				title: "<div class='widget-header'><h4 class='smaller'><i class='ace-icon fa fa-exclamation-triangle red'></i> 子需求删除</h4></div>",
				title_html: true,
				buttons: [
					{
						html: "<i class='ace-icon fa fa-trash-o bigger-110 text-nowrap'></i> Delete",
						"class" : "btn btn-danger btn-minier",
						click: function() {
							var id = $.trim($("#REQ_SDPIDPLUS").val());
							$.ajax({
								type: "POST",
								url: '<%=basePath%>/reqplus/delete.do',
						    	data: {REQ_SDPIDPLUS:id,tm:new Date().getTime()},
								dataType:'json',
								cache: false,
								success: function(data){
									$( "#dialog-confirm" ).dialog( "close" );
									 if("success" == data.msgcode){
										 $( "#msg" ).append('<i class="ace-icon fa fa-check"></i>'+data.msg); 
									 }else{
										 $( "#msg" ).append('<i class="ace-icon fa fa-times"></i>'+data.msg);
									 }
									 
									 $( "#dialog-message" ).removeClass('hide').dialog({
											modal: true,
											title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='ace-icon fa fa-check'></i>操作结果</h4></div>",
											title_html: true,
											buttons: [ 
												{
													text: "OK",
													"class" : "btn btn-primary btn-minier",
													click: function() {
														$( "#dialog-message" ).dialog( "close" ); 
														closeMenu("reqplus_edit");
													} 
												}
											]
										});
								}
							});
						}
					}
					,
					{
						html: "<i class='ace-icon fa fa-times bigger-110'></i>Cancel",
						"class" : "btn btn-minier",
						click: function() {
							$( this ).dialog( "close" );
						}
					}
				]
			});
		});
		
		
		

		
	</script>


</body>
</html>