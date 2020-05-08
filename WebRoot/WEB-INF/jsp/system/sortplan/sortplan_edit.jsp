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
        function saveS(){
            if($("#SP_ID").val()==""){
                $("#SP_ID").tips({
                    side:3,
                    msg:'请选择培训标题',
                    bg:'#AE81FF',
                    time:2
                });
                $("#SP_ID").focus();
                return false;
            }
            if($("#SP_TITLE").val()==""){
                $("#SP_TITLE").tips({
                    side:3,
                    msg:'请选择培训标题',
                    bg:'#AE81FF',
                    time:2
                });
                $("#SP_TITLE").focus();
                return false;
            }
            if($("#SP_CONTENT").val()==""){
                $("#SP_CONTENT").tips({
                    side:3,
                    msg:'请选择培训正文',
                    bg:'#AE81FF',
                    time:2
                });
                $("#SP_CONTENT").focus();
                return false;
            }
            if($("#SP_STARTTIME").val()==""){
                $("#SP_STARTTIME").tips({
                    side:3,
                    msg:'请输入开始时间',
                    bg:'#AE81FF',
                    time:2
                });
                $("#SP_STARTTIME").focus();
                return false;
            }



            if($("#SP_ENDTIME").val()==""){
                $("#SP_ENDTIME").tips({
                    side:3,
                    msg:'请选择结束时间',
                    bg:'#AE81FF',
                    time:2
                });
                $("#SP_ENDTIME").focus();
                return false;
            }

            $("#Form").submit();
        }




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
                        <form action="sortplan/${msg }.do" name="Form" id="Form" method="post">

                            <div id="zhongxin" style="padding-top: 13px;">
                            <input type="hidden" name="msg" id="msg" value="${pd.msg}"/>


                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">培训ID:</td>
                                        <td>
                                            <input style="width:95%;" type="text" name="SP_ID" id="SP_ID" value="${pd.SP_ID}" maxlength="500" placeholder="这里输入标题" title="标题"/>
                                        </td>
                                    </tr>


                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">培训标题:</td>
                                        <td>
                                            <input style="width:95%;" type="text" name="SP_TITLE" id="SP_TITLE" value="${pd.SP_TITLE}" maxlength="500" placeholder="这里输入标题" title="标题"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">培训人:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="SP_PERSON" id="SP_PERSON" data-placeholder="请选择培训人" style="vertical-align:top;" style="width:98%;" >
                                                <option value=""></option>
                                                <c:forEach items="${userList}" var="user">
                                                    <option value="${user.USERNAME}" <c:if test="${user.USERNAME == pd.SP_PERSON }">selected</c:if>>${user.NAME }</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="padding-top: 13px;">开始时间</td>
                                        <td>
                                            <input class="span10 date-picker" name="SP_STARTTIME" id="SP_STARTTIME"  value="${pd.SP_STARTTIME}"
                                                   type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始时间" title="开始时间"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-top: 13px;">结束时间</td>
                                        <td>
                                            <input class="span10 date-picker" name="SP_ENDTIME" id="SP_ENDTIME"  value="${pd.SP_ENDTIME}"
                                                   type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束时间" title="结束时间"/>
                                        </td>
                                    </tr>


                                    <tr>
                                        <td style="width:70px;text-align: right;padding-top: 13px;">培训详细内容:</td>
                                        <td>
                                            <textarea style="width:95%;height:100px;" rows="10" cols="10" name="SP_CONTENT" id="SP_CONTENT" title="培训详细内容" maxlength="500" placeholder="这里输入内容">${pd.SP_CONTENT}</textarea>
                                            <div><font color="#808080">请不要多于500字否则无法发送</font></div>
                                        </td>
                                    </tr>



                                    <tr>
                                        <td style="text-align: center;" colspan="10">

                                            <a class="btn btn-mini btn-primary" onclick="saveS();">保存</a>

                                            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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