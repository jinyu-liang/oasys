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
<script type="text/javascript" src="static/js/myjs/head.js"></script>
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link rel="stylesheet" href="static/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-md-12 form-horizontal">
						<form action="reqm/${msg }.do" method="post" name="Form" id="Form" class="form-horizontal">
							


						<div class="tabbable">
							<ul class="nav nav-tabs padding-16">
								<li class="active">
									<a data-toggle="tab" href="#edit-basic">
										<i class="green ace-icon fa fa-pencil-square-o bigger-125"></i>
										主需求信息
									</a>
								</li>
								<c:if test="${not empty pd.REQ_ID}">
								<li>
									<a data-toggle="tab" href="#edit-settings">
										<i class="purple ace-icon fa fa-gavel bigger-125"></i>
										需求评审
									</a>
								</li>
								<li>
									<a data-toggle="tab" href="#edit-password">
										<i class="blue ace-icon fa fa-pencil bigger-125"></i>
										代码评审
									</a>
								</li>
								</c:if>
							</ul>

							<div class="tab-content profile-edit-tab-content">
								<div id="edit-basic" class="tab-pane in active">
										<h4 class="header blue bolder smaller">General</h4>
										<div class="form-group">
											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="REQ_ID"><i class=" fa fa-asterisk light-red"></i>需求编码:</label>
											<div class="col-sm-3">
													<input type="text" id="REQ_ID" name="REQ_ID" placeholder="需求编码" value="${pd.REQ_ID }" class="form-control"/>
											</div>

											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="REQ_TITLE"><i class="menu-icon fa fa-asterisk light-red"></i>需求名称:</label>
											<div class="col-sm-3">
													<input type="text" id="REQ_TITLE" name="REQ_TITLE" placeholder="需求名称" value="${pd.REQ_TITLE }" class="form-control"/>
											</div>
											
											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="REQ_SDPID"><i class="menu-icon fa fa-asterisk light-red"></i>本地需求编码:</label>
											<div class="col-sm-3">
													<input type="text" id="REQ_SDPID" name="REQ_SDPID"  placeholder="本地需求编码" value="${pd.REQ_SDPID }" class="form-control"/>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="MOBOLE_STAFF"><i class=" fa fa-asterisk light-red"></i>IT负责人:</label>
											<div class="col-sm-3">
													<input type="text" id="MOBOLE_STAFF" name="MOBOLE_STAFF" placeholder="IT负责人" value="${pd.MOBOLE_STAFF }" class="form-control"/>
											</div>

											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="STAFF_NAME"><i class="menu-icon fa fa-asterisk light-red"></i>需求开发人:</label>
											<div class="col-sm-3">
													<select class="chosen-select form-control" name="STAFF_NAME" id="STAFF_NAME" data-placeholder="请选择" placeholder="需求开发人" style="vertical-align:top;width: 98%;">
														<option value=""></option>
														<c:forEach items="${userlist}" var="var" varStatus="vs">
														<option value="${var.NAME }" <c:if test="${var.NAME == pd.STAFF_NAME }">selected</c:if>>${var.NAME } </option>
														</c:forEach>
												  	</select>
											</div>
											

											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="REQ_STATE"><i class=" fa fa-asterisk light-red"></i>需求状态:</label>
											<div class="col-sm-3"  >
													<select class="chosen-select form-control" name="REQ_STATE" id="REQ_STATE" placeholder="需求状态" data-placeholder="请选择类型"  <c:if test="${pd.REQ_STATE != null }">disabled</c:if>>
														<option value=""></option>
														<c:forEach items="${reqstatlist}" var="var">
															<option value="${var.P_VALUE}"  <c:if test="${var.P_VALUE == pd.REQ_STATE }">selected</c:if> >${var.P_NAME }</option>
														</c:forEach>
													 </select>
											</div>		

											
										</div>
										
										<div class="form-group">

											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="DEVELOP_FINISH_DATE"><i class="menu-icon fa fa-asterisk light-red"></i>开发完成时间:</label>
											<div class="col-sm-3">
													<div class="input-group">
														<input class="form-control date-picker" id="DEVELOP_FINISH_DATE" name="DEVELOP_FINISH_DATE" placeholder="开发完成时间" value="${pd.DEVELOP_FINISH_DATE}"  type="text" data-date-format="yyyy-mm-dd">
														<span class="input-group-addon">
															<i class="fa fa-calendar bigger-110"></i>
														</span>
													</div>
											</div>

											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="ONLINE_DATE"><i class="menu-icon fa fa-asterisk light-red"></i>计划上线时间:</label>
											<div class="col-sm-3">
													<div class="input-group">
														<input class="form-control date-picker" id="ONLINE_DATE" name="ONLINE_DATE" value="${pd.ONLINE_DATE}"  placeholder="计划上线时间" type="text" data-date-format="yyyy-mm-dd">
														<span class="input-group-addon">
															<i class="fa fa-calendar bigger-110"></i>
														</span>
													</div>
											</div>
											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="REQ_TYPE"><i class="menu-icon fa fa-asterisk light-red"></i>需求类别:</label>
											<div class="col-sm-3">
													<select class="chosen-select form-control" name="REQ_TYPE" id="REQ_TYPE" data-placeholder="请选择类型"  placeholder="需求类别">
														<option value=""></option>
														<c:forEach items="${reqstatrolelist}" var="var">
															<option value="${var.P_VALUE}"  <c:if test="${var.P_VALUE == pd.REQ_TYPE }">selected</c:if> >${var.P_NAME }</option>
														</c:forEach>
													 </select>
											</div>										
										</div>
										<div class="form-group">
											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="REQ_NOTE"><i class="menu-icon fa fa-asterisk light-red"></i>需求描述:</label>
											<div class="col-sm-7">
													<textarea rows="10" id="REQ_NOTE" name="REQ_NOTE" placeholder="需求描述" class="form-control">${pd.REQ_NOTE}</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-1 control-label no-padding-right text-nowrap" for="REMARK"><i class=""></i>备注:</label>
											<div class="col-sm-7">
													<input type="text" id="REMARK" name="REMARK"  placeholder="备注" value="${pd.REMARK}" class="form-control"/>
											</div>
										</div>
										
								</div>
							<c:if test="${not empty pd.REQ_ID}">
								<div id="edit-settings" class="tab-pane">
									<h4 class="header blue bolder smaller">General</h4>
									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right" for="REVIEWS">需求评审标准:</label>
										<div class="col-sm-8">
												<div class="tabbable tabs-left">
												<ul class="nav nav-tabs" id="myTab3">
													<li class="active">
														<a data-toggle="tab" href="#home1"><i class="pink ace-icon fa fa-tachometer bigger-110"></i>组织和完整性</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home2"><i class="blue ace-icon fa fa-user bigger-110"></i>正确性</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home3"><i class="red ace-icon fa fa-beer"></i>质量属性</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home4"><i class="yellow ace-icon fa  fa-key"></i>可跟踪性</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home5"><i class="pink ace-icon fa fa-gavel"></i>其他问题</a>
													</li>
												
												</ul>
											
												<div class="tab-content">
													<div id="home1" class="tab-pane in active">
													<p>1、所有对其它需求的内部交叉引用是否正确？</p>
													<p>2、所有需求的编写在细节上是否都一致或者合适？                </p>
													<p>3、需求是否能为设计提供足够的基础？        </p>
													<p>4、是否包括了每个需求的实现优先级？  </p>
													<p>5、是否定义了所有外部软件和通信接口？          </p>
													<p>6、是否定义了功能需求内在的算法？             </p>
													<p>7、软件需求规格说明中是否包括了局方需求文档的内容？      </p>
													<p>8、是否在需求中遗漏了必要的信息？如果有的话，就把它们标记为待确定的问题。          </p>
													<p>9、是否记录了所有可能的错误条件所产生的系统行为？          </p>
													</div>
													
													<div id="home2" class="tab-pane">
													<p>1、是否有需求与其它需求相冲突或重复？                  </p>
													<p>2、是否简明、简洁、无二义性地表达了每个需求？                               </p>
													<p>3、是否每个需求都能通过测试、演示、审查得以验证或分析？                      </p>
													<p>4、是否每个需求都在项目的范围内？                                                                        </p>
													<p>5、是否每个需求都没有内容上和语法上的错误？                                                            </p>
													<p>6、在现有的资源限制内，是否能实现所有的需求？                                </p>
													<p>7、是否任一个特定的错误信息都具有唯一性和明确的意义？                                                   </p>
													</div>
													
													<div id="home3" class="tab-pane">
													<p>1、是否合理地确定了性能目标？                                                                        </p>
													<p>2、是否合理地确定了安全与保密方面的考虑？                                              </p>
													<p>3、在确定了合理的折衷情况下，是否详实地记录了其它相关的质量属性？                                                        </p>
													</div>
													
													<div id="home4" class="tab-pane">
													<p>1、是否每个需求都具有唯一性并且可以正确地识别它？                                                                         </p>
													<p>2、是否可以根据高层需求（如系统需求或使用案例（用例））跟踪到软件功能需求？                                                                      </p>
													</div>
													
													<div id="home5" class="tab-pane">
													<p>1、是否所有的需求都是名副其实的需求而不是设计或实现方案？                                                                   </p>
													<p>2、是否确定了对时间要求很高的功能并且定义了它们的时间标准？                                                            </p>
													<p>3、是否已经明确地阐述了国际化问题？                                                          </p>
													
													</div>
													
												
												</div>
											</div>
											</div>
									</div>
										
									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right " for="REV_CONT"><i class="menu-icon fa fa-asterisk light-red"></i>需求评审及问题:</label>
										<div class="col-sm-8">
												<textarea rows="2" id="REV_CONT" name="REV_CONT" placeholder="需求评审及问题" class="form-control">${pd.REV_CONT}</textarea>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right" for="REVIEW_STAFF"><i class="menu-icon fa fa-asterisk light-red"></i>需求评审人:</label>
										<div class="col-sm-2 ">
												<select class="form-control" id="REVIEW_STAFF" name="REVIEW_STAFF" data-placeholder="请选择..." placeholder="需求评审人">
															<option value="">  </option>
															<option value="张海舟" <c:if test="${'张海舟' == pd.REVIEW_STAFF }">selected</c:if>>张海舟</option>
															<option value="阚亮" <c:if test="${'阚亮' == pd.REVIEW_STAFF }">selected</c:if>>阚亮</option>
															<option value="齐飞" <c:if test="${'齐飞' == pd.REVIEW_STAFF }">selected</c:if>>齐飞</option>
															<option value="刘军" <c:if test="${'刘军' == pd.REVIEW_STAFF }">selected</c:if>>刘军</option>
															<option value="李志刚" <c:if test="${'李志刚' == pd.REVIEW_STAFF }">selected</c:if>>李志刚</option>
															
												</select>
										</div>
									</div>
								</div>

								<div id="edit-password" class="tab-pane">
									<h4 class="header blue bolder smaller">General</h4>
									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right" for="form-field-pass1">代码评审标准：</label>

										<div class="col-sm-8">
											
												<div class="tabbable tabs-left">
												<ul class="nav nav-tabs" id="myTab3">
													<li class="active">
														<a data-toggle="tab" href="#home11"><i class="pink ace-icon fa fa-tachometer bigger-110"></i>检查项</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home21"><i class="blue ace-icon fa fa-user bigger-110"></i>变量/常量</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home31"><i class="red ace-icon fa fa-beer"></i>算法</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home41"><i class="yellow ace-icon fa  fa-key"></i>控制</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home51"><i class="pink ace-icon fa fa-gavel"></i>设计</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home61"><i class="orange ace-icon fa fa-flag"></i>效率</a>
													</li>
													<li>
														<a data-toggle="tab" href="#home71"><i class="green ace-icon fa fa-circle"></i>SQL</a>
													</li>
												</ul>
	
												<div class="tab-content">
													<div id="home11" class="tab-pane in active">
													<p>1、程序是否明确地注释了其实现功能   </p>
													<p>2、注释格式是否正确                 </p>
													<p>3、程序单元是否承担单一职责         </p>
													<p>4、复杂程序是否合理地分解为子程序   </p>
													<p>5、程序中接口定义是否明晰           </p>
													<p>6、异常处理是否符合规范             </p>
													<p>7、包名、类名命名是否符合规范       </p>
													<p>8、方法名命名是否符合规范           </p>
													</div>
													
													<div id="home21" class="tab-pane">
													<p>1、相关系列变量是否统一集中声明，自定义数据类型变量是否进行了必要而充分的描述                   </p>
													<p>2、变量是否按相关规范进行了命名（有意义的命名、数据类型的区分等）                               </p>
													<p>3、变量是否按其命名含义承担了单一的使用目的，必要时是否清晰定义了额外变量                       </p>
													<p>4、变量引用是否正确关闭                                                                         </p>
													<p>5、常量是否使用getter/setter方法访问                                                            </p>
													<p>6、是否应用良好定义的枚举类型替代了简单的字符标识或布尔变量使用                                 </p>
													<p>7、UFBoolean是否使用UFBoolean构造函数进行构造                                                   </p>
													<p>8、处理可变String时是否未使用StringBuffer                                                       </p>
													<p>9、是否优先使用wade框架提供的容器（DataMap,DatasetList）来处理顺序结构、集合、关联数组合堆栈队列</p>
													<p>10、对数组的使用场景是否正确                                                                    </p>
													<p>11、对于public尽量谨慎使用                                                                      </p>
													<p>12、不同作用域变量名称尽量不要相同                                                              </p>
													</div>
													
													<div id="home31" class="tab-pane">
													<p>1、数据结构是否合理、精简                                                                        </p>
													<p>2、算法是否可以独立测试，是否与数据库和其他算法隔离                                              </p>
													<p>3、获取此页面内容是否尽量避免了嵌套的运用                                                        </p>
													<p>4、复杂逻辑是否进行了必要而充分的注释                                                            </p>
													</div>
													
													<div id="home41" class="tab-pane">
													<p>1、代码执行路径是否清晰                                                                          </p>
													<p>2、Switch语句是否有缺省分支                                                                      </p>
													<p>3、控制逻辑复杂度是否合理，是否进行了必要而充分的注释                                            </p>
													<p>4、每个循环体是否仅执行了单一而明确的功能                                                        </p>
													<p>5、与常数比较需要将常数放在比较表达式的前面                                                      </p>
													</div>
													
													<div id="home51" class="tab-pane">
													<p>1、程序是否可读、可扩展并健壮                                                                    </p>
													<p>2、具体实现细节是否已尽可能的“隐藏”                                                            </p>
													<p>3、是否优先使用接口而不是抽象类或具体类                                                          </p>
													<p>4、方法参数是否在5个以内                                                                         </p>
													<p>5、方法慎用public修饰符                                                                          </p>
													<p>6、对于不需要子类来重载的类尽量使用final                                                         </p>
													<p>7、对象作用域是否过大                                                                            </p>
													</div>
													
													<div id="home61" class="tab-pane">
													<p>1、尽量不要在循环内出现远程调用                                                                  </p>
													<p>2、每个业务动作远程调用次数是否小于3次                                                           </p>
													<p>3、远程调用数据传输是否有不必要的冗余数据                                                        </p>
													
													</div>
													
													<div id="home71" class="tab-pane">
													<p>1、Sql语句大写                                                                                   </p>
													<p>2、引用字符使用单引号                                                                            </p>
													<p>3、严禁使用select * 形式的语句，必须指出具体字段                                                 </p>
													<p>4、严禁使用insert into table values（？，？，？），必须指出具体要赋值的字段                      </p>
													<p>5、避免隐含的类型转换（不同数据类型字段相加）                                                    </p>
													<p>6、子查询前后必须加上括号                                                                        </p>
													<p>7、避免在where使用’1=2’这种表达方式作为部分条件                                                </p>
													<p>8、禁止使用视图                                                                                  </p>
													<p>9、禁止使用XXin()orXXin()(in中的元素个数不应超过500)                                             </p>
													<p>10、禁止使用or超过500个                                                                          </p>
													<p>11、禁止使用not in，建议使用not exist                                                            </p>
													<p>12、禁止在一条sql语句中使用3层以上的嵌套                                                         </p>
													<p>13、如果有多表连接时，应该有主从之分，尽量从一个表取数                                           </p>
													<p>14、Where子句过滤条件，索引列或过滤记录最多的条件应该放在前面                                    </p>
													<p>15、字符串连接必须使用“||”                                                                     </p>
													<p>16、Case when语句中只能出现=、>=、<=以及is null运算符                                            </p>
													<p>17、左连接写法必须带”outer”关键字                                                              </p>
													<p>18、获取此页面内容Sql中函数是否在指定范围内                                                      </p>
													<p>19、Join与on必须严格匹配                                                                         </p>
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right" for="CODE_NAME"><i class="menu-icon fa fa-asterisk light-red"></i>代码评审及问题:</label>
										<div class="col-sm-8">
												<textarea rows="2" id="CODE_NAME" name="CODE_NAME" placeholder="代码评审及问题" class="form-control">${pd.CODE_NAME}</textarea>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right" for="CODE_STAFF"><i class="menu-icon fa fa-asterisk light-red"></i>代码评审人:</label>
										<div class="col-sm-2">
												<select class="form-control" id="CODE_STAFF" name="CODE_STAFF" data-placeholder="请选择..."  placeholder="代码评审人">
															<option value="">  </option>
															<option value="张海舟"  <c:if test="${'张海舟' == pd.CODE_STAFF }">selected</c:if> >张海舟</option>
															<option value="阚亮" <c:if test="${'阚亮' == pd.CODE_STAFF }">selected</c:if> >阚亮</option>
															<option value="齐飞" <c:if test="${'齐飞' == pd.CODE_STAFF }">selected</c:if> >齐飞</option>
															<option value="刘军" <c:if test="${'刘军' == pd.CODE_STAFF }">selected</c:if> >刘军</option>
															<option value="李志刚" <c:if test="${'李志刚' == pd.CODE_STAFF }">selected</c:if> >李志刚</option>
															
												</select>
										</div>
									</div>
								</div>
							</c:if>
							</div>
						</div>
						<!-- N02安排-N04设计-N07开发-N08测试-N09上线-N10关闭 -->
						<div class="clearfix form-actions center">
						<input type="hidden" id="H_REQ_STAT" name="H_REQ_STAT" value=""  >
							<c:if test="${empty pd.REQ_ID && QX.add == 1}">
								<button class="btn btn-info btn-success" type="button" onclick="save()">
									新增需求
									<i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
								</button>
							</c:if>
							<c:if test="${not empty pd.REQ_ID && QX.add == 1 }">	
								&nbsp; &nbsp;
								<button class="btn btn-info btn-success" type="button" onclick="siMenu('reqplus_edit','reqplus_edit','新增子需求','reqplus/editReqPlusInfo.do?REQ_SDPID=${pd.REQ_SDPID}')">
									新增子需求
									<i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
								</button>	
							</c:if>
							<c:if test="${not empty pd.REQ_ID && ( QX.edit == 1 || user.NAME == pd.STAFF_NAME) }">	
							    
							    &nbsp; &nbsp;
								<button class="btn btn-info" type="button" onclick='edit("0")'>
									<i class="ace-icon fa fa-pencil-square-o bigger-110"></i>
									更新需求
								</button>
								
								<c:if test="${pd.REQ_STATE == '02' }">
									&nbsp; &nbsp;
									<button class="btn btn-primary" type="button" onclick='edit("04")'>
										<i class="ace-icon fa fa-arrow-right bigger-110"></i>
										需求分析设计
									</button>
								</c:if>
								<c:if test="${pd.REQ_STATE == '04' }">
									&nbsp; &nbsp;
									<button class="btn btn-primary" type="button" onclick='edit("07")'>
										<i class="ace-icon fa fa-arrow-right bigger-110"></i>
										需求开发
									</button>
								</c:if>
								<c:if test="${pd.REQ_STATE == '07' }">
									&nbsp; &nbsp;
									<button class="btn btn-primary" type="button" onclick='edit("08")'>
										<i class="ace-icon fa fa-arrow-right bigger-110"></i>
										需求测试
									</button>
								</c:if>
								<c:if test="${pd.REQ_STATE == '08' }">
									&nbsp; &nbsp;
									<button class="btn btn-primary" type="button" onclick='edit("09")'>
										<i class="ace-icon fa fa-arrow-right bigger-110"></i>
										需求上线
									</button>
								</c:if>
								<c:if test="${pd.REQ_STATE == '09' }">
									&nbsp; &nbsp;
									<button class="btn btn-success" type="button" onclick='edit("10")'>
										<i class="ace-icon fa fa-arrow-right bigger-110"></i>
										需求关闭
									</button>
								</c:if>
								
								
								&nbsp; &nbsp;
								<button class="btn" type="reset" id="N11" value="11" onclick="edit('11')">
									<i class="ace-icon fa fa-close bigger-110"></i>
									需求强制关闭
								</button>
								&nbsp; &nbsp;
								<button class="btn" type="reset" id="N12" value="12" onclick="edit('12')">
									<i class="ace-icon fa fa-close bigger-110"></i>
									需求取消
								</button>
							</c:if>
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
	<%@ include file="../system/index/foot.jsp"%>
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
	
		
		function chkelement(obj){
			if(obj.val()==""){
				obj.tips({
					side:3,
		            msg:obj.attr("placeholder")+"不能为空",
		            bg:'#AE81FF',
		            time:2
		        });
				obj.focus();
				return false;
			}else{
				return true;
			}
		}
		//保存
		function save(){
			var c = chkelement($("#REQ_ID")) && chkelement($("#REQ_TITLE")) && chkelement($("#REQ_SDPID")) &&
			chkelement($("#MOBOLE_STAFF")) && chkelement($("#STAFF_NAME")) && chkelement($("#REQ_STATE")) &&
			chkelement($("#DEVELOP_FINISH_DATE")) && chkelement($("#ONLINE_DATE")) && chkelement($("#REQ_TYPE")) &&
			chkelement($("#REQ_NOTE"));
			if(c){
				top.jzts();
				$("#Form").submit();
			}
		}
		
		
		function edit(n){
			
			
			$('#REQ_STATE').removeAttr("disabled");
			var c = chkelement($("#REQ_ID")) && chkelement($("#REQ_TITLE")) && chkelement($("#REQ_SDPID")) &&
			chkelement($("#MOBOLE_STAFF")) && chkelement($("#STAFF_NAME")) && chkelement($("#REQ_STATE")) &&
			chkelement($("#DEVELOP_FINISH_DATE")) && chkelement($("#ONLINE_DATE")) && chkelement($("#REQ_TYPE")) &&
			chkelement($("#REQ_NOTE"));
			if(c){
				if("0" == n){}
				else if("11" == n || "12" == n  || "13" == n ){
					$("#H_REQ_STAT").val(n);
				}else if("04" == n){
					if(!(chkelement($("#REV_CONT")) && chkelement($("#REVIEW_STAFF")))){
						return;
					}else{
						$('#REQ_STATE').val(n);
					}
				}else if("07" == n){
					if(!(chkelement($("#CODE_NAME")) && chkelement($("#CODE_STAFF")))){
						return;
					}else{
						$('#REQ_STATE').val(n);
					}
				}else{
					if(!(chkelement($("#CODE_NAME")) && chkelement($("#CODE_STAFF")) && chkelement($("#REV_CONT")) && chkelement($("#REVIEW_STAFF")))){
						return;
					}else{
						$('#REQ_STATE').val(n);
					}
				}
				top.jzts();
				$("#Form").submit();
			}
		}
	</script>


</body>
</html>