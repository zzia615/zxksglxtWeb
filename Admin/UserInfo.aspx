<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="zxksglxtWeb.Admin.UserInfo" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>用户维护</title>
  <link rel="stylesheet" href="../layui/css/layui.css">
    <style>
        
        body{
            background:#eee;
            overflow:hidden;
        }

        #card3{
            position:absolute;
            top:5px;
            left:5px;
            right:5px;
            height:40px;
        }
        
        #card1{
            position:absolute;
            top:50px;
            left:5px;
            right:5px;
            height:60px;
        }
        
        
        #card2{
            position:absolute;
            top:115px;
            left:5px;
            right:5px;
            bottom:5px;
            margin-bottom:0px;
        }
        #card1 .layui-form-label{
            width:60px;
        }
    </style>
</head>
<body>
    <div class="layui-card" id="card3">
        <div class="layui-card-body">
            <span class="layui-breadcrumb">
              <a href="#">基础数据</a>
              <a><cite>用户维护</cite></a>
            </span>
        </div>
    </div>
    <div class="layui-card" id="card1">
        <div class="layui-card-body">
            <div class="layui-form">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">编号</label>
                        <div class="layui-input-inline">
                        <input type="text" id="code" lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">姓名</label>
                        <div class="layui-input-inline">
                        <input type="text" id="name" lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">用户类别</label>
                        <div class="layui-input-inline">
                              <select id="userType" autocomplete="off" class="layui-input">
                                  <option value="">请选择</option>
                                  <option value="管理员">管理员</option>                      
                                  <option value="学生">学生</option>
                              </select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn" id="btnQuery"><i class="layui-icon layui-icon-search"></i>查询</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-card" id="card2">
        <div class="layui-card-body">
            <table class="layui-hide" id="test" lay-filter="test"></table>
        </div>
    </div>
 
    <script type="text/html" id="toolbarDemo">
      <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addData"><i class="layui-icon layui-icon-add-1"></i>新增</button>
        <button class="layui-btn layui-btn-sm" lay-event="delSelectedData"><i class="layui-icon layui-icon-delete"></i>删除</button>
      </div>
    </script>
 
    <script type="text/html" id="barDemo">
      <a class="layui-btn layui-btn-xs" lay-event="editData">修改</a>
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delData">删除</a>
    </script>

    <script type="text/html" id="addForm">
        <form class="layui-form" action="" style="padding:10px;" lay-filter="addForm">
          <input type="text" name="action" style="display:none" autocomplete="off" class="layui-input">

          <div class="layui-form-item layui-form-text">
              <div class="layui-inline">
                <label class="layui-form-label">编号</label>
                <div class="layui-input-inline">
                      <input type="text" name="code" lay-verify="required" lay-reqtext="编号是必填项，岂能为空？" autocomplete="off" placeholder="请输入编号" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                  <input type="text" name="name" lay-verify="required" lay-reqtext="姓名是必填项，岂能为空？" autocomplete="off" placeholder="请输入姓名" class="layui-input">
                </div>
              </div>
          </div>
          <div class="layui-form-item layui-form-text">
              <div class="layui-inline">
                <label class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                      <input type="password" name="password" lay-verify="required" lay-reqtext="密码是必填项，岂能为空？" autocomplete="off" placeholder="请输入密码" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <label class="layui-form-label">用户类别</label>
                <div class="layui-input-inline">
                  <select name="userType" lay-verify="required" lay-reqtext="用户类别是必填项，岂能为空？" autocomplete="off" class="layui-input">
                    <option value="">请选择用户类别</option>
                    <option value="管理员">管理员</option>                      
                    <option value="学生">学生</option>
                  </select>
                </div>
              </div>
          </div>  
          <div class="layui-form-item layui-form-text">
              <div class="layui-inline">
                <label class="layui-form-label">身份证号</label>
                <div class="layui-input-inline">
                      <input type="text" name="sfzh" lay-verify="required" lay-reqtext="身份证号是必填项，岂能为空？" autocomplete="off" placeholder="请输入身份证号" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                  <input type="text" name="phone" lay-verify="required" lay-reqtext="联系电话是必填项，岂能为空？" autocomplete="off" placeholder="请输入联系电话" class="layui-input">
                </div>
              </div>
          </div>
          <div class="layui-form-item">
            <div class="layui-input-block">
              <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnSave" id="btnSave">保存</button>
              <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
          </div>
        </form>
    </script>
    <script type="text/html" id="editForm">
        <form class="layui-form" action="" style="padding:10px;" lay-filter="editForm">
          <input type="text" name="action" style="display:none" autocomplete="off" class="layui-input">

          <div class="layui-form-item layui-form-text">
              <div class="layui-inline">
                <label class="layui-form-label">编号</label>
                <div class="layui-input-inline">
                      <input type="text" name="code" readonly="readonly" lay-verify="required" lay-reqtext="编号是必填项，岂能为空？" autocomplete="off" placeholder="请输入编号" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                  <input type="text" name="name" lay-verify="required" lay-reqtext="姓名是必填项，岂能为空？" autocomplete="off" placeholder="请输入姓名" class="layui-input">
                </div>
              </div>
          </div>
          <div class="layui-form-item layui-form-text">
              <div class="layui-inline">
                <label class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                      <input type="password" name="password" lay-verify="required" lay-reqtext="密码是必填项，岂能为空？" autocomplete="off" placeholder="请输入密码" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <label class="layui-form-label">用户类别</label>
                <div class="layui-input-inline">
                  <select name="userType" lay-verify="required" lay-reqtext="用户类别是必填项，岂能为空？" autocomplete="off" class="layui-input">
                    <option value="">请选择用户类别</option>
                    <option value="管理员">管理员</option>                      
                    <option value="学生">学生</option>
                  </select>
                </div>
              </div>
          </div>  
          <div class="layui-form-item layui-form-text">
              <div class="layui-inline">
                <label class="layui-form-label">身份证号</label>
                <div class="layui-input-inline">
                      <input type="text" name="sfzh" lay-verify="required" lay-reqtext="身份证号是必填项，岂能为空？" autocomplete="off" placeholder="请输入身份证号" class="layui-input">
                </div>
              </div>
              <div class="layui-inline">
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                  <input type="text" name="phone" lay-verify="required" lay-reqtext="联系电话是必填项，岂能为空？" autocomplete="off" placeholder="请输入联系电话" class="layui-input">
                </div>
              </div>
          </div>
          <div class="layui-form-item">
            <div class="layui-input-block">
              <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnSave" id="btnSave">保存</button>
            </div>
          </div>
        </form>
    </script>
<script src="../layui/layui.js"></script>
<script>
//JavaScript代码区域
    layui.use(['element', 'table', 'jquery', 'layer', 'form', 'transfer'], function () {
        var element = layui.element;
        var table = layui.table;
        var $ = layui.$;
        var layer = layui.layer;
        var form = layui.form;
        var transfer = layui.transfer;



        form.on("submit(btnSave)", function (data) {
            var formData = data.field;
            
            $.ajax({
                url: "/Admin/UserInfo.aspx",
                data: formData,
                dataType: "json",
                type: "post",
                success: function (res) {
                    if (res.code === 0) { //成功
                        layer.msg("保存成功");
                        reloadData();
                        layer.closeAll();
                    } else {
                        layer.msg("保存失败\r\n错误原因：" + res.msg);
                    }
                },
                error: function (a, b, c) {
                    layer.msg("请求出错\r\n错误代码：" + a.status + ",错误原因：" + a.statusText)
                }
            });
            return false;
        });


        var tableIns = table.render({
            elem: '#test'
            , url: '/Admin/UserInfo.aspx'
            , where: {
                action: "queryUserInfo"
            }
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print']
            , title: '文件列表'
            , cols: [[
                { type: 'checkbox', fixed: 'left' }
                , { field: 'code', title: '编号', fixed: 'left', width: 150 }
                , { field: 'name', title: '姓名',width:100, sort: true }
                , { field: 'userType', title: '用户类别',width:120, sort: true }
                , { field: 'sfzh', title: '身份证号',width:180, sort: true }
                , { field: 'phone', title: '联系电话',width:120, sort: true }
                , { fixed: 'right', title: '操作', toolbar: '#barDemo', width: 150 }
            ]]
            , page: true
        });
        $("#btnQuery").click(function () {
            reloadData();
        });

        function reloadData() {
            //这里以搜索为例
            tableIns.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    code: $("#code").val()
                    , name: $("#name").val()
                    , userType: $("#userType").val()
                    , action: "queryUserInfo"
                }
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        }
        //头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'delSelectedData':
                    var data = checkStatus.data;
                    if (data.length <= 0) {
                        layer.msg("请选择要删除的记录");
                        return;
                    }
                    delData(data);
                    break;
                case "addData":
                    layer.open({
                        type: 1,
                        area: ['720px', '300px'],
                        title: "新增",
                        fixed: false, //不固定
                        content: $("#addForm").html(),
                        success: function () {
                            form.render();
                            form.val("addForm", {action:"addUserInfo"})
                        }
                    });
                    break;
            };
        });

        function delData(data) {
            $.ajax({
                url: "/Admin/UserInfo.aspx",
                data: { action: "delSelectedData", data: JSON.stringify(data) },
                dataType: "json",
                type: "post",
                success: function (res) {
                    if (res.code === 0) { //成功
                        layer.msg("删除成功");
                        reloadData();
                    } else {
                        layer.msg("删除失败\r\n错误原因：" + res.msg);
                    }
                },
                error: function (a, b, c) {
                    layer.msg("请求出错\r\n错误代码：" + a.status + ",错误原因：" + a.statusText)
                }
            });
        }

        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            //console.log(obj)
            if (obj.event === 'delData') {
                layer.confirm('真的删除行么', function (index) {
                    var tmp = [];
                    tmp[0] = data;
                    delData(tmp);
                });
            }
            else if (obj.event = 'editData') {
                layer.open({
                    type: 1,
                    area: ['720px', '300px'],
                    title: "修改",
                    fixed: false, //不固定
                    content: $("#editForm").html(),
                    success: function () {
                        data.action = "editUserInfo"
                        form.render();
                        form.val("editForm", data);
                    }
                });
            }
        });
    });
</script>
</body>
</html>