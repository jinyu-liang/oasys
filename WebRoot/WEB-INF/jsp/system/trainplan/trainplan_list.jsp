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

<link rel="stylesheet" href="static/ace/css/ace.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link rel="stylesheet" media="screen" type="text/css" href="plugins/zoomimage/css/zoomimage.css" />
<link rel="stylesheet" media="screen" type="text/css" href="plugins/zoomimage/css/custom.css" />
<script type="text/javascript" src="plugins/zoomimage/js/jquery.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/eye.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/utils.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/zoomimage.js"></script>
<script type="text/javascript" src="plugins/zoomimage/js/layout.js"></script>
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
						<form action="trainplan/list2.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="请输入培训名" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="请输入培训名"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker"  id="lastLoginStart"   type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期" value="${pd.starttime}" name="starttime"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker"  type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期" value="${pd.endtime}" name="endtime"/></td>
								<!-- <td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="name" id="id" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
									<option value=""></option>
									<option value="">全部</option>
									<option value="">1</option>
									<option value="">2</option>
								  	</select>
								</td> -->
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
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
									<th class="center">培训名</th>
									<th class="center">培训描述</th>
									<th class="center">开始时间</th>
									<th class="center">结束时间</th>
									<th class="center">状态</th>
									<th class="center">讲师</th>
									<th class="center">计划培训时长</th>
									<th class="center">培训地点</th>
									<th class="center">培训文档</th>
									<th class="center">签到二维码</th>
									<th class="center">评价二维码</th>
									<th class="center">培训评价</th>
									
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<%-- <tr id="${var.TRAINPLAN_ID}" class="${var.PLAN_NAME}" onmouseover="on(this.id)" onmouseout="out()"> --%>
										<tr id="${var.TRAINPLAN_ID}" class="${var.PLAN_NAME}">
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.TRAINPLAN_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='left'>${var.PLAN_NAME}</td>
											<td class='left' title='${var.PLAN_DESCRIE}' style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${var.PLAN_DESCRIE}</td>
											<td style="text-align:right" id="starttime" value="${var.STARTTIME}">${var.STARTTIME1}</td>
											<td style="text-align:right" id="endtime" value="${var.ENDTIME}">${var.ENDTIME1}</td>
											<td class='center' id="truestate">${var.STATUS}</td>
											<td class='center'>${var.LETURE}</td>
											<td class='center'>${var.PLANTRAINTIME}</td>
											<td class='center'>${var.PLANPLACE}</td>
											<td class='center'><c:if test="${not empty var.PLANFILENAME}"><a onclick="toDownload('${var.PLANFILEID}')" style="cursor:pointer;">${var.PLANFILENAME}</a></c:if></td>										
											<td class='center'>
												<c:if test="${not empty var.PICTURENAME1}">
													<a href="<%=basePath%>uploadFiles/file/${var.PICTUREID1}" title="${var.PICTURENAME1}" class="bwGal">${var.PICTURENAME1}</a>
												</c:if>
											</td>
											<td class='center'>
												<c:if test="${not empty var.PICTURENAME2}">
													<a href="<%=basePath%>uploadFiles/file/${var.PICTUREID2}" title="${var.PICTURENAME2}" class="bwGal">${var.PICTURENAME2}</a>
												</c:if>
											</td>										
											
											<td class='center'>
													<a class="btn btn-xs btn-info" onclick="pieChart('${var.TRAINPLAN_ID}')">
														<i>查看评价统计</i>
													</a>
											</td>
											<!-- <td class='center'>${var.JOINUSER}</td>  -->
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													
													<c:if test="${var.ISJOIN ne '0'}">
													<c:if test="${QX.cha == 1 }">
													<a class="btn btn-xs btn-info disabled"  onclick="sign('${var.TRAINPLAN_ID}','${var.PLAN_NAME}');">
														<!--<i class="ace-icon fa fa-comment bigger-120" title="已报名"></i>-->
														<i>已报名</i>
													</a>
													</c:if>
													</c:if>
													<c:if test="${var.ISJOIN eq '0'}">
													<c:if test="${QX.cha == 1 }">
													<a class="btn btn-xs btn-info" onclick="sign('${var.TRAINPLAN_ID}','${var.PLAN_NAME}');">
														<!--<i class="ace-icon fa fa-comment bigger-120" title="报名"></i>-->
														<i>报名</i>
													</a>
													</c:if>
													</c:if>
													
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.TRAINPLAN_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger " onclick="del('${var.TRAINPLAN_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
													
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
					
					
										<!-- <div class="widget-box" style="width:40%">
											<div class="widget-header widget-header-flat widget-header-small">
												<h5 class="widget-title">
													<i class="ace-icon fa fa-signal"></i>
													<i id="cplanname">培训名</i>
												</h5>
											</div>
											<div class="widget-body">
												<div class="widget-main">
													#section:plugins/charts.flotchart
													<div id="piechart-placeholder"></div>

												</div>/.widget-main
											</div>/.widget-body
										</div>/.widget-box -->
					
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
	<!-- 饼图 -->
		<script src="static/html_UI/assets/js/flot/jquery.flot.js"></script>
		<script src="static/html_UI/assets/js/flot/jquery.flot.pie.js"></script>
		<script src="static/html_UI/assets/js/flot/jquery.flot.resize.js"></script>
	<script type="text/javascript">
	
	//导出
	function toDownload(fileName){
		var keywords = $("#nav-search-input").val();
		var lastLoginStart = $("#lastLoginStart").val();
		var lastLoginEnd = $("#lastLoginEnd").val();
		var url='<%=basePath%>trainplan/download.do?fileName='+fileName;
		if(typeof(lastLoginStart) != 'undefined' && typeof(lastLoginEnd) != 'undefined'){
			url= url+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd;
		}
		window.location.href=url;
	};
	
		$(top.hangge());
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
			 diag.URL = '<%=basePath%>trainplan/goAdd.do';
			 diag.Width = 750;
			 diag.Height = 700;
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
			top.jzts();
			var url = "<%=basePath%>trainplan/delete.do?TRAINPLAN_ID="+Id+"&tm="+new Date().getTime();
			$.get(url,function(data){
				nextPage(${page.currentPage});
			});
		}
		
		//报名
		function sign(Id,Name){
			var data={"id":Id,"name":Name}
			top.jzts();
			var url = "<%=basePath%>trainplan/signin.do";
			$.post(url,data,function(data){
				nextPage(${page.currentPage});
			});
		}
		
		 <%-- function pieChart(Id) {
			var data={"id":Id}
			
					top.jzts();
					var url = "<%=basePath%>trainplan/piechart.do";
					$.post(url,data,function(data){
						nextPage(${page.currentPage});
					});
				
		}  --%>
		function pieChart(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="培训评价详情";
			 diag.URL = '<%=basePath%>trainplan/piechart.do?TRAINPLAN_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 280;
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
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>trainplan/goEdit.do?TRAINPLAN_ID='+Id;
			 diag.Width = 750;
			 diag.Height = 555;
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
								url: '<%=basePath%>trainplan/deleteAll.do?tm='+new Date().getTime(),
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
		
		

		
	</script>
	
	<!-- <script type="text/javascript">
	
	Date.prototype.Format = function (fmt) { //author: meizz 
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "h+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}
	
		$(window).load(function state() {
			var starttime=$("#starttime").html();
			var endtime=$("#endtime").html()
			var myDate = new Date().Format("yyyy-MM-dd");
			if(myDate<starttime){
				$("#truestate").html("未开始");
			}
			if(myDate>starttime && myDate<endtime){
				$("#truestate").html("正在进行");
			}
			if(myDate>endtime){
				$("#truestate").html("结束");
			}
		});
	</script>
 -->
 <style type="text/css">
	li {list-style-type:none;}
 </style>
	<ul class="navigationTabs">
        <li><a></a></li>
        <li></li>
    </ul>
</body>
</html>