<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	.search_input::-webkit-input-placeholder{
	    color:#b6b6b6;
	}
	.search_input:-moz-placeholder{
	    color:#b6b6b6;
	}
	.search_input::-moz-placeholder{
	    color:#b6b6b6;
	}
	.search_input:-ms-input-placeholder{
	    color:#b6b6b6;
	}
	
	

	
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
					
					<form action="hotelinfo/${msg }.do" name="Form" id="Form" method="post">  <!--msg 关系到映射controller  -->
						<input type="hidden" name="TRADE_ID" id="TRADE_ID" value="${pd.TRADE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">工号:</td>
								<td><input type="text" name="STAFF_ID" id="STAFF_ID" value="${pd.STAFF_ID}" maxlength="10" placeholder="这里输入工号*" title="工号" style="width:98%;"/></td>
						    <!-- </tr>
						     <tr> -->
								<td style="width:75px;text-align: right;padding-top: 13px;">姓名:</td>
								<td><input type="text" name="STAFF_NAME" id="STAFF_NAME" value="${pd.STAFF_NAME}" maxlength="10" placeholder="这里输入姓名*" title="姓名" style="width:98%;"/></td>
							</tr>
							
							</table>
							
						<table id="table_report" class="table table-striped table-bordered table-hover">	
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">住宿地:</td>
								<td><input type="text" name="HOTEL_NAME" id="HOTEL_NAME" value="${pd.HOTEL_NAME}" maxlength="20" placeholder="这里输入住宿地" title="住宿地" style="width:98%;"/></td>
							<!-- </tr>
							<tr> -->
								<td style="width:75px;text-align: right;padding-top: 13px;">日单价:</td>
								<td><input type="text" name="HOTEL_DAY_PRICE" id="HOTEL_DAY_PRICE" value="${pd.HOTEL_DAY_PRICE}" maxlength="20" placeholder="这里输入日单价*" title="日单价" style="width:98%;"/></td>
							</tr>
							
							</table>
							
							<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">房号:</td>
								<td><input type="text" name="HOTEL_ROOM_NU" id="HOTEL_ROOM_NU" value="${pd.HOTEL_ROOM_NU}" maxlength="20" placeholder="这里输入房号*" title="房号" style="width:98%;"/></td>
							<!-- </tr>
							<tr> -->
								<td style="width:75px;text-align: right;padding-top: 13px;">在住人数:</td>
								<td><input type="text" name="HOTEL_LIVE_NU" id="HOTEL_LIVE_NU" value="${pd.HOTEL_LIVE_NU}" maxlength="10" placeholder="这里输入在住人数" title="在住人数" style="width:98%;"/></td>
							</tr>
							</table>
							
							<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开始日期:</td>
								<td><input class="span10 date-picker" name="START_DATE" id="START_DATE" value="${pd.START_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期*" title="开始日期" style="width:98%;"/></td>
							<!-- </tr>
							<tr> -->
								<td style="width:75px;text-align: right;padding-top: 13px;">结束日期:</td>
								<td><input class="span10 date-picker" name="END_DATE" id="END_DATE" value="${pd.END_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束日期" title="结束日期" style="width:98%;"/></td>
							</tr>
							</table>
							
							
							
							
							
							
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<%-- <td style="width:75px;text-align: right;padding-top: 13px;">住宿类型:</td>
								<td><input type="text" name="HOTEL_FLAG" id="HOTEL_FLAG" value="${pd.HOTEL_FLAG}" maxlength="1" placeholder="这里输入住宿类型" title="住宿类型" style="width:98%;"/></td>
							 --%>
							<td style="width:90px;text-align: right;padding-top: 13px;">住宿类型:</td>
							<td>
									<select class="chosen-select form-control" name="HOTEL_FLAG" id="HOTEL_FLAG" data-placeholder="请选择住宿类型" style="vertical-align:top;width: 130px;">
													
													<option value="" <c:if test="${pd.HOTEL_FLAG eq ''}">selected</c:if>>——请选择——</option>  
													<option value="0" <c:if test="${pd.HOTEL_FLAG eq '0'}">selected</c:if>>宿舍</option>
													<option value="1" <c:if test="${pd.HOTEL_FLAG eq '1'}">selected</c:if>>酒店</option>
											  	</select> 
							</td>
							<!-- </tr>					
							<tr> -->
							
								 <%-- <td style="width:75px;text-align: right;padding-top: 13px;">床位:</td>
								
								<td><input type="text" name="HOTEL_BED_FLAG" id="HOTEL_BED_FLAG" value="${pd.HOTEL_BED_FLAG}" maxlength="1" placeh older="这里输入床位" title="床位" style="width:98%;"/> --%>
							<td style="width:90px;text-align: right;padding-top: 13px;">床位信息:</td>
						         <td>
							
									<select class="chosen-select form-control" name="HOTEL_BED_FLAG" id="HOTEL_BED_FLAG" data-placeholder="请选择局床位" style="vertical-align:top;width: 130px;">
									 
									 <option value=""<c:if test="${pd.HOTEL_BED_FLAG eq ''}">selected</c:if>>——请选择——</option>
									<option value="1" <c:if test="${pd.HOTEL_BED_FLAG eq '1'}">selected</c:if>>单床房</option>  
									<option value="2" <c:if test="${pd.HOTEL_BED_FLAG eq '2'}">selected</c:if>>双床房</option>
									<option value="3" <c:if test="${pd.HOTEL_BED_FLAG eq '3'}">selected</c:if>>三床房</option>
									<option value="4" <c:if test="${pd.HOTEL_BED_FLAG eq '4'}">selected</c:if>>双人大床房</option>
								  	</select>
								</td>
							 
							</tr>
							</table>
							
							
							<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<%-- <td style="width:75px;text-align: right;padding-top: 13px;">是否有空床:</td>
								<td><input type="text" name="EMPTY_BED_FLAG" id="EMPTY_BED_FLAG" value="${pd.EMPTY_BED_FLAG}" maxlength="1" placeholder="这里输入是否有空床" title="是否有空床" style="width:98%;"/></td> --%>
								<td style="width:90px;text-align: right;padding-top: 13px;">是否有空床:</td>
									<td>
									<select class="chosen-select form-control" name="EMPTY_BED_FLAG" id="EMPTY_BED_FLAG" data-placeholder="是否有空床" style="vertical-align:top;width: 130px;">
													
													<option value="" <c:if test="${pd.EMPTY_BED_FLAG eq ''}">selected</c:if>>——请选择——</option>  
													<option value="0" <c:if test="${pd.EMPTY_BED_FLAG eq '0'}">selected</c:if>>有</option>
													<option value="1" <c:if test="${pd.EMPTY_BED_FLAG eq '1'}">selected</c:if>>无</option>
											  	</select> 
							        </td>
								
								
							<!-- </tr>
							<tr> -->
								<td style="width:90px;text-align: right;padding-top: 13px;">住宿状态:</td>
								<%-- <td><input type="text" name="STATUS" id="STATUS" value="${pd.STATUS}" maxlength="1" placeholder="这里输入住宿状态" title="住宿状态" style="width:98%;"/></td> --%>
								<td>
									<select class="chosen-select form-control" name="STATUS" id="STATUS" data-placeholder="住宿状态" style="vertical-align:top;width: 130px;">
													
													<option value="" <c:if test="${pd.STATUS eq ''}">selected</c:if>>——请选择——</option>  
													<option value="0" <c:if test="${pd.STATUS eq '0'}">selected</c:if>>在住</option>
													<option value="1" <c:if test="${pd.STATUS eq '1'}">selected</c:if>>撤离</option>
											  	</select> 
							        </td>
							</tr>
							
							</table>
							
							<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
							
							<td style="width:75px;text-align: right;padding-top: 13px;">工作描述:</td>
								
							<td>
							<textarea class="search_input" rows="3" cols="83" name="WORK_CONTENT" id="WORK_CONTENT"  placeholder="这里输入工作描述*"  style="color：gray;resize:none" >${pd.WORK_CONTENT}</textarea>
							</td>
							</tr>
							</table>
						
						
						<table id="table_report" class="table table-striped table-bordered table-hover">	
							<tr> 
								<td style="width:75px;text-align: right;padding-top: 13px;">住宿详细地址:</td>
								<%-- <td><input type="text" name="HOTEL_ADRESS" id="HOTEL_ADRESS" value="${pd.HOTEL_ADRESS}" maxlength="200" placeholder="这里输入酒店地址" title="酒店地址" style="width:98%;"/></td> --%>
								<td>
							<textarea class="search_input" rows="3" cols="83" name="HOTEL_ADRESS" id="HOTEL_ADRESS"  placeholder="这里输入住宿详细地址*"  style="color：gray;resize:none" >${pd.HOTEL_ADRESS}</textarea>
							</td>
							</tr>						
							</table>
<%-- 								<td style="width:75px;text-align: right;padding-top: 13px;">工作描述:</td>
								<td><input type="text" name="WORK_CONTENT" id="WORK_CONTENT" value="${pd.WORK_CONTENT}" maxlength="255" placeholder="这里输入工作描述" title="工作描述" style="width:98%;"/></td> --%>
							
						
						
						
						
							<%-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">空床位数:</td>
								<td><input type="text" name="IN_DATE" id="IN_DATE" value="${pd.IN_DATE}" maxlength="1" placeholder="这里输入indate" title="空床位数" style="width:98%;"/></td>
							</tr> --%>
							
							<%-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">更新日期:</td>
								<td><input class="span10 date-picker" name="UPDATE_DATE" id="UPDATE_DATE" value="${pd.UPDATE_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="更新日期" title="更新日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">更新员工:</td>
								<td><input type="text" name="UPDATE_STAFF_ID" id="UPDATE_STAFF_ID" value="${pd.UPDATE_STAFF_ID}" maxlength="10" placeholder="这里输入更新员工" title="更新员工" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">SRT1:</td>
								<td><input type="text" name="RSRV_STR1" id="RSRV_STR1" value="${pd.RSRV_STR1}" maxlength="100" placeholder="这里输入SRT1" title="SRT1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">STR2:</td>
								<td><input type="text" name="RSRV_STR2" id="RSRV_STR2" value="${pd.RSRV_STR2}" maxlength="100" placeholder="这里输入STR2" title="STR2" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">STR3:</td>
								<td><input type="text" name="RSRV_STR3" id="RSRV_STR3" value="${pd.RSRV_STR3}" maxlength="100" placeholder="这里输入STR3" title="STR3" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">STR4:</td>
								<td><input type="text" name="RSRV_STR4" id="RSRV_STR4" value="${pd.RSRV_STR4}" maxlength="100" placeholder="这里输入STR4" title="STR4" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">DATE1:</td>
								<td><input class="span10 date-picker" name="RSRV_DATE1" id="RSRV_DATE1" value="${pd.RSRV_DATE1}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="DATE1" title="DATE1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">DATE2:</td>
								<td><input class="span10 date-picker" name="RSRV_DATE2" id="RSRV_DATE2" value="${pd.RSRV_DATE2}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="DATE2" title="DATE2" style="width:98%;"/></td>
							</tr> --%>
							<table id="table_report" class="table table-striped table-bordered table-hover">
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">同住人:</td>
								<td><input type="text" name="ROOMMATE" id="ROOMMATE" value="${pd.ROOMMATE}" maxlength="50" placeholder="这里输入同住人" title="同住人" style="width:98%;"/></td>
							</tr>
							</table>
						<%-- 	<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">住宿费用:</td>
								<td><input type="text" name="HOTEL_EXPENSE" id="HOTEL_EXPENSE" value="${pd.HOTEL_EXPENSE}" maxlength="10" placeholder="这里输入住宿费用" title="住宿费用" style="width:98%;"/></td>
							</tr> --%>
							
							
							<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="text-align: center;" colspan="10">
								    <!-- <a class="btn btn-mini btn-primary" onclick="save();addtongzhuren();">新增同住人</a> -->
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
						
					</form>
	
					<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#STAFF_ID").val()==""){
				$("#STAFF_ID").tips({
					side:3,
		            msg:'请输入工号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STAFF_ID").focus();
			return false;
			}
			if($("#STAFF_NAME").val()==""){
				$("#STAFF_NAME").tips({
					side:3,
		            msg:'请输入姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STAFF_NAME").focus();
			return false;
			}
			/* if($("#HOTEL_NAME").val()==""){
				$("#HOTEL_NAME").tips({
					side:3,
		            msg:'请输入住宿地',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOTEL_NAME").focus();
			return false;
			}
			if($("#HOTEL_ADRESS").val()==""){
				$("#HOTEL_ADRESS").tips({
					side:3,
		            msg:'请输入住宿详细地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOTEL_ADRESS").focus();
			return false;
			} */
			if($("#HOTEL_FLAG").val()==""){
				$("#HOTEL_FLAG").tips({
					side:3,
		            msg:'请输入住宿类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOTEL_FLAG").focus();
			return false;
			}
			if($("#HOTEL_DAY_PRICE").val()==""){
				$("#HOTEL_DAY_PRICE").tips({
					side:3,
		            msg:'请输入日单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOTEL_DAY_PRICE").focus();
			return false;
			}
			if($("#HOTEL_ROOM_NU").val()==""){
				$("#HOTEL_ROOM_NU").tips({
					side:3,
		            msg:'请输入房号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOTEL_ROOM_NU").focus();
			return false;
			}
			if($("#HOTEL_BED _FLAG").val()==""){
				$("#HOTEL_BED _FLAG").tips({
					side:3,
		            msg:'请输入床位',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOTEL_BED _FLAG").focus();
			return false;
			}
			if($("#HOTEL_LIVE_NU").val()==""){
				$("#HOTEL_LIVE_NU").tips({
					side:3,
		            msg:'请输入在住人数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOTEL_LIVE_NU").focus();
			return false;
			}
			/* if($("#EMPTY_BED_FLAG").val()==""){
				$("#EMPTY_BED_FLAG").tips({
					side:3,
		            msg:'请输入是否有空床',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOTEL_BED_FLAG").focus();
			return false;
			} */
			if($("#WORK_CONTENT").val()==""){
				$("#WORK_CONTENT").tips({
					side:3,
		            msg:'请输入工作描述',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WORK_CONTENT").focus();
			return false;
			}
			if($("#STATUS").val()==""){
				$("#STATUS").tips({
					side:3,
		            msg:'请输入住宿状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STATUS").focus();
			return false;
			}
		/* 	if($("#IN_DATE").val()==""){
				$("#IN_DATE").tips({
					side:3,
		            msg:'请输入indate',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EMPTY_BED_FLAG").focus();
			return false;
			} */
			if($("#START_DATE").val()==""){
				$("#START_DATE").tips({
					side:3,
		            msg:'请输入开始日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#START_DATE").focus();
			return false;
			}
		/* 	if($("#END_DATE").val()==""){
				$("#END_DATE").tips({
					side:3,
		            msg:'请输入结束日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#END_DATE").focus();
			return false;
			} */
			/* if($("#UPDATE_DATE").val()==""){
				$("#UPDATE_DATE").tips({
					side:3,
		            msg:'请输入更新日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATE_DATE").focus();
			return false;
			}
			if($("#UPDATE_STAFF_ID").val()==""){
				$("#UPDATE_STAFF_ID").tips({
					side:3,
		            msg:'请输入更新员工',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATE_STAFF_ID").focus();
			return false;
			}
			if($("#RSRV_STR1").val()==""){
				$("#RSRV_STR1").tips({
					side:3,
		            msg:'请输入SRT1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RSRV_STR1").focus();
			return false;
			}
			if($("#RSRV_STR2").val()==""){
				$("#RSRV_STR2").tips({
					side:3,
		            msg:'请输入STR2',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RSRV_STR2").focus();
			return false;
			}
			if($("#RSRV_STR3").val()==""){
				$("#RSRV_STR3").tips({
					side:3,
		            msg:'请输入STR3',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RSRV_STR3").focus();
			return false;
			}
			if($("#RSRV_STR4").val()==""){
				$("#RSRV_STR4").tips({
					side:3,
		            msg:'请输入STR4',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RSRV_STR4").focus();
			return false;
			}
			if($("#RSRV_DATE1").val()==""){
				$("#RSRV_DATE1").tips({
					side:3,
		            msg:'请输入DATE1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RSRV_DATE1").focus();
			return false;
			}
			if($("#RSRV_DATE2").val()==""){
				$("#RSRV_DATE2").tips({
					side:3,
		            msg:'请输入DATE2',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RSRV_DATE2").focus();
			return false;
			} */
			/* if($("#ROOMMATE").val()==""){
				$("#ROOMMATE").tips({
					side:3,
		            msg:'请输入同住人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ROOMMATE").focus();
			return false;
			} */
			/* if($("#HOTEL_EXPENSE").val()==""){
				$("#HOTEL_EXPENSE").tips({
					side:3,
		            msg:'请输入住宿费用',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#HOTEL_EXPENSE").focus();
			return false;
			} */
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>