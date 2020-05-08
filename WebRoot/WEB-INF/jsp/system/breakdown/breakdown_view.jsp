<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css" />
    <!-- jsp文件头和头部 -->
    <%@ include file="../index/top.jsp"%>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css" /><!-- 日期框 -->

    <script type="text/javascript">
        //保存




    </script>
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
                        <form action="breakdown/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="BK_ID" id="BK_ID" value="${pd.BK_ID}"/>
                            <div id="zhongxin" style="padding-top: 13px;">
                            <input type="hidden" name="msg" id="msg" value="${pd.msg}"/>


                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">故障标题:</td>
                                        <td>
                                            <input style="width:95%;" type="text" name="BK_TITLE" id="BK_TITLE" disabled="disabled" value="${pd.BK_TITLE}" maxlength="500" placeholder="这里输入标题" title="标题"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">故障处理人:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="BK_PROCESS_P" id="BK_PROCESS_P" disabled="disabled" data-placeholder="请选择故障处理人" style="vertical-align:top;" style="width:98%;" >
                                                <option value=""></option>
                                                <c:forEach items="${userList}" var="user">
                                                    <option value="${user.USERNAME}" <c:if test="${user.USERNAME == pd.BK_REPORT_P }">selected</c:if>>${user.NAME }</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">故障报告人:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="BK_REPORT_P" id="BK_REPORT_P" disabled="disabled" data-placeholder="请选择故障报告人" style="vertical-align:top;" style="width:98%;" >
                                                <option value=""></option>
                                                <c:forEach items="${userList}" var="user">
                                                    <option value="${user.USERNAME}" <c:if test="${user.USERNAME == pd.BK_REPORT_P }">selected</c:if>>${user.NAME }</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">全部系统:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="BK_SUBSYS" disabled="disabled" id="BK_SUBSYS" data-placeholder="请选择子系统" style="vertical-align:top;" style="width:98%;" >
                                                <option value=""></option>
                                                <c:forEach items="${subsysList}" var="subsys">
                                                    <option value="${subsys.SUBSYS_ID}" <c:if test="${pd.BK_SUBSYS  ==subsys.SUBSYS_ID }">selected</c:if>>${subsys.SUBSYS_NAME }</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-top: 13px;">故障时间</td>
                                        <td>
                                            <input class="span10 date-picker" name="BK_TIME" id="BK_TIME" disabled="disabled"  value="${pd.BK_TIME}"
                                                   type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="故障时间" title="故障时间"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">故障报告状态:</td>

                                        <td>
                                            <select class="chosen-select form-control" name="BK_REP_STATUS" disabled="disabled" id="BK_REP_STATUS" data-placeholder="选择故障状态" style="vertical-align:top;width: 120px;">
                                                <option value=""></option>
                                                <option value="">全部故障状态</option>
                                                <option value="0" <c:if test="${pd.BK_REP_STATUS == '0' }">selected</c:if>>故障报告登记</option>
                                                <option value="1" <c:if test="${pd.BK_REP_STATUS == '1' }">selected</c:if>>提交审核</option>
                                                <option value="2" <c:if test="${pd.BK_REP_STATUS == '2' }">selected</c:if>>审核不通过</option>
                                                <option value="3" <c:if test="${pd.BK_REP_STATUS == '3' }">selected</c:if>>审核通过</option>
                                            </select>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">故障详细描述:</td>
                                        <td>
                                            <textarea style="width:95%;height:100px;" rows="10" cols="10" name="BK_DETAIL_DESCI" disabled="disabled" id="BK_DETAIL_DESCI" title="故障详细描述" maxlength="500" placeholder="这里输入内容">${pd.BK_DETAIL_DESCI}</textarea>
                                            <div><font color="#808080">请不要多于500字否则无法发送</font></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">故障影响:</td>
                                        <td>
                                            <textarea style="width:95%;height:100px;" rows="10" cols="10" name="BK_INFLU" id="BK_INFLU" disabled="disabled" title="故障影响" maxlength="500" placeholder="这里输入内容">${pd.BK_INFLU}</textarea>
                                            <div><font color="#808080">请不要多于500字否则无法发送</font></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">故障处理过程:</td>
                                        <td>
                                            <textarea style="width:95%;height:100px;" rows="10" cols="10" name="BK_PROCE_PROCE" disabled="disabled" id="BK_PROCE_PROCE" title="内容" maxlength="500" placeholder="这里输入内容">${pd.BK_PROCE_PROCE}</textarea>
                                            <div><font color="#808080">请不要多于500字否则无法发送</font></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">故障分析和总结:</td>
                                        <td>
                                            <textarea style="width:95%;height:100px;" rows="10" cols="10" name="BK_ANALYSISANDSUMMARY" disabled="disabled" id="BK_ANALYSISANDSUMMARY" title="故障分析和总结" maxlength="500" placeholder="这里输入内容">${pd.BK_ANALYSISANDSUMMARY}</textarea>
                                            <div><font color="#808080">请不要多于500字否则无法发送</font></div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">后续工作安排:</td>
                                        <td>
                                            <textarea style="width:95%;height:100px;" rows="10" cols="10" name="BK_AFTERANDARRANGE" disabled="disabled" id="BK_AFTERANDARRANGE" title="内容" maxlength="500" placeholder="这里输入内容">${pd.BK_AFTERANDARRANGE}</textarea>
                                            <div><font color="#808080">请不要多于500字否则无法发送</font></div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">审核意见:</td>
                                        <td>
                                            <textarea style="width:95%;height:100px;" rows="10" cols="10" name="BK_AUDITOPINION" disabled="disabled" id="BK_AUDITOPINION" title="审核意见" maxlength="500" placeholder="这里输入内容">${pd.BK_AUDITOPINION}</textarea>
                                            <div><font color="#808080">请不要多于500字否则无法发送</font></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">小组审核人员:</td>
                                        <td>
                                            <input style="width:95%;" type="text" name="BK_PANELAUDITOR" id="BK_PANELAUDITOR" disabled="disabled" value="${pd.BK_PANELAUDITOR}" maxlength="500" placeholder="这里输入内容" title="小组审核人员"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="text-align: center;" colspan="10">
                                            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">关闭</a>
                                        </td>

                                    </tr>
                                </table>
                            </div>

                            <div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
                            <div id="loadgif"  style="width:150px;height:150px;position:absolute;top:94%;left:40%;">
                                　　<img  alt="加载中..."  src="<%=basePath%>temp/defaultverificationcode.jpg"/>
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
</div>
<!-- 页面底部js¨ -->
<%@ include file="../index/foot.jsp"%>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- inline scripts related to this page -->
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>
<script type="text/javascript">
    $(top.hangge());


    $(document).ready(function () { $("#loadgif").hide();});

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
</script>

</html>