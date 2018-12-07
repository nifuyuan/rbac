<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/6
  Time: 9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/jquery.easyui.min.js"></script>
    <script type="text/javascript">
        function submitForm() {
            $("#ff").form("submit",{
                onSubmit:function () {
                    return $(this).form("enableValidation").form("validate");
                },
                success:function (data) {
                    data = JSON.parse(data);
                    console.log(data);
                    if(data.code === 1){
                        location.replace("${path}/index");
                    }else{
                        $.messager.alert("提示","用户名或密码错误！","error");
                    }
                }
            })
        }
        function clearForm(){
            $('#ff').form('clear');
        }
        $(function () {
            //防止当前页面在iframe中打开
            if (top !== self) {
                top.location.replace(self.location);
            }
        });
    </script>
</head>
<body>
    <div style="margin: 0 auto;background-color: #6b9cde;width: 400px">
        <div class="easyui-panel" title="用户登录" style="width:100%;max-width:400px;padding:30px 60px;">
            <form action="${path}/doLogin" id="ff" class="easyui-form" method="post" data-options="novalidate:true">
                <div style="margin-bottom:20px">
                    <input class="easyui-textbox" name="username" prompt="username" style="width:100%" data-options="label:'用户名:',required:true">
                </div>
                <div style="margin-bottom:20px">
                    <input class="easyui-passwordbox" name="password" prompt="password" iconWidth="28" style="width:100%" data-options="label:'密　码:',required:true">
                </div>
            </form>
            <div style="text-align:center;padding:5px 0">
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">登录</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">取消</a>
            </div>
        </div>
    </div>
</body>
</html>
