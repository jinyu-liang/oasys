<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String realIP = request.getHeader("X-Real-IP"); 
	String ip = request.getRemoteAddr(); 
%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>${pd.SYSNAME}</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="static/login/bootstrap.min.css" />
<link rel="stylesheet" href="static/login/css/camera.css" />
<link rel="stylesheet" href="static/login/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="static/login/matrix-login.css" />
<link href="static/login/font-awesome.css" rel="stylesheet" />
<link href="static/login/css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="static/login/css/slidercaptcha.css" rel="stylesheet" />
<script type="text/javascript" src="static/login/js/jquery-1.8.3.js"></script>
<script src="static/login/js/bootstrap.min.js"></script>
<script src="static/login/js/jquery.easing.1.3.js"></script>
<script src="static/login/js/jquery.mobile.customized.min.js"></script>
<script src="static/login/js/camera.min.js"></script>
<script src="static/login/js/templatemo_script.js"></script>
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/js/jquery.cookie.js"></script>	
</head>
<body>
	<div style="width:100%;text-align: center;margin: 0 auto;position: absolute;">
		<div id="loginbox">
			<form action="" method="post" name="loginForm" id="loginForm">
				<div class="control-group normal_text">
					<h3>
						<img src="static/login/asiainfo.png" alt="Logo" />
					</h3>
				</div>
				<div class="control-group" id="group1">
					<div class="controls">
						<div class="main_input_box">
							<span class="add-on bg_lg">
							<i><img height="37" src="static/login/user.png" /></i>
							</span><input type="text" name="loginname" id="loginname" value="" placeholder="请输入用户名" />
						</div>
					</div>
				</div>
				<div class="control-group" id="group2">
						 
					<div class="controls">
						<div class="main_input_box">
							<span class="add-on bg_ly">
							<i><img height="37" src="static/login/suo.png" /></i>
							</span><input type="password" name="password" id="password" placeholder="请输入密码" value=""/>
						</div>
					</div>
				</div>
				<div style="float:right;padding-right:10%;" id="group3">
					<div style="float: left;margin-top:3px;margin-right:2px;">
						<font color="white">记住密码</font>
					</div>
					<div style="float: left;">
						<input name="form-field-checkbox" id="saveid" type="checkbox"
							onclick="savePaw();" style="padding-top:0px;" />
					</div>
				</div>
				
				<div class="control-group" id="group4" style="display:none">
					<div style="width:100%;padding-left:10%;">
						<div style="float: left;padding-top:2px;">
							<i><img src="static/login/yan.png" /></i>
						</div>
						<div style="float: left;" class="codediv">
							<input type="text" name="code" id="code" class="login_code"
								style="height:16px; padding-top:4px;" />
						</div>
						<div style="float: left;">
							<i><img id="codeImg" alt="点击更换"
								title="点击更换" src="<%=basePath%>temp/defaultverificationcode.jpg" /></i>	  
						</div>
					</div>
				</div>
				
				<div class="control-group " id="group5" style="display:none;margin-top:-50px;margin-bottom:10px;" >
					<div class="widget-header normal_text" >
						<h4 class="header smaller lighter green"  >完成拼图验证</h4>
					</div>
	                        <div id="captcha"></div>
                </div>
                
				<div class="form-actions" id="group6">
						<span class="pull-center"  ><a onclick="severCheck();" class="flip-link btn btn-info" id="to-recover">登录</a></span>
						
						<span class="pull-center" ><a href="javascript:quxiao();" class="btn btn-success">取消</a></span>
				</div>
				

				<div  class="control-group " >
					<font color="white">当前登录的IP地址是：<%=realIP%></font> 
				</div>
				
				
				
			</form>
			<div class="controls">
				<div class="main_input_box">
					<font color="white"><span id="nameerr"></span></font>
				</div>
			</div>
		</div>
	</div>
	
	
	

	
	<div id="templatemo_banner_slide" class="">
		<div class="">
			<div data-src="static/login/images/banner_slide_01.jpg"></div>
			<div data-src="static/login/images/banner_slide_01.jpg"></div>
		</div>
		<!-- #camera_wrap_3 -->
	</div>

	




	<script type="text/javascript">
		$("#group4").hide();
		$("#group5").hide();
	   
	  

		//服务器校验
		function severCheck(){
			if(check()){
			$("#group1").hide();
			$("#group2").hide();
			$("#group3").hide();
			$("#group4").hide();
			$("#group5").show();
			$("#group6").hide();
			}
		}
	
		$(document).ready(function() {
			changeCode();
			$("#codeImg").bind("click", changeCode);
		});

		$(document).keyup(function(event) {
			if (event.keyCode == 13) {
				$("#to-recover").trigger("click");
			}
		});

		function genTimestamp() {
			var time = new Date();
			return time.getTime();
		}

		function changeCode() {
			$("#codeImg").attr("src", "code.do?t=" + genTimestamp());
		}

		//客户端校验
		function check() {

			if ($("#loginname").val() == "") {

				$("#loginname").tips({
					side : 2,
					msg : '用户名不得为空',
					bg : '#AE81FF',
					time : 3
				});

				$("#loginname").focus();
				return false;
			} else {
				$("#loginname").val(jQuery.trim($('#loginname').val()));
			}

			if ($("#password").val() == "") {

				$("#password").tips({
					side : 2,
					msg : '密码不得为空',
					bg : '#AE81FF',
					time : 3
				});

				$("#password").focus();
				return false;
			}
			return true;
		}

		function savePaw() {
			if (!$("#saveid").attr("checked")) {
				$.cookie('loginname', '', {
					expires : -1
				});
				$.cookie('password', '', {
					expires : -1
				});
				$("#loginname").val('');
				$("#password").val('');
			}
		}

		function saveCookie() {
			if ($("#saveid").attr("checked")) {
				$.cookie('loginname', $("#loginname").val(), {
					expires : 7
				});
				$.cookie('password', $("#password").val(), {
					expires : 7
				});
			}
		}
		function quxiao() {
			$("#loginname").val('');
			$("#password").val('');
		}
		
		jQuery(function() {
			var loginname = $.cookie('loginname');
			var password = $.cookie('password');
			if (typeof(loginname) != "undefined"
					&& typeof(password) != "undefined") {
				$("#loginname").val(loginname);
				$("#password").val(password);
				$("#saveid").attr("checked", true);
				$("#code").focus();
			}
		});
	</script>
	<script>
		//TOCMAT重启之后 点击左侧列表跳转登录首页 
		if (window != top) {
			top.location.href = location.href;
		}
	</script>
	<c:if test="${'1' == pd.msg}">
		<script type="text/javascript">
		$(tsMsg());
		function tsMsg(){
			alert('此用户在其它终端已经早于您登录,您暂时无法登录');
		}
		</script>
	</c:if>
	<c:if test="${'2' == pd.msg}">
		<script type="text/javascript">
			$(tsMsg());
			function tsMsg(){
				alert('您被系统管理员强制下线');
			}
		</script>
	</c:if>

	
	
	
<script type="text/javascript" src="static/login/css/twitter-bootstrap/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="static/login/js/longbow.slidercaptcha.js"></script>
	<script type="text/javascript">
	 $('#captcha').sliderCaptcha({
	        repeatIcon: 'fa fa-redo',
	        setSrc: function () {
	            return 'static/images/' + Math.round(Math.random() * 118) + '.jpg';
	        },			
	        onSuccess: function () {  //成功事件
	        	if(check()){
	    			$("#loginbox").tips({
	    				side : 1,
	    				msg : '正在登录 , 请稍后 ...',
	    				bg : '#68B500',
	    				time : 3
	    			});
	    			
					var loginname = $("#loginname").val();
					var password = $("#password").val();
					var code = $("#code").val();
					if(code == ""){
						code="999";
					}
					var code = loginname+"#"+password+"#"+code;
					$.ajax({
						type: "POST",
						url: 'login_login',
				    	data: {KEYDATA:code,tm:new Date().getTime()},
						dataType:'json',
						cache: false,
						success: function(data){
							if("success" == data.result){
								saveCookie();
								window.location.href="main/index";
							}else if("usererror" == data.result){
								
								
								$("#group1").show();
								$("#group2").show();
								$("#group3").hide();
								$("#group4").hide();
								$("#group5").hide();
								$("#group6").show();
								
								$("#loginname").tips({
									side : 1,
									msg : "用户名或密码有误",
									bg : '#FF5080',
									time : 3
								});
								$("#loginname").focus();

								$('#captcha').sliderCaptcha('reset');

								
								
							}else{
								$("#loginname").tips({
									side : 1,
									msg : "缺少参数",
									bg : '#FF5080',
									time : 15
								});
								$("#loginname").focus();
							}
						}
					});
				}
	        }
	    });
	</script>
	
	
</body>

</html>