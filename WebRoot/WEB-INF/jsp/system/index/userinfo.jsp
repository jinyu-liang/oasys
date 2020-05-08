<%@ page pageEncoding="utf-8"%>
<div class="col-sm-6 widget-container-col" style="height:320px">
	<div class="widget-box transparent">
		<div class="widget-header">
			<h4 class="widget-title lighter">我的信息</h4>
			<div class="widget-toolbar no-border">
						
				<a href="#" data-action="reload">
					<i class="ace-icon fa fa-refresh" onclick="getUserReq()"></i>
				</a>
				<a  data-action="collapse">
					<i class="ace-icon fa fa-chevron-up"></i>
				</a>

				<a data-action="close">
					<i class="ace-icon fa fa-times"></i>
				</a>
			</div>
		</div>

		<div class="widget-body">
			<div class="widget-main padding-6 no-padding-left no-padding-right">
				
				<div>
					<!-- 基本信息 -->
					<div class="col-xs-12 col-sm-3 center">
						<span class="profile-picture">
						<c:choose>
							<c:when test="${user.SEX == 0 }">
								<img class="nav-user-photo img-responsive" alt="Alex's Avatar" id="avatar2" src="static/ace/avatars/profile-pic0.jpg">
							</c:when>
							<c:otherwise>
								<img class="nav-user-photo img-responsive" alt="Alex's Avatar" id="avatar2" src="static/ace/avatars/profile-pic.jpg">
							</c:otherwise>
						</c:choose>
						</span>
					
						<div class="space space-4"></div>
					</div>
					
					<div class="col-xs-12 col-sm-9">
						<h4 class="blue">
							<span class="middle"></span>
				
							<span class="label label-purple arrowed-in-right">
								<i class="ace-icon fa fa-circle smaller-80 align-middle"></i>
								online
							</span>
						</h4>
				
						<div class="profile-user-info">
							<div class="profile-info-row">
								<div class="profile-info-name "> 姓名 </div>
				
								<div class="profile-info-value">
									<span>${user.NAME}</span>
								</div>
							</div>
				
							<div class="profile-info-row">
								<div class="profile-info-name"> 工号 </div>
				
								<div class="profile-info-value">
									<i class="fa fa-map-marker light-orange bigger-110"></i>
									<span>${user.NUMBER}</span>
								</div>
							</div>
				
							<div class="profile-info-row">
								<div class="profile-info-name"> 电话 </div>
				
								<div class="profile-info-value">
									<span>${user.PHONE}</span>
								</div>
							</div>
				
							<div class="profile-info-row">
								<div class="profile-info-name"> 邮箱 </div>
				
								<div class="profile-info-value">
									<span>${user.EMAIL} </span>
								</div>
							</div>
							<div class="profile-info-row">
								<div class="profile-info-name"> 未关闭主需求 </div>
				
								<div class="profile-info-value">
									<span><a     onclick="siMenu('z80','lm79','主需求管理','reqm/reqmlist.do?STAFF_NAME=${user.NAME}')"><span id="reqm" >0</span>个</a></span>
								</div>
							</div>
							<div class="profile-info-row">
								<div class="profile-info-name"> 未关闭子需求 </div>
				
								<div class="profile-info-value">
									<span><a   onclick="siMenu('z81','lm79','子需求管理','reqplus/pluslist.do')"><span id="reqplus" >0</span>个</a></span>
								</div>
							</div>
							<div class="profile-info-row">
								<div class="profile-info-name"> 本月工作量 </div>
				
								<div class="profile-info-value">
									<span><a   onclick="siMenu('z81','lm79','子需求管理','reqplus/pluslist.do')"><span id="reqplussum" >0</span>天（已关闭）</a></span>
								</div>
							</div>
						</div>
				
						<div class="hr hr-8 dotted"></div>
				
						
					</div>
					<!-- 基本信息 -->
				</div>
			</div>
		</div>
	</div>

</div>
<script type="text/javascript" src="static/user/userreq.js"></script>