<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="zxksglxtWeb.Exam.Success" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>交卷成功</title>
    <link href="../layui/css/layui.css" rel="stylesheet" />
</head>
<body>
    <div>
        <i class="layui-icon layui-icon-ok"  style="font-size:40pt;text-align:center;display:block;color:green;margin-top:100px;">交卷成功</i>
        <a href="/Exam/Login.aspx" style="text-align:center;display:block;margin-top:20px;" id="linkLogin">返回登录</a>
    </div>
    <script src="../layui/layui.js"></script>
    <script>
        layui.use(["element"], function () {
            var $ = layui.$;
            var c = 3;
            redirectLogin();
            function redirectLogin() {
                setTimeout(function () {
                    if (c <= 0) {
                        window.open("/Exam/Login.aspx", "_self");
                    }
                    $("#linkLogin").html("返回登录(" + c + ")")
                    c--;
                    redirectLogin();
                }, 1000);
            }
        });
    </script>
</body>
</html>
