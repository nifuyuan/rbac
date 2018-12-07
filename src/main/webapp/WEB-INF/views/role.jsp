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
    <title>角色管理</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
    <script type="text/javascript">
        //搜索
        function seek() {
            var param = $("#f1").serialize();
            $.ajax({
                url: "${path}/role/search",
                data: param,
                success: function (res) {
                    $('#dg').datagrid("loadData", res);
                }
            })
        }

        //增加
        function add() {
            $("#w").window({
                title: "角色增加窗口",
                closed: true,
                iconCls: "icon-add",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                modal: true,
            }).window("open");
        }

        //提交表单
        function submitForm() {
            var param = $("#f2").serialize();
            $.ajax({
                url: "${path}/role/add",
                type: "POST",
                data: param,
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
            })
        }

        //取消表单
        function cancelForm() {
            $("#w").window("close");
            $("#role-window").window("close");
        }
        //显示授权窗口
        function showValidAuthWindow(roleId){
            $("#role-window").window({
                title: "权限授权窗口",
                closed: true,
                iconCls: "icon-edit",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                modal: true,
                footer:"#footer",
                onOpen:function () {
                    $("#auth-tree").tree({
                        url:"${path}/auth/getValidAuths?roleId="+roleId,
                        checkbox:true
                        // cascadeCheck:false
                    });
                }
            }).window("open");
        }
        //提交授权
        function grantAuth(){
            //获取选中的权限的id
            var nodes = $("#auth-tree").tree("getChecked");
            var authIds = [];
            for (var i = 0; i < nodes.length; i++){
                var node = nodes[i];
                authIds.push(node.id);
            }
            var roleId = $("#dg").datagrid("getSelected").dbid;
            $.ajax({
                url:"${path}/auth/submit",
                dataType:"json",
                traditional:true,
                data:{
                    "roleId":roleId,
                    "authIds":authIds
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
                url: "${path}/role/getRoles",
                rownumbers: true,
                singleSelect:true,
                pagination:true,
                columns: [[
                    {field: 'roleName', title: '角色名称', width: 260},
                    {field: 'roleCode', title: '角色编码', width: 260},
                    {
                        field: 'valid', title: '是否有效', width: 260,
                        formatter: function (value, row, index) {
                            if (value === "1") {
                                return "有效";
                            } else {
                                return "<span style='color:red'>无效</span>";
                            }
                        }
                    },
                    {field: 'orders', title: '排序', width: 260},
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
    <input id="roleName" class="easyui-textbox" name="roleName" data-options="prompt:'角色名称',iconCls:'icon-search'"
           style="width:300px">
    <input id="roleCode" class="easyui-textbox" name="roleCode" data-options="prompt:'角色编码',iconCls:'icon-search'"
           style="width:300px">
    <input class="easyui-combobox" name="valid" style="width:300px" data-options="
					url: '${path}/temp/combobox_data1.json',
					method: 'get',
					valueField: 'id',
					textField: 'text',
					">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seek()">搜索</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add()">增加</a>
</form>
<table id="dg"></table>
<div id="w" class="easyui-window" title="Basic Window" data-options="closed:true"
     style="width:400px;height:330px;padding:10px;">
    <form id="f2" method="post">
        <div style="margin-bottom:20px">
            <input id="name" class="easyui-textbox" name="roleName" style="width:100%"
                   data-options="label:'角色名称:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="code" class="easyui-textbox" name="roleCode" style="width:100%" data-options="label:'角色编码:'">
        </div>
        <div style="margin-bottom:20px">
            <input id="orders" class="easyui-textbox" name="orders" style="width:100%" data-options="label:'排序:'">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="valid" name="valid" label="是否有效:" style="width:100%">
                <option value="1">有效</option>
                <option value="0">无效</option>
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
     style="width:400px;height:500px;padding:10px;">
    <ul id="auth-tree"></ul>
    <div id="footer" style="text-align:center;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="grantAuth()"
           style="width:80px">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
           onclick="cancelForm()" style="width:80px">取消</a>
    </div>
</div>
</body>
</html>
