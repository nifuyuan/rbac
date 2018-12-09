<%@ page import="com.hwua.rbac.po.Auth" %>
<%@ page import="com.alibaba.fastjson.JSON" %><%--
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
    <%--<script type="text/javascript">
        $(function () {
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
    </script>--%>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height:90px;background:#B3DFDA;padding:10px;font-size: 20px">
    <h1 style="height: 50px;margin: 5px ;float: left">权限管理系统</h1>
    <c:if test="${sessionScope.user != null}">
        <p style="float: right">欢迎${sessionScope.user.userName}&nbsp;&nbsp;
            <a href="${path}/logout" style="float: right">退出</a></p>
    </c:if>
</div>
<div data-options="region:'west',split:true,title:'功能模块'" style="width:150px">
    <div class="easyui-accordion" data-options="fit:true">
        <c:forEach items="${sessionScope.auths}" var="auth">
            <div title="${auth.text}" style="overflow:auto">
                <ul id="tree-${auth.id}"></ul>
                <script type="text/javascript">
                    <%
                        Auth auth = (Auth) pageContext.getAttribute("auth");
                        String authJson = JSON.toJSONString(auth.getChildren());
                        pageContext.setAttribute("authJson",authJson);
                    %>
                    var treeData = '${authJson}';
                    treeData = JSON.parse(treeData);
                    $("#tree-${auth.id}").tree({
                        data:treeData,
                        onClick:function (node) {
                            if(node.children.length === 0){
                                //打开页面
                                var mainTabs = $("#main-tabs");
                                if(!mainTabs.tabs("exists",node.text)){
                                    //添加tab
                                    mainTabs.tabs("add",{
                                        title:node.text,
                                        content:"<iframe width='100%' height='100%' src='${path}"+node.authURL+"'/>",
                                        closable:true
                                    });
                                }else{
                                    //选中已打开的标签页
                                    mainTabs.tabs("select",node.text);
                                }
                            }
                        }
                    });
                </script>
            </div>
        </c:forEach>
    </div>
</div>
<div data-options="region:'center'">
    <div id="main-tabs" class="easyui-tabs"></div>
</div>
</body>
</html>
