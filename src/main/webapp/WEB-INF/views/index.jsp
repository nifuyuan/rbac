<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/26
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#test").tree({
                url:"${path}/temp/treeTest_data1.json",
                onClick:function (node) {
                    if(!node.children){
                        //打开页面
                        var mainTabs = $("#main-tabs");
                        if(!mainTabs.tabs("exists",node.text)){
                            //添加tab
                            mainTabs.tabs("add",{
                                title:node.text,
                                content:"<iframe width='100%' height='100%' src='${path}/"+node.url+"'/>",
                                closable:true
                            });
                        }else{
                            //选中已打开的标签页
                            mainTabs.tabs("select",node.text);
                        }
                    }
                }
            });
            $("#system").tree({
                url:"${path}/temp/treeSystem_data1.json",
                onClick:function (node) {
                    if(!node.children){
                        //打开页面
                        var mainTabs = $("#main-tabs");
                        if(!mainTabs.tabs("exists",node.text)){
                            //添加tab
                            mainTabs.tabs("add",{
                                title:node.text,
                                content:"<iframe width='100%' height='100%' src='${path}/"+node.url+"'/>",
                                closable:true
                            });
                        }else{
                            //选中已打开的标签页
                            mainTabs.tabs("select",node.text);
                        }
                    }
                }
            });
        });
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px;font-size: 20px">
    <strong>人力资源管理系统</strong></div>
<div data-options="region:'west',split:true,title:'功能模块'" style="width:150px">
    <div class="easyui-accordion" data-options="fit:true">
        <div title="考试管理" style="overflow:auto">
            <ul id="test"></ul>
        </div>
        <div title="系统管理" style="overflow:auto">
            <ul id="system"></ul>
        </div>
    </div>
</div>
<div data-options="region:'center'">
    <div id="main-tabs" class="easyui-tabs"></div>
</div>
</body>
</html>