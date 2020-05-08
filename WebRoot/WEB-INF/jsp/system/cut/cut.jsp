<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="refresh" content="30">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>员工心声</title>
<script type="text/javascript" src="static/aspirations/js/tagcloud.js"></script>
<script type="text/javascript" src="static/login/js/jquery-1.5.1.min.js"></script>
<style type="text/css">
    .wrapper{ width: 1000px; height: 1024px; margin: -10 auto; }
    .tagcloud { position: relative; margin-top:150px; }
    .tagcloud a{ position: absolute;  top: 0; left: 0;  display: block; padding: 11px 30px; color: #333; font-size: 10px; border: 1px solid #e6e7e8; border-radius: 18px; background-color: #f2f4f8; text-decoration: none; white-space: nowrap;
      -o-box-shadow: 6px 4px 8px 0 rgba(151,142,136,.34);
      -ms-box-shadow: 6px 4px 8px 0 rgba(151,142,136,.34);
      -moz-box-shadow: 6px 4px 8px 0 rgba(151,142,136,.34);
      -webkit-box-shadow: 6px 4px 8px 0 rgba(151,142,136,.34);
      box-shadow: 6px 4px 8px 0 rgba(151,142,136,.34);
      -ms-filter:"progid:DXImageTransform.Microsoft.Shadow(Strength=4,Direction=135, Color='#000000')";/*兼容ie7/8*/
      filter: progid:DXImageTransform.Microsoft.Shadow(color='#969696', Direction=125, Strength=9);
      /*strength是阴影大小，direction是阴影方位，单位为度，可以为负数，color是阴影颜色 （尽量使用数字）使用IE滤镜实现盒子阴影的盒子必须是行元素或以行元素显示（block或inline-block;）*/
    }
    .tagcloud a:hover{ color: #3385cf; }
  </style>
</head>
<body  style="overflow-x: hidden; overflow-y: hidden; background: url(oapt/aspirations/images/mono.png);background-size: 100% 100%;">
<div class="wrapper">
<div class="tagcloud">



<c:choose>
	<c:when test="${not empty varList}">
		<c:forEach items="${varList}" var="var" varStatus="vs">
		
		<a><span style="word-wrap:break-word;white-space:normal;">
		${var.TAG_NAME}
		</span></a>

		</c:forEach>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>

<!-- 
$(function(){
	function show(){
		$.ajax({
			type: "POST",
			url: '<%=basePath%>monologue/list.do',
	    	data: {tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					 window.location.reload();
				 }else{

				 }
			}
		});
	}
	setInterval(show,3000);// 注意函数名没有引号和括弧！ 
	// 使用setInterval("show()",3000);会报“缺少对象” 
});


 -->

</div>
</div>
<script type="text/javascript">


    /*3D标签云*/
    tagcloud({
        selector: ".tagcloud",  //元素选择器
        fontsize: 20,       //基本字体大小, 单位px
        radius: 300,         //滚动半径, 单位px
        mspeed: "normal",   //滚动最大速度, 取值: slow, normal(默认), fast
        ispeed: "normal",   //滚动初速度, 取值: slow, normal(默认), fast
        direction: 135,     //初始滚动方向, 取值角度(顺时针360): 0对应top, 90对应left, 135对应right-bottom(默认)...
        keep: false          //鼠标移出组件后是否继续随鼠标滚动, 取值: false, true(默认) 对应 减速至初速度滚动, 随鼠标滚动
    });



</script>
</body>
</html>
