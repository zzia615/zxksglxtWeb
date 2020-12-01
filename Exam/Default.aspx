<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="zxksglxtWeb.Exam.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../layui/css/layui.css" rel="stylesheet" />
    <style>
        body{
            background:#eee;
            overflow:hidden;
        }

        #card1{
            position:absolute;
            top:5px;
            height:120px;
            left:5px;
            right:5px;
            margin-bottom:0px;
        }
        
        #card3{
            position:absolute;
            height:60px;
            left:5px;
            right:5px;
            top:130px;
            margin-bottom:0px;
        }

        #card2{
            position:absolute;
            top:200px;
            left:5px;
            right:5px;
            bottom:5px;
            margin-bottom:0px;
            overflow:auto;
        }

    </style>
</head>
<body style="padding:20px;">
    <div class="layui-card" id="card1">
        <div class="layui-card-header">
            <h2><%=ExamDesc.title %></h2>
        </div>
        <div class="layui-card-body">
            <h3>考试姓名：<%=UserInfo.code %> 考生身份证号:<%=UserInfo.sfzh %></h3>
            <h3>时间限制：<%=ExamDesc.costTime %>分钟</h3>
        </div>
    </div>
    <form class="layui-form" lay-filter="examForm">           
       <div class="layui-card" id="card3">
           <div class="layui-card-body">
                <button lay-submit lay-filter="btnSave" class="layui-btn">交卷</button>
           </div>
       </div>
       <div class="layui-card" id="card2">
           <div class="layui-card-body">
               <input name="pid" style="display:none" value="<%=ExamResult.id %>"/>
               <input name="examDesc_id" style="display:none" value="<%=ExamDesc.id %>"/>
               <input name="scode" style="display:none" value="<%=UserInfo.code %>"/>
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
           </div>
       </div>
       
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
                formData.examDesc_id = data.field.examDesc_id;
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
