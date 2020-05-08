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
	
	<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
		<link rel="stylesheet" href="static/ace/css/font-awesome.css" />
		<link rel="stylesheet" href="static/ace/css/jquery-ui.custom.css" />
		<link rel="stylesheet" href="static/ace/css/chosen.css" />
		<link rel="stylesheet" href="static/ace/css/datepicker.css" />
		<link rel="stylesheet" href="static/ace/css/bootstrap-timepicker.css" />
		<link rel="stylesheet" href="static/ace/css/daterangepicker.css" />
		<link rel="stylesheet" href="static/ace/css/bootstrap-datetimepicker.css" />
		<link rel="stylesheet" href="static/ace/css/colorpicker.css" />
		<link rel="stylesheet" href="static/ace/css/ace-fonts.css" />
		<link rel="stylesheet" href="static/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<script src="../assets/js/ace-extra.js"></script>
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
					
					<form action="userscore/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="USER_SCORE_ID" id="USER_SCORE_ID" value="${pd.USER_SCORE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><i class="ace-icon fa fa-asterisk red"></i>赠送原因:</td>
								<td>
								<!-- <input type="text" name="SCORE_REASON" id="SCORE_REASON" value="" maxlength="32" placeholder="这里输入赠送原因" title="赠送理由" style="width:98%;"/> -->
								
								<textarea type="text" name="SCORE_REASON" id="SCORE_REASON" class="autosize-transition form-control limited" placeholder="这里输入赠送原因" maxlength="127" ></textarea>
								</td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;"><i class="ace-icon fa fa-asterisk red"></i>积分数量:</td>
								<td><input type="number" name="SCORE_VALUE" id="SCORE_VALUE" value="" maxlength="32" placeholder="这里输入积分数量" title="积分数量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">赠送</a>
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
	
	<script type="text/javascript" src="static/js/ace/ace.js"></script>
	
	<script type="text/javascript">
			window.jQuery || document.write("<script src='static/ace/js/jquery.js'>"+"<"+"/script>");
		</script>
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='static/ace/js/jquery.mobile.custom.js'>"+"<"+"/script>");
		</script>
		<script src="static/ace/js/bootstrap.js"></script>
		<script src="static/ace/js/jquery-ui.custom.js"></script>
		<script src="static/ace/js/jquery.ui.touch-punch.js"></script>
		<script src="static/ace/js/chosen.jquery.js"></script>
		<script src="static/ace/js/fuelux/fuelux.spinner.js"></script>
		<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
		<script src="static/ace/js/date-time/bootstrap-timepicker.js"></script>
		<script src="static/ace/js/date-time/moment.js"></script>
		<script src="static/ace/js/date-time/daterangepicker.js"></script>
		<script src="static/ace/js/date-time/bootstrap-datetimepicker.js"></script>
		<script src="static/ace/js/bootstrap-colorpicker.js"></script>
		<script src="static/ace/js/jquery.knob.js"></script>
		<script src="static/ace/js/jquery.autosize.js"></script>
		<script src="static/ace/js/jquery.inputlimiter.1.3.1.js"></script>
		<script src="static/ace/js/jquery.maskedinput.js"></script>
		<script src="static/ace/js/bootstrap-tag.js"></script>

		<!-- ace scripts -->
		

		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			jQuery(function($) {
			
				$('[data-rel=tooltip]').tooltip({container:'body'});
				$('[data-rel=popover]').popover({container:'body'});
				
				$('textarea[class*=autosize]').autosize({append: "\n"});
				$('textarea.limited').inputlimiter({
					remText: '%n character%s remaining...',
					limitText: 'max allowed : %n.'
				});
			
				$.mask.definitions['~']='[+-]';
				$('.input-mask-date').mask('99/99/9999');
				$('.input-mask-phone').mask('(999) 999-9999');
				$('.input-mask-eyescript').mask('~9.99 ~9.99 999');
				$(".input-mask-product").mask("a*-999-a999",{placeholder:" ",completed:function(){alert("You typed the following: "+this.val());}});
			
			
			
				$( "#input-size-slider" ).css('width','200px').slider({
					value:1,
					range: "min",
					min: 1,
					max: 8,
					step: 1,
					slide: function( event, ui ) {
						var sizing = ['', 'input-sm', 'input-lg', 'input-mini', 'input-small', 'input-medium', 'input-large', 'input-xlarge', 'input-xxlarge'];
						var val = parseInt(ui.value);
						$('#form-field-4').attr('class', sizing[val]).val('.'+sizing[val]);
					}
				});
			
				$( "#input-span-slider" ).slider({
					value:1,
					range: "min",
					min: 1,
					max: 12,
					step: 1,
					slide: function( event, ui ) {
						var val = parseInt(ui.value);
						$('#form-field-5').attr('class', 'col-xs-'+val).val('.col-xs-'+val);
					}
				});
			
			
				
				//"jQuery UI Slider"
				//range slider tooltip example
				$( "#slider-range" ).css('height','200px').slider({
					orientation: "vertical",
					range: true,
					min: 0,
					max: 100,
					values: [ 17, 67 ],
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
				
			});
		</script>
	
	
		<script type="text/javascript">
		
		$('textarea[class*=autosize]').autosize({append: "\n"});
		$('textarea.limited').inputlimiter({
			remText: '%n character%s remaining...',
			limitText: 'max allowed : %n.'
		});
		
		
		$(top.hangge());
		//保存
		function save(){
			if($("#SCORE_VALUE").val()==""){
				$("#SCORE_VALUE").tips({
					side:3,
		            msg:'请输入积分数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_VALUE").focus();
			return false;
			}
			
			if($("#SCORE_REASON").val()==""){
				$("#SCORE_REASON").tips({
					side:3,
		            msg:'请输入赠送原因',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_REASON").focus();
			return false;
			}
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