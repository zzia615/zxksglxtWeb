<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="zxksglxtWeb.Exam.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../layui/css/layui.css" rel="stylesheet" />
</head>
<body style="padding:20px;">
    <form class="layui-form" lay-filter="examForm">
       <input name="pid" style="display:none" />
       <div>单选题</div>
       <%foreach (var exam in ExamDesc.ExamList.Where(a=>a.type=="单选题"))
           { %>
       <div><%=exam.id.ToString()+".("+exam.score.ToString()+"分)"+exam.title%>
        <div>
            <input type="radio" name="r_<%=exam.id %>" value="A" title="A.<%=exam.resultA %>"/>
         </div>
        <div>
            <input type="radio" name="r_<%=exam.id %>" value="B" title="B.<%=exam.resultB %>" />
        </div>
        <div>
            <input type="radio" name="r_<%=exam.id %>" value="C" title="C.<%=exam.resultC %>" />
        </div>
        <div>
            <input type="radio" name="r_<%=exam.id %>" value="D" title="D.<%=exam.resultD %>" />
        </div>
        </div>
       <%} %>
       <div>多选题</div>
        <%foreach (var exam in ExamDesc.ExamList.Where(a=>a.type=="多选题"))
           { %>
       <div><%=exam.id.ToString()+".("+exam.score.ToString()+"分)"+exam.title%>
        <div>
            <input type="checkbox" lay-skin="primary" name="c_<%=exam.id %>[A]" title="A.<%=exam.resultA %>"/>
         </div>
        <div>
            <input type="checkbox" lay-skin="primary" name="c_<%=exam.id %>[B]" title="B.<%=exam.resultB %>" />
        </div>
        <div>
            <input type="checkbox" lay-skin="primary" name="c_<%=exam.id %>[C]" title="C.<%=exam.resultC %>" />
        </div>
        <div>
            <input type="checkbox" lay-skin="primary" name="c_<%=exam.id %>[D]" title="D.<%=exam.resultD %>" />
        </div>
        </div>
       <%} %>
        <button lay-submit lay-filter="btnSave" class="layui-btn">保存</button>
    </form>
    <script src="../layui/layui.js"></script>
    <script>
        //一般直接写在一个js文件中
        layui.use(['element', 'form','layer'], function () {
            var element = layui.element
                , form = layui.form
                , layer = layui.layer,$=layui.$;
            form.on("submit(btnSave)", function (data) {
                console.log(data.field);
                var formData = {};
                formData.data = JSON.stringify(data.field);
                formData.action = "HandInExam";
                formData.pid = data.field.pid;
                $.ajax({
                    url: "/Exam/Default.aspx",
                    data: formData,
                    dataType: "json",
                    type: "post",
                    success: function (res) {
                        if (res.code === 0) { //成功
                            layer.msg("交卷成功");
                            window.location.href = "/Exam/Success.aspx";
                        } else {
                            layer.msg("交卷成功失败\r\n错误原因：" + res.msg);
                        }
                    },
                    error: function (a, b, c) {
                        layer.msg("请求出错\r\n错误代码：" + a.status + ",错误原因：" + a.statusText)
                    }
                });
                return false;
            })
        });
    </script>
</body>
</html>
