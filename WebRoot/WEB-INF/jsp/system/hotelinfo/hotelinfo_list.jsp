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


<style>   
.th{width:170px;overflow:hidden;text-align:center}
.th1{width:90px;overflow:hidden;text-align:center}
.th2{width:75px;overflow:hidden;text-align:center}
.th3{width:135px;overflow:hidden;text-align:center}
.th4{width:110px;overflow:hidden;text-align:center}
.th5{width:93.33px;overflow:hidden;text-align:center}
 table { table-layout:fixed; word-break: break-all; word-wrap: break-word;} 
.award-name{-o-text-overflow:ellipsis;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;width:100%; //超出部分显示省略号}

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
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<%--  <form action="hotelinfo/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="请输入工号,姓名或房号" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="请输入工号,姓名或房号"style="width:200px;"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
							<!-- 	<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastLoginEnd" name="lastLoginEnd"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td> -->
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="STATUS" id="STATUS" data-placeholder="住宿状态" style="vertical-align:top;width: 120px;">
									<option value=""></option>
									<option value="">全部</option>
									<option value="在住" <c:if test="${pd.STATUS eq '0'}">selected</c:if>>在住</option>  
									<option value="撤离" <c:if test="${pd.STATUS eq '1'}">selected</c:if>>撤离</option>
								  	</select>
								</td>
								
								
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="EMPTY_BED_FLAG" id="EMPTY_BED_FLAG" data-placeholder="是否有空床" style="vertical-align:top;width: 120px;">
									<option value=""></option>
									<option value="">全部</option>
									<option value="有" <c:if test="${pd.EMPTY_BED_FLAG eq '0'}">selected</c:if>>有</option>  
									<option value="无" <c:if test="${pd.EMPTY_BED_FLAG eq '1'}">selected</c:if>>无</option>
								  	</select>
								
								</td>
								
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>  --%>
					<form action="hotelinfo/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>	
						
				 <fieldset class="widget-box">
							<div class="widget-header">
								<h4 class="smaller">查询检索</h4>
							</div>
							<div class="widget-body">
								<div class="widget-main ">
									<div class="form-group" style="height:8vh;">      <!-- 定义form_group的高度  避免页面错乱 -->                
			                          <label class="col-sm-1 control-label" for="STATUS">住宿状态</label>
			                          <div class="col-sm-3">                         
			                             <select class="chosen-select form-control" name="STATUS" id="STATUS" data-placeholder="请选择住宿状态" style="vertical-align:top;" style="width:98%;" >
										<option value="">全部</option>
									<option value="在住" <c:if test="${pd.STATUS eq '0'}">selected</c:if>>在住</option>  
									<option value="撤离" <c:if test="${pd.STATUS eq '1'}">selected</c:if>>撤离</option>
										 </select>	 
			                          </div>
			                          
			                         <label class="col-sm-1 control-label" for="EMPTY_BED_FLAG" style="padding:4px 8px;"style="width:8%">是否有空床</label>  
			                            <div class="col-sm-3">	                                
			                             <select class="chosen-select form-control" name="EMPTY_BED_FLAG" id="EMPTY_BED_FLAG" data-placeholder="请选择是否有空床" style="vertical-align:top;" style="width:98%;" >
										<option value="">全部</option>
								<option value="有" <c:if test="${pd.EMPTY_BED_FLAG eq '0'}">selected</c:if>>有</option>  
									<option value="无" <c:if test="${pd.EMPTY_BED_FLAG eq '1'}">selected</c:if>>无</option>
										 </select>
										 
										 
										 
			                          </div>
			                          
			                          <label class="col-sm-1 control-label" for="STAFF_NAME">员工姓名</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="STAFF_NAME" name="STAFF_NAME" value="${pd.STAFF_NAME}" type="text" placeholder="请输入员工姓名"/>
			                          </div>
			                         
			                       </div>
									<div class="form-group">
									  <label class="col-sm-1 control-label" for="STAFF_ID">员工工号</label>
			                          <div class="col-sm-3">
			                             <input class="form-control" id="STAFF_ID" name="STAFF_ID" value="${pd.STAFF_ID}"  type="text" placeholder="请输入工号"/>
			                          </div>
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
									<th class="center" style="width:92.22px;">工号</th>  									   
									<th class="th5">姓名</th>
									<th class="th5">住宿地</th>
									<!-- <th class="center">住宿详细地址</th> -->
									<th class="th5">住宿类型</th>
									<!-- <th class="center">日单价</th>
									<th class="center">房号</th> -->
									<th class="th5">床位</th>
									<!-- <th class="center">在住人数</th> -->
									<th class="th5">空床</th>
									<th class="th" aligin="center">工作描述</th>
									<th class="th5">住宿状态</th>
									<!-- <th class="center">indate</th>-->
									<th class="th1">开始日期</th>
									<th class="th1">结束日期</th>
									<!--  <th class="center">更新日期</th>-->
								<!-- 	<th class="center">更新员工</th>
									<th class="center">SRT1</th>
									<th class="center">STR2</th>
									<th class="center">STR3</th>
									<th class="center">STR4</th>
									<th class="center">DATE1</th>  非展示部分字段
									<th class="center">DATE2</th> -->
									<th class="th5">同住人</th> 
									<!--  <th class="center">住宿费用</th>-->
									<th class="th4">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环  加载出数据库的表信息 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.TRADE_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td> 
											
										 <td class='center'>	<a href = "javascript:;" onclick="lookinfo('${var.TRADE_ID}');">${var.STAFF_ID}</a></td>  
											
											
											        <!-- 点击工号进入查看信息的状态 -->
									
									
											        
											<%-- <td class='center'>${var.STAFF_ID}</td> --%>
											<td class='center'>${var.STAFF_NAME}</td>
											<td class='center'>${var.HOTEL_NAME}</td>
											<%-- <td class='center'>${var.HOTEL_ADRESS}</td> --%>
											<!--  <td class='center'>${var.HOTEL_FLAG}</td>-->
											<!-- 配置住宿类型类型的字段 -->
											<td><c:if test="${var.HOTEL_FLAG eq '1'}">酒店</c:if>
                                           <c:if test="${var.HOTEL_FLAG eq '0'}">宿舍</c:if>                                       		
                                           </td>
											
											
											<%-- <td class='center'>${var.HOTEL_DAY_PRICE}</td>
											<td class='center'>${var.HOTEL_ROOM_NU}</td> --%>
											
											
											<!--  <td class='center'>${var.HOTEL_BED_FLAG}</td>-->
											<!-- 配置床位的字段 -->
											<td><c:if test="${var.HOTEL_BED_FLAG eq '1'}">单床房</c:if>
                                           <c:if test="${var.HOTEL_BED_FLAG eq '2'}">双床房</c:if>
                                           <c:if test="${var.HOTEL_BED_FLAG eq '3'}">三床房</c:if>
                                           <c:if test="${var.HOTEL_BED_FLAG eq '4'}">双人大床房</c:if>
                                           </td>
											
											<%-- <td class='center'>${var.HOTEL_LIVE_NU}</td> --%>
											<!--  <td class='center'>${var.EMPTY_BED_FLAG}</td>-->
											<!-- 配置是否有空床的字段 -->
											<td><c:if test="${var.EMPTY_BED_FLAG eq '1'}">无</c:if>
                                           <c:if test="${var.EMPTY_BED_FLAG eq '0'}">有</c:if>                                       		
                                           </td>
											<td class='award-name'>${var.WORK_CONTENT}</td>
											<!--  <td class='center'>${var.STATUS}</td>-->
											<!-- 配置住宿状态的字段 -->
											<td><c:if test="${var.STATUS eq '1'}">撤离</c:if>
                                           <c:if test="${var.STATUS eq '0'}">在住</c:if>                                       		
                                           </td>
											
											
											<!--  <td class='center'>${var.IN_DATE}</td>-->
											<td class='center'>${var.START_DATE}</td>
											<td class='center'>${var.END_DATE}</td>
											<%-- <td class='center'>${var.UPDATE_DATE}</td>
											<td class='center'>${var.UPDATE_STAFF_ID}</td>
											<td class='center'>${var.RSRV_STR1}</td>
											<td class='center'>${var.RSRV_STR2}</td>
											<td class='center'>${var.RSRV_STR3}</td>   非展示部分字段
											<td class='center'>${var.RSRV_STR4}</td>
											<td class='center'>${var.RSRV_DATE1}</td>
											<td class='center'>${var.RSRV_DATE2}</td> --%>
											<td class='center'>${var.ROOMMATE}</td>
											<!--  <td class='center'>${var.HOTEL_EXPENSE}</td>-->
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.TRADE_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													
													<!-- 新增同住人按钮   方法自定义 逻辑为： -->
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="新增同住人" onclick="addtongzhuren('${var.TRADE_ID}');">
														<i class="ace-icon fa fa-pencil bigger-120" title="新增同住人"></i>
													</a>
													</c:if>
													
													
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.TRADE_ID}');">
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
																<a style="cursor:pointer;" onclick="edit('${var.TRADE_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.TRADE_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
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
											<td colspan="14" class="center">您无权查看</td>       <!-- 14为表的显示字段数  超出后会出现报错页面排版异常的情况-->
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="14" class="center" >没有相关数据</td>   <!-- 这个colspan的值 就是list字段的个数   字段值和此值不一致 会导致页面的报错信息页面出现异常 -->
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
			 diag.URL = '<%=basePath%>hotelinfo/goAdd.do';
			 diag.Width = 800;
			 diag.Height = 600;
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
		
		//新增同住人
	 	function addtongzhuren(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增同住人";
			 diag.URL = '<%=basePath%>hotelinfo/goAddForTZ.do?TRADE_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 600;
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
					var url = "<%=basePath%>hotelinfo/delete.do?TRADE_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//修改                                    //  再做一个通过点击实现查看全部详细信息的页面
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>hotelinfo/goEdit.do?TRADE_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		
		
		
		
		//点击工号跳转到查看详细信息的页面
	  function lookinfo(Id){
	        top.jzts();
	        var diag = new top.Dialog();
	        diag.Drag=true;
	        diag.Title ="详细信息";
	        diag.URL = '<%=basePath%>hotelinfo/golookinfo.do?TRADE_ID='+Id;
	        diag.Width = 800;
	        diag.Height = 600;

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
								url: '<%=basePath%>hotelinfo/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>hotelinfo/excel.do';
		}
	</script>


</body>
</html>