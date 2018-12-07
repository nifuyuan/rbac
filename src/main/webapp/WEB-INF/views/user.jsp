<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/29
  Time: 20:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户管理</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.validatebox.js"></script>
    <script type="text/javascript">
        //搜索
        function seek() {
            var param = $("#f1").serialize();
            console.log(param);
            $.ajax({
                url: "${path}/user/search",
                data: param,
                success: function (res) {
                    $('#dg').datagrid("loadData", res);
                }
            })
        }

        //增加
        function add() {
            $("#w").window({
                title: "用户增加窗口",
                closed: true,
                iconCls: "icon-add",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                modal: true,
            }).window("open");
        }
        //验证两次密码是否相同
        $.extend($.fn.validatebox.defaults.rules, {
            equals: {
                validator: function(value,param){
                    return value == $(param[0]).val();
                },
                message: '密码不一致！'
            }
        });
        //提交表单
        function submitForm() {
            var values = $("#f2").serialize();
            if($("#rpassword").validatebox("isValid")){
                $.ajax({
                    url: "${path}/user/add",
                    type: "POST",
                    data: values,
                    success: function (res) {
                        if (res.code === 1) {
                            $("#w").window("close");
                            $.messager.alert('信息', '添加成功!', 'success');
                            //刷新页面
                            $("#dg").datagrid("reload");
                        } else {
                            alert("修改失败！");
                        }
                    }
                });
            }else{
                $.messager.alert('提示', '两次输入的密码不一致!', 'error');
            }
        }

        //取消表单
        function cancelForm() {
            $("#w").window("close");
            $("#role-window").window("close");
        }

        //显示授权窗口
        function showValidAuthWindow(userId){
            $("#role-window").window({
                title: "角色授权窗口",
                closed: true,
                iconCls: "icon-edit",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                modal: true,
                footer:"#footer",
                onOpen:function () {
                    $("#role-datagrid").datagrid({
                        url:"${path}/role/getValidRoles",
                        idField:"dbid",
                        columns:[[
                            {field: 'dbid',title: 'dbid',checkbox:true, width: 100},
                            {field: 'roleName', title: '角色名称', width: 116},
                            {field: 'roleCode', title: '角色编码', width: 120}
                        ]],
                        onLoadSuccess:function (data) {
                            //获取当前选中用户拥有的角色
                            $.ajax({
                                url:"${path}/role/getRolesByUserId?userId="+userId,
                                success:function (res) {
                                    res.forEach(function (value, index) {
                                        $("#role-datagrid").datagrid("selectRecord",value);
                                    })
                                }
                            })
                        }
                    })
                },
                onClose:function () {
                    $("#role-datagrid").datagrid("unselectAll");
                }
            }).window("open");
        }

        //提交授权
        function grantRole(){
            var userId = $("#dg").datagrid("getSelected").dbid;
            var selectedRoles = $("#role-datagrid").datagrid("getChecked");
            var roleIds = [];
            for (var i = 0; i < selectedRoles.length; i++) {
                roleIds.push(selectedRoles[i].dbid);
            }
            $.ajax({
                url:"${path}/user/submit",
                traditional:true,
                data:{
                    "userId":userId,
                    "roleIds":roleIds
                },
                success:function (res) {
                    if(res.code === 1){
                        $("#role-window").window("close");
                        $.messager.alert('信息', '保存成功!', 'success');
                        //刷新页面
                        $("#dg").datagrid("reload");
                    }
                }
            })
        }
        $(function () {
            $('#dg').datagrid({
                url: "${path}/user/getUsers",
                rownumbers: true,
                singleSelect:true,
                columns: [[
                    {field: 'userName', title: '用户名称', width: 260},
                    {field: 'realName', title: '真实姓名', width: 260},
                    {
                        field: 'valid', title: '用户状态', width: 260,
                        formatter: function (value, row, index) {
                            if (value === "1") {
                                return "正常";
                            } else {
                                return "<span style='color:red'>冻结</span>";
                            }
                        }
                    },
                    {
                        field: 'dbid', title: '授权', width: 260,
                        formatter: function (value, row, index) {
                            var str = "<a href='javascript:void(0)' onclick='showValidAuthWindow("+value+")'>授权</a>";
                            return str;
                        }
                    }
                ]]
            });
        });
    </script>
</head>
<body>
<form id="f1">
    <input id="userName" class="easyui-textbox" name="userName" data-options="prompt:'用户名称',iconCls:'icon-search'"
           style="width:300px">
    <input id="realName" class="easyui-textbox" name="realName" data-options="prompt:'真实姓名',iconCls:'icon-search'"
           style="width:300px">
    <input class="easyui-combobox" name="valid" style="width:300px" data-options="
					url: '${path}/temp/combobox_data2.json',
					method: 'get',
					valueField: 'id',
					textField: 'text',
					">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seek()">搜索</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add()">增加</a>
</form>
<table id="dg"></table>
<div id="w" class="easyui-window" title="Basic Window" data-options="closed:true"
     style="width:400px;height:380px;padding:10px;">
    <form id="f2" method="post">
        <div style="margin-bottom:20px">
            <input id="user_name" class="easyui-textbox" name="userName" style="width:100%"
                   data-options="label:'用户名称:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="real_name" class="easyui-textbox" name="realName" style="width:100%" data-options="label:'真实姓名:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="password" name="password" class="easyui-passwordbox easyui-validatebox" iconWidth="28" style="width:100%;" data-options="label:'密码:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="rpassword" class="easyui-passwordbox easyui-validatebox" iconWidth="28" validType="equals['#password']" style="width:100%" data-options="label:'确认密码:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="valid" name="valid" label="用户状态:" style="width:100%">
                <option value="1">正常</option>
                <option value="0">冻结</option>
            </select>
        </div>
    </form>
    <div style="text-align:center;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitForm()"
           style="width:80px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
           onclick="cancelForm()" style="width:80px">取消</a>
    </div>
</div>
<div id="role-window" class="easyui-window" title="Basic Window" data-options="closed:true"
     style="width:300px;height:350px;padding:10px;">
    <table id="role-datagrid"></table>
    <div id="footer" style="text-align:center;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="grantRole()"
           style="width:80px">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
           onclick="cancelForm()" style="width:80px">取消</a>
    </div>
</div>
</body>
</html>
