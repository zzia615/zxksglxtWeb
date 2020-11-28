<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamPreview.aspx.cs" Inherits="zxksglxtWeb.Admin.ExamPreview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../layui/css/layui.css" rel="stylesheet" />
</head>
<body style="padding:20px;">
    <form class="layui-form" lay-filter="examForm">
       <input name="pid" style="display:none" value="<%=ExamDesc.id %>"/>
       <div><h2>一、单选题</h2></div>
       <%foreach (var exam in ExamDesc.ExamList.Where(a=>a.type=="单选题"))
           { %>
       <div><%=exam.orderNo.ToString()+".("+exam.score.ToString()+"分)"+exam.title%>
        <div>
            <input type="radio" name="r_<%=exam.id %>" value="A" title="A.<%=exam.resultA %>"/>
            <input type="radio" name="r_<%=exam.id %>" value="B" title="B.<%=exam.resultB %>" />
        </div>
        <div>
            <input type="radio" name="r_<%=exam.id %>" value="C" title="C.<%=exam.resultC %>" />
            <input type="radio" name="r_<%=exam.id %>" value="D" title="D.<%=exam.resultD %>" />
        </div>
        </div>
       <%} %>
       <div><h2>二、多选题</h2></div>
        <%foreach (var exam in ExamDesc.ExamList.Where(a=>a.type=="多选题"))
           { %>
       <div><%=exam.orderNo.ToString()+".("+exam.score.ToString()+"分)"+exam.title%>
        <div style="margin-top:5px;">
            <input type="checkbox" lay-skin="primary" name="c_<%=exam.id %>[A]" title="A.<%=exam.resultA %>"/>
            <input type="checkbox" lay-skin="primary" name="c_<%=exam.id %>[B]" title="B.<%=exam.resultB %>" />
        </div>
        <div style="margin-top:5px;">
            <input type="checkbox" lay-skin="primary" name="c_<%=exam.id %>[C]" title="C.<%=exam.resultC %>" />
            <input type="checkbox" lay-skin="primary" name="c_<%=exam.id %>[D]" title="D.<%=exam.resultD %>" />
        </div>
        </div>
       <%} %>
        
       <div><h2>三、判断题</h2></div>
        <%foreach (var exam in ExamDesc.ExamList.Where(a=>a.type=="判断题"))
           { %>
       <div><%=exam.orderNo.ToString()+".("+exam.score.ToString()+"分)"+exam.title%>
        
            <input type="radio" name="k_<%=exam.id %>" value="A" title="A.<%=exam.resultA %>"/>
            <input type="radio" name="k_<%=exam.id %>" value="B" title="B.<%=exam.resultB %>" />

        </div>
       <%} %>
    </form>
    <script src="../layui/layui.js"></script>
    <script>
        //一般直接写在一个js文件中
        layui.use(['element', 'form','layer'], function () {
            var element = layui.element
                , form = layui.form
                , layer = layui.layer,$=layui.$;
            
        });
    </script>
</body>
</html>
