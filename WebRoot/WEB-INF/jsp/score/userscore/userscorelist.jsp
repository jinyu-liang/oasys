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
<link rel="stylesheet" href="static/ace/css/jquery-ui.css" />

<style type="text/css">
#steps-fivepercent-slider .ui-slider-tip {
	visibility: visible;
	opacity: 1;
	top: -25px
}

#vertical-slider {
	height: 150px;
	margin-left: -110px
}
</style>



<link rel="stylesheet" href="static/ace/css/jquery-ui-slider-pips.min.css" />

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
						<form action="userscore/list.do" method="post" name="Form" id="Form">
						
						<!-- 检索  -->
						<fieldset class="widget-box">
							<div class="widget-header">
								<h4 class="smaller">查询条件</h4>
							</div>
							<div class="widget-body">
								<div class="widget-main ">
									<div class="form-group">
			                          <label class="col-sm-1 control-label" for="USER_ID">员工:</label>
			                          <div class="col-sm-3">
			                             <select class="chosen-select form-control" name="USER_ID" id="USER_ID" data-placeholder="请选择员工" style="vertical-align:top;" style="width:98%;" >
											<option value=""></option>
											<c:forEach items="${userList}" var="user">
												<option value="${user.USER_ID}" <c:if test="${user.USER_ID == pd.USER_ID }">selected</c:if>>${user.NAME }</option>
											</c:forEach>
										 </select>
			                          </div>
			                          <label class="col-sm-1 control-label" for="SCORE_ID">积分名:</label>
			                          <div class="col-sm-3">
			                             <select class="chosen-select form-control" name="SCORE_ID" id="SCORE_ID" data-placeholder="请选择积分名" style="vertical-align:top;" style="width:98%;" >
											<option value=""></option>
											<c:forEach items="${scoreList}" var="score">
												<option value="${score.SCORE_ID}" <c:if test="${score.SCORE_ID == pd.SCORE_ID }">selected</c:if>>${score.SCORE_NAME }</option>
											</c:forEach>
										 </select>
			                          </div>
			                       </div>
									<div class="form-group">
			                          <label class="col-sm-1 control-label" for="">积分范围:</label>
			                          
 									  <div class="col-sm-1">
 									    <div class="space-2"></div>
 										<input type="text" id="AMOUNT" name="AMOUNT" style="border:0; color:#f6931f; font-weight:bold;"> 
 									  </div>
 									  
 									  <div class="col-sm-6">
			                          	<div class="space-8"></div>
										<!-- #section:plugins/jquery.slider -->
										<!--     <div id="slider-range"></div> -->
										<div id="steps-fivepercent-slider" style="margin-left: -40px"></div>
										    
 									  </div>
 									  
			                        </div>
			                       
			                       <c:if test="${QX.cha == 1 }">
				                       <div class="text-right">
				                       		<button type="button" class="btn btn-primary btn-sm" style="text-shadow: black 5px 3px 3px;" onclick="tosearch();">检索</button>
				                       </div>
			                       </c:if>
								</div>
							</div>
						</fieldset>
						<!-- 检索  -->
						
						<!-- 检索  -->
						
						
						<!-- 检索  -->
					<h4 class="header green">查询结果</h4>
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<!-- <th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th> -->
									<th class="center" style="width:50px;">序号</th>
									<!-- <th class="center">用户ID</th> -->
									<th class="center">员工姓名</th>
									<!-- <th class="center">积分ID</th> -->
									<th class="center">积分名</th>
									<th class="center">当前积分值</th>
									<th class="center">被赠积分次数</th>
									<th class="center">被赠积分总值</th>
									<th class="center">赠送积分次数</th>
									<!-- <th class="center">备注</th> 
									<th class="center">更新人</th>
									<th class="center">更新日期</th>-->
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
											<%-- <td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.USER_SCORE_ID}" class="ace" /><span class="lbl"></span></label>
											</td> --%>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<%-- <td class='center'>${var.USER_ID}</td> --%>
											<td class='center'>${var.USER_NAME}</td>
											<%-- <td class='center'>${var.SCORE_ID}</td> --%>
											<td class='center'>${var.SCORE_NAME}</td>
											<td class='center'>${var.SCORE_VALUE}</td>
											<td class='center'>${var.SCORE_IN_TIMES}</td>
											<td class='center'>${var.SCORE_IN_SUM}</td>
											<td class='center'>${var.SCORE_OUT_TIMES}</td>
											<%-- <td class='center'>${var.REMARK}</td> 
											<td class='center'>${var.UPDATE_ID}</td>
											<td class='center'>${var.UPDATE_DATE}</td>--%>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												
													 <c:if test="${QX.cha == 1 }">
													 <c:set var="contains" value="no" />
													 <c:forEach items="${loginpd}" var="loginscoreid">
													 	<c:if test="${loginscoreid.SCORE_ID eq var.SCORE_ID }">
													 	<c:set var="contains" value="yes" />
													 	</c:if>
													 </c:forEach>
													 
													 <c:choose>
														<c:when test="${contains=='yes' }">
														
														<c:if test="${var.USER_ID != loginId && var.SHOW_TAG == 1}">
														<a class="btn btn-xs btn-success" title="赠送积分" onclick="givescore('${var.USER_SCORE_ID}');">
														<i>赠送积分</i>
														</a>
														</c:if>
														<c:if test="${var.USER_ID == loginId && var.SHOW_TAG == 1}">
														<a class="btn btn-xs btn-danger" title="批量赠送积分" onclick="fromExcelOwm('${var.SCORE_ID}');">
														<i>批量赠送积分</i>
														</a>
														</c:if>
														
		   												</c:when>
														<c:otherwise>
														
		   												</c:otherwise>
													</c:choose>
													
													</c:if>
												
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
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-sm btn-danger" onclick="fromExcel('${var.SCORE_ID}');" title="批量分配积分" ><i>批量分配积分</i></a>
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
	
	<!-- page specific plugin scripts -->
	<script src="static/ace/js/jquery-ui.js"></script>
	<script src="static/ace/js/jquery.ui.touch-punch.js"></script>
	<!-- jquery, jqueryui --> 


<!-- slider --> 
<script src="static/ace/js/jquery-ui-slider-pips.js"></script> 
<!-- app --> 

	
		
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
			 diag.URL = '<%=basePath%>userscore/goAdd.do';
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
					var url = "<%=basePath%>userscore/delete.do?USER_SCORE_ID="+Id+"&tm="+new Date().getTime();
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
			 diag.URL = '<%=basePath%>userscore/goEdit.do?USER_SCORE_ID='+Id;
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
		//送分
		function givescore(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="赠送积分";
			 diag.URL = '<%=basePath%>userscore/goEdit.do?USER_SCORE_ID='+Id;
			 diag.Width = 550;
			 diag.Height = 255;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		//打开批量分配上传excel页面
		function fromExcel(Id){
			console.log("分配");
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="EXCEL 导入到数据库";
			 diag.URL = '<%=basePath%>userscore/goUploadExcel.do?userscoreid='+Id;
			 diag.Width = 300;
			 diag.Height = 200;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}	
		//打开批量赠送上传excel页面
		function fromExcelOwm(Id){
			console.log("赠送");
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="EXCEL 导入到数据库";
			 diag.URL = '<%=basePath%>userscore/goUploadExcelOwn.do?userscoreid='+Id;
			 diag.Width = 300;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
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
								url: '<%=basePath%>user_score/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>user_score/excel.do';
		}
	</script>	
	<script>
	
	
    $("#steps-fivepercent-slider")
    .slider({ 
    	min: 0, 
    	max: 20000, 
    	range: true, 
    	values: [0, 20000] ,
    	slide: function( event, ui ) {
    		 $( "#AMOUNT" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
    	}
    })
    .slider("pips", {
        rest: "label"
    })
    .slider("float");	
    $( "#AMOUNT" ).val( "$" + $( "#steps-fivepercent-slider" ).slider( "values", 0 ) +" - $" + $( "#steps-fivepercent-slider" ).slider( "values", 1 ) );
	
	
	
		//"jQuery UI Slider"
		//range slider tooltip example
		$( "#slider-range" ).slider({
			range: true,
			min: 0,
			max: 20000,
			values: [ 0, 100 ],
			slide: function( event, ui ) {
				var val = ui.values[$(ui.handle).index()-1] + "";
	
				if( !ui.handle.firstChild ) {
					$("<div class='tooltip right in' style='display:none;left:16px;top:-6px;'><div class='tooltip-arrow'></div><div class='tooltip-inner'></div></div>")
					.prependTo(ui.handle);
				}
				$(ui.handle.firstChild).show().children().eq(1).text(val);
			}
		}).find('span.ui-slider-handle').on('blur', function(){
			$(this.firstChild).hide();
		});
		
		
		$( "#slider-range-max" ).slider({
			range: "max",
			min: 1,
			max: 10,
			value: 2
		});
		
		$( "#slider-eq > span" ).css({width:'90%', 'float':'left', margin:'15px'}).each(function() {
			// read initial values from markup and remove that
			var value = parseInt( $( this ).text(), 10 );
			$( this ).empty().slider({
				value: value,
				range: "min",
				animate: true
				
			});
		});
		
		$("#slider-eq > span.ui-slider-purple").slider('disable');//disable third item
		
	</script>



</body>
</html>