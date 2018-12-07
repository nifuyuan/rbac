<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/27
  Time: 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>权限管理</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
    <script type="text/javascript">
        //增加子节点
        function addAuth() {
            var select = $("#auth-treegrid").treegrid("getSelected");
            var parent = $("#auth-treegrid").treegrid("getParent",select.dbid);
            $("#w").window({
                title: "权限增加窗口",
                closed: true,
                iconCls: "icon-add",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                modal: true,
            }).window("open");
            $("#layer").textbox("setValue",select.layer+1);
            $("#parentName").textbox("setValue",select.authName);
            $("#authName").textbox("setValue");
            $("#authCode").textbox("setValue");
            $("#authURL").textbox("setValue");
            $("#orders").textbox("setValue");
            $("#dbid").textbox("setValue");
            $("#parentId").textbox("setValue",select.dbid);
        }
        //编辑本节点
        function editAuth() {
            var select = $("#auth-treegrid").treegrid("getSelected");
            var parent = $("#auth-treegrid").treegrid("getParent",select.dbid);
            if(select.parentId === -1){
                $.messager.alert('警告','根节点无法编辑','warning');
                return;
            }
            $("#w").window({
                title: "权限编辑窗口",
                closed: true,
                iconCls: "icon-edit",
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                modal: true,
            }).window("open");
            /*
            $("#authName").textbox("setValue",select.authName);
            $("#authCode").textbox("setValue",select.authCode);
            $("#authURL").textbox("setValue",select.authURL);
            $("#orders").textbox("setValue",select.orders);
            $("#type").combobox("setValue",select.type);
            $("#valid").combobox("setValue",select.valid);*/
            $("#layer").textbox("setValue",select.layer);
            $("#parentName").textbox("setValue",parent.authName);
            $("#ff").form("load",{
                dbid:select.dbid,
                authName:select.authName,
                authCode:select.authCode,
                authURL:select.authURL,
                orders:select.orders,
                type:select.type,
                valid:select.valid
            });
        }
        //刷新权限列表
        function reloadAuth() {
            $("#auth-treegrid").treegrid("reload");
        };
        //提交表单
        function submitForm() {
            var param = $("form").serialize();
            console.log(param);
            var dbid = $("input[name='dbid']").val();
            if(dbid != ""){
                $.ajax({
                    url:"${path}/auth/edit",
                    type:"POST",
                    data:param,
                    success:function (res) {
                        if(res.code === 1){
                            $("#w").window("close");
                            $.messager.alert('信息','修改成功!','success');
                            //刷新页面
                            $("#auth-treegrid").treegrid("reload");
                        }else{
                            alert("修改失败！");
                        }
                    }
                })
            }else{
                $.ajax({
                    url:"${path}/auth/add",
                    type:"POST",
                    data:param,
                    success:function (res) {
                        if(res.code === 1){
                            $("#w").window("close");
                            $.messager.alert('信息','添加成功!','success');
                            //刷新页面
                            $("#auth-treegrid").treegrid("reload");
                        }else{
                            alert("添加失败！");
                        }
                    }
                })
            }
        }
        //取消表单
        function cancelForm() {
            $("#w").window("close");
        }
        $(function () {
            $("#auth-treegrid").treegrid({
                url: "${path}/auth/getAuths",
                idField: "dbid",
                treeField: "authName",
                rownumbers: true,
                columns: [[
                    {title: "编号", field: "dbid", width: 100},
                    {title: "权限名称", field: "authName", width: "200px"},
                    {title: "权限编码", field: "authCode", width: 200},
                    {title: "URL", field: "authURL", width: 200},
                    {
                        title: "类型", field: "type", width: 100,
                        formatter: function (value, row, index) {
                            if (value === "1") {
                                return "模块"
                            } else {
                                return "资源";
                            }
                        }
                    },
                    {title: "排序", field: "orders", width: 100},
                    {
                        title: "是否有效", field: "valid", width: 100,
                        formatter: function (value, row, index) {
                            if (value === "1") {
                                return "有效";
                            } else {
                                return "<span style='color:red'>无效</span>";
                            }
                        }
                    },
                    {title: "层级", field: "layer", width: 100}
                ]],
                onContextMenu: function (e, row) {
                    //判断是否在treegrid里面
                    if (row) {
                        //阻止浏览器的默认右键菜单
                        e.preventDefault();
                        //右键选中当前行
                        $("#auth-treegrid").treegrid("select", row.dbid);
                        $("#mm").menu("show", {
                            left: e.pageX,
                            top: e.pageY
                        });
                    }
                }
            });
        });
    </script>
</head>
<body>
<table id="auth-treegrid"></table>
<div id="mm" class="easyui-menu" style="width:120px;">
    <div id="add" onclick="addAuth()" data-options="iconCls:'icon-add'">增加子节点</div>
    <div id="edit" onclick="editAuth()" data-options="iconCls:'icon-edit'">编辑本节点</div>
    <div onclick="reloadAuth()" data-options="iconCls:'icon-reload'">刷新</div>
</div>
<div id="w" class="easyui-window" title="Basic Window" data-options="closed:true"
     style="width:410px;height:550px;padding:10px;">
    <form id="ff" method="post">
        <input id="dbid" class="easyui-textbox" type="hidden" name="dbid">
        <input id="parentId" class="easyui-textbox" type="hidden" name="parentId">
        <div style="margin-bottom:20px">
            <input id="parentName" class="easyui-textbox" style="width:100%" data-options="label:'上级节点:',required:true,readonly:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="layer" class="easyui-textbox" name="layer" style="width:100%" data-options="label:'当前层级:',required:true,readonly:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="authName" class="easyui-textbox" name="authName" style="width:100%" data-options="label:'权限名称:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input id="authCode" class="easyui-textbox" name="authCode" style="width:100%" data-options="label:'权限编码:'">
        </div>
        <div style="margin-bottom:20px">
            <input id="authURL" class="easyui-textbox" name="authURL" style="width:100%" data-options="label:'URL:'">
        </div>
        <div style="margin-bottom:20px">
            <input id="orders" class="easyui-textbox" name="orders" style="width:100%" data-options="label:'排序:'">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="type" name="type" label="类型:" style="width:100%">
                <option value="1">模块</option>
                <option value="2">资源</option>
            </select>
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="valid" name="valid" label="是否有效:" style="width:100%">
                <option value="1">有效</option>
                <option value="0">无效</option>
            </select>
        </div>
    </form>
    <div style="text-align:center;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitForm()" style="width:80px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="cancelForm()" style="width:80px">取消</a>
    </div>
</div>
</body>
</html>
