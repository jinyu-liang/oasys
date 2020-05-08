<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <meta charset="utf-8" />
    <title>${pd.SYSNAME}</title>
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css" />



    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp"%>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css" />


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
                        <form action="sortplan/list.do" method="post" name="Form" id="Form">

                            <%--<table style="margin-top:5px;">--%>
                                <%--<tr>--%>
                                    <%--<td>--%>
                                        <%--<div class="nav-search">--%>
										<%--<span class="input-icon">--%>
											<%--<input type="text" placeholder="这里输入标题关键字" class="nav-search-input" id="nav-search-input" autocomplete="off" name="BK_TITLE" value="${pd.BK_TITLE}" placeholder="这里输入关键词"/>--%>
											<%--<i class="ace-icon fa fa-search nav-search-icon"></i>--%>
										<%--</span>--%>
                                        <%--</div>--%>
                                    <%--</td>--%>
                                    <%--<td style="padding-left:2px;"><input class="span10 date-picker" name="startTime" id="startTime"  value="${pd.startTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>--%>
                                    <%--<td style="padding-left:2px;"><input class="span10 date-picker" name="endTime" name="endTime"  value="${pd.endTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>--%>
                                    <%--<td style="width:150px;">--%>
                                        <%--<select class="chosen-select form-control" name="BK_PROCESS_P" id="BK_PROCESS_P" data-placeholder="请选择故障处理人" style="vertical-align:top;" style="width:200px;" >--%>
                                            <%--<option value=""></option>--%>
                                            <%--<option value="">全部故障处理人</option>--%>
                                        <%--<c:forEach items="${userList}" var="user">--%>
                                            <%--<option value="${user.USERNAME}" <c:if test="${user.USERNAME == pd.BK_PROCESS_P }">selected</c:if>>${user.NAME }</option>--%>
                                        <%--</c:forEach>--%>
                                        <%--</select>--%>
                                    <%--</td>--%>
                                    <%--<td style="width:150px;">--%>
                                        <%--<select class="chosen-select form-control" name="BK_REPORT_P" id="BK_REPORT_P" data-placeholder="请选择故障报告人" style="vertical-align:top;" style="width:200px;" >--%>
                                            <%--<option value=""></option>--%>
                                            <%--<option value="">全部故障报告人</option>--%>
                                            <%--<c:forEach items="${userList}" var="user">--%>
                                                <%--<option value="${user.USERNAME}" <c:if test="${user.USERNAME == pd.BK_REPORT_P }">selected</c:if>>${user.NAME }</option>--%>
                                            <%--</c:forEach>--%>
                                        <%--</select>--%>
                                    <%--</td>--%>

                                    <%--<td style="width:130px;">--%>
                                        <%--<select class="chosen-select form-control" name="BK_SUBSYS" id="BK_SUBSYS" data-placeholder="请选择子系统" style="vertical-align:top;" style="width:150px;" >--%>
                                            <%--<option value=""></option>--%>
                                            <%--<option value="">全部系统</option>--%>
                                            <%--<c:forEach items="${subsysList}" var="subsys">--%>
                                                <%--<option value="${subsys.SUBSYS_ID}" <c:if test="${pd.BK_SUBSYS  ==subsys.SUBSYS_ID }">selected</c:if>>${subsys.SUBSYS_NAME }</option>--%>
                                            <%--</c:forEach>--%>
                                        <%--</select>--%>
                                    <%--</td>--%>
                                    <%--<td style="width:130px;">--%>
                                        <%--<select class="chosen-select form-control" name="BK_REP_STATUS" id="BK_REP_STATUS" data-placeholder="状态" style="vertical-align:top;width: 79px;">--%>
                                            <%--<option value=""></option>--%>
                                            <%--<option value="">全部</option>--%>
                                            <%--<option value="0" <c:if test="${pd.BK_REP_STATUS == '0' }">selected</c:if> >故障报告登记</option>--%>
                                            <%--<option value="1" <c:if test="${pd.BK_REP_STATUS == '1' }">selected</c:if> >提交审核</option>--%>

                                            <%--<option value="2" <c:if test="${pd.BK_REP_STATUS == '2' }">selected</c:if> >审核不通过</option>--%>
                                            <%--<option value="3" <c:if test="${pd.BK_REP_STATUS == '3' }">selected</c:if> >审核通过</option>--%>
                                        <%--</select>--%>
                                    <%--</td>--%>

                                    <%--<c:if test="${QX.cha == 1 }">--%>
                                        <%--<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchB();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>--%>
                                    <%--</c:if>--%>

                                <%--</tr>--%>
                            <%--</table>--%>
                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
                                <thead>
                                <tr>
                                    <th class="center" style="width:35px;">
                                        <label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
                                    </th>
                                    <th class="center">序号</th>
                                    <th class="center">培训ID</th>
                                    <th class="center">培训标题</th>
                                    <th class="center">培训人</th>
                                    <th class="center">开始时间</th>
                                    <th class="center">结束时间</th>
                                    <th class="center">签到状态</th>
                                    <th class="center">签到</th>
                                    <th class="center">操作</th>
                                </tr>
                                </thead>

                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                <c:when test="${not empty allsortplanList}" >
                                <c:if test="${QX.cha == 1 }">
                                <c:forEach items="${allsortplanList}" var="var" varStatus="vs">
                                <tr>
                                    <td class='center'>
                                        <label><input type='checkbox' name='ids' class="ace" value="${var.SP_ID}" /><span class="lbl"></span></label>
                                    </td>
                                    <td class='center'>${vs.index+1}</td>
                                    <td class="center">${var.SP_ID}</td>
                                    <td class="cneter">
                                        <a  onclick="cha('${var.SP_ID}');">${var.SP_TITLE}</a>
                                    </td>
                                    <td class="center">${var.SP_PERSON}</td>
                                    <td class="center">${var.SP_STARTTIME}</td>
                                    <td class="center">${var.SP_ENDTIME}</td>
                                    <td class="center">
                                        <c:if test="${var.SP_STATUS!=NULL}">签到</c:if>
                                        <c:if test="${var.SP_STATUS==NULL}">未签到</c:if>
                                    </td>
                                    <td>
                                        <c:if test="${var.SP_STATUS==NULL }">
                                        <label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio" id="form-field-radio1" onclick="setType('${var.SP_ID}');"
                                                                                             <c:if test="${ pd.SP_STATUS != NULL}">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">签到</span></label>
                                        </c:if>
                                    </td>


                                    <td class="center">
                                        <c:if test="${QX.edit != 1 && QX.del != 1 }">
                                            <span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
                                        </c:if>
                                        <c:if test="${QX.edit == 1 }">
                                            <a style="cursor:pointer;" class="green" onclick="edit('${var.SP_ID}');" title="编辑">
                                                <i class="ace-icon fa fa-pencil bigger-130"></i>
                                            </a>
                                        </c:if>
                                        &nbsp;
                                        <c:if test="${QX.del == 1 }">
                                            <a style="cursor:pointer;" class="red" onclick="del('${var.SP_ID}');" title="删除">
                                                <i class="ace-icon fa fa-trash-o bigger-130"></i>
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>


                                </c:forEach>
                                </c:if>
                                </c:when>
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
                                                <a title="批量删除" class="btn btn-sm btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
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
</body>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态
    //检索

    function search(){
        top.jzts();
        $("#Form").submit();
    }


    function setType(Id){
            top.jzts();
            var url = "<%=basePath%>sortplan/signin.do?SP_ID="+Id;
            $.get(url,function(data){
                nextPage(${page.currentPage});
            });


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


    //增加
    function add() {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="新增";
        diag.URL = '<%=basePath%>sortplan/goAddS.do';
        diag.Width = 600;
        diag.Height = 490;
        diag.CancelEvent = function(){ //关闭事件
            if('${page.currentPage}' == '0'){
                top.jzts();
                setTimeout("self.location=self.location",100);
            }else{
                nextPage(${page.currentPage});
            }
            diag.close();
        };
        diag.show();

    }

    //删除
    function del(Id){
        if(confirm("确定要删除?")){
            top.jzts();
            var url = "<%=basePath%>sortplan/deleteS.do?SP_ID="+Id;
            $.get(url,function(data){
                nextPage(${page.currentPage});
            });

        }

    }

    function cha(Id){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="详细信息";
        diag.URL = '<%=basePath%>sortplan/gochaS.do?SP_ID='+Id;
        diag.Width = 600;
        diag.Height = 465;

        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){

                nextPage(${page.currentPage});
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
        diag.URL = '<%=basePath%>sortplan/goEditS.do?SP_ID='+Id;
        diag.Width = 600;
        diag.Height = 465;

        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){

                nextPage(${page.currentPage});
            }
            diag.close();
        };

        diag.show();
    }
    <%--//批量操作--%>
    <%--function makeAll(msg){--%>
        <%--if(confirm(msg)){--%>
            <%--var str = '';--%>
            <%--for(var i=0;i < document.getElementsByName('ids').length;i++)--%>
            <%--{--%>
                <%--if(document.getElementsByName('ids')[i].checked){--%>
                    <%--if(str=='') str += document.getElementsByName('ids')[i].value;--%>
                    <%--else str += ',' + document.getElementsByName('ids')[i].value;--%>
                <%--}--%>
            <%--}--%>
            <%--if(str==''){--%>
                <%--alert("您没有选择任何内容!");--%>
                <%--return;--%>
            <%--}else{--%>
                <%--if(msg == '确定要删除选中的数据吗?'){--%>
                    <%--top.jzts();--%>
                    <%--$.ajax({--%>
                        <%--type: "POST",--%>
                        <%--url: '<%=basePath%>breakdown/deleteAll.do?tm='+new Date().getTime(),--%>
                        <%--data: {DATA_IDS:str},--%>
                        <%--dataType:'json',--%>
                        <%--//beforeSend: validateData,--%>
                        <%--cache: false,--%>
                        <%--success: function(data){--%>
                            <%--$.each(data.list, function(i, list){--%>
                                <%--nextPage(${page.currentPage});--%>
                            <%--});--%>
                        <%--}--%>
                    <%--});--%>
                <%--}--%>
            <%--}--%>
        <%--}--%>
    <%--}--%>


</script>
<style type="text/css">
    li {list-style-type:none;}
</style>
<ul class="navigationTabs">
    <li><a></a></li>
    <li></li>
</ul>

</html>