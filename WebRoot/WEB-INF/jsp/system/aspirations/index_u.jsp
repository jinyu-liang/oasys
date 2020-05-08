<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<meta http-equiv="refresh" content="300">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>员工风采</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<link rel="stylesheet" href="static/aspirations/css/public.css" />
<link rel="stylesheet" type="text/css" href="static/aspirations/css/index.css" />
<script type="text/javascript" src="static/aspirations/js/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="static/aspirations/js/zturn.js"></script>
</head>
<body style="overflow-x: hidden; overflow-y: hidden;">

	<!--轮播-->
	<div class="lb_gl">
		<div class="container">
			<h1 class="turn_3d">天津PSO团队</h1>
			<div class="pictureSlider poster-main">
				<div class="poster-btn poster-prev-btn"></div>

				<ul id="zturn" class="poster-list">
					<c:choose>
						<c:when test="${not empty varList}">
							<c:forEach items="${varList}" var="var" varStatus="vs">
								<li class="poster-item  zturn-item">
									<p class="xxgy">${var.TITLE}</p>
									<div class="for_btn">
										<c:if test="${not empty var.PATH}">
										 <img src="<%=basePath%>uploadFiles/uploadImgs/${var.NAME}" alt="${var.TITLE}" style="width:1024px;">
										</c:if>
									</div>
									<div class="students_star">
										<div class="zwjs">${var.BZ}</div>
									</div>
								</li>
							</c:forEach>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</ul>

			</div>
		</div>
	</div>
	<!--轮播-->
	<script type="text/javascript">
		var aa = new zturn({
			id : "zturn",
			opacity : 0.7, //其他图片虚化
			width : 1024,
			Awidth : 1024,
			scale : 0.9,  //其他图片变小
			auto : true,//是否轮播 默认5000
			turning : 3000
		//轮播时长
		})
		var ab = new zturn({
			id : "zturn2",
			opacity : 0.8,
			width : 900,
			Awidth : 1024,
			scale : 0.6,
			auto : true
		})
	</script>
</body>
</html>