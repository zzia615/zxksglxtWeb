<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="zxksglxtWeb.Welcome" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>欢迎登录本系统</title>
  <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body style="padding:10px;">
<blockquote class="layui-elem-quote">欢迎登录本系统</blockquote>
<blockquote class="layui-elem-quote">现在时间：<%=DateTime.Now.ToString("yyyy年MM月dd日HH时mm分") %></blockquote>
<script src="layui/layui.js"></script>
<script>
//JavaScript代码区域
    layui.use(['element'], function(){
  var element = layui.element;
  
});
</script>
</body>
</html>
