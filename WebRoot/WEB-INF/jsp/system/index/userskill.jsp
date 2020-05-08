<%@ page pageEncoding="utf-8"%>
<div class="col-sm-6 widget-container-col" style="height:320px">
	<div class="widget-box transparent">
		<div class="widget-header">
			<h4 class="widget-title lighter"><i class="ace-icon fa fa-lightbulb-o bigger-120"></i>我的技能</h4>
			<div class="widget-toolbar no-border">
				<a href="#" data-action="reload">
					<i class="ace-icon fa fa-refresh" onclick="getUserskill()"></i>
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
						<div class="widget-body">
							<div class="widget-main padding-16">
								<div class="clearfix">
									<div class="grid5 center">
										<!-- #section:plugins/charts.easypiechart -->
										<div id="A1" class="easy-pie-chart percentage" data-percent="0" data-color="#CA5952"  onclick="getSkill('1');"  style="cursor:pointer">
											<span class="percent" id="A11">0</span>%</div>
										<div class="space-5"></div>
										业务能力
									</div>
						
									<div class="grid5 center">
										<div id="A2" class="center easy-pie-chart percentage" data-percent="0" data-color="#59A84B" onclick="getSkill('2');"  style="cursor:pointer">
											<span class="percent" id="A22">0</span>%</div>
						
										<div class="space-5"></div>
										技术能力
									</div>
						
									<div class="grid5 center">
										<div id="A3" class="center easy-pie-chart percentage" data-percent="0" data-color="#9585BF" >
											<span class="percent" id="A33">0</span>%</div>
						
										<div class="space-5"></div>
										沟通协调能力
									</div>
									<div class="grid5 center">
										<div id="A4" class="center easy-pie-chart percentage" data-percent="0" data-color="#ac725e" >
											<span class="percent" id="A44">0</span>%</div>
						
										<div class="space-5"></div>
										创新能力
									</div>
									<div class="grid5 center">
										<div id="A5" class="center easy-pie-chart percentage" data-percent="0" data-color="#92e1c0" >
											<span class="percent" id="A55">0</span>%</div>
						
										<div class="space-5"></div>
										学习能力
									</div>
								</div>
						
								<div class="hr hr-16"></div>
						
								<!-- #section:pages/profile.skill-progress -->
								<div class="profile-skills" ><span  id="b1"></span></div>
							</div>
						</div>
			</div>
		</div>
	</div>

</div>
<script type="text/javascript" src="static/user/userskill.js"></script>
