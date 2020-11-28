<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="zxksglxtWeb.Default" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <%--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">--%>
  <title>在线考试管理系统</title>
  <link rel="stylesheet" href="layui/css/layui.css">
    <style>
        .layui-body{
            overflow-y:hidden;
            overflow-x:hidden;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo"><h3>在线考试管理系统</h3></div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item layui-this"><a href="Welcome.aspx" target="mainFrame">控制台</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <%--<img src="<%=LoginUser==null?"#":LoginUser.imageUrl %>" class="layui-nav-img">
          <%=LoginUser==null?"未登录":LoginUser.name %>--%>
        </a>
        <dl class="layui-nav-child">
          <dd><a href="javascript:void(0)" id="xgxx" target="mainFrame">修改信息</a></dd>
          <dd><a href="javascript:void(0)" id="xgmm" target="mainFrame">密码修改</a></dd>
          <dd><a href="Login.aspx">退出系统</a></dd>
        </dl>
      </li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <li class="layui-nav-item"><a href="#" target="mainFrame">测试</a></li>
        <li class="layui-nav-item">
          <a class="" href="javascript:;">基础数据</a>
          <dl class="layui-nav-child">
            <dd><a href="/Admin/ExamDesc.aspx" target="mainFrame">题库维护</a></dd>  
            <dd><a href="/Admin/UserInfo.aspx" target="mainFrame">用户维护</a></dd>  
          </dl>
        </li>
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <iframe name="mainFrame" style="border:none;width:100%;height:100%;" src="Welcome.aspx"></iframe>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © layui.com - 底部固定区域
  </div>
</div>
<script type="text/html" id="changePwdForm">
    <form class="layui-form" action="" style="padding:10px;" lay-filter="changePwdForm">
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">新密码</label>
        <div class="layui-input-block">
                <input type="password" name="newPwd1" lay-verify="required" lay-reqtext="新密码是必填项，岂能为空？" autocomplete="off" placeholder="请输入新密码" class="layui-input">
        </div>
        </div>
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">重复新密码</label>
        <div class="layui-input-block">
                <input type="password" name="newPwd2" lay-reqtext="重复新密码是必填项，岂能为空？" autocomplete="off" placeholder="请输入重复新密码" class="layui-input">
        </div>
        </div>
            
        <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnChangePwd" id="btnSave">修改密码</button>
        </div>
        </div>
    </form>
</script>
<script type="text/html" id="changeProfile">
    <form class="layui-form" action="" style="padding:10px;" lay-filter="changeProfile">
         <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">头像</label>
            <div class="layui-input-block">
                <div class="layui-upload">
                  <button type="button" class="layui-btn" id="test1">上传图片</button>
                  <div class="layui-upload-list">
                    <img class="layui-upload-img" id="demo1" style="width:100px;height:100px;">
                    <p id="demoText"></p>
                  </div>
                </div>   
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">头像地址</label>
        <div class="layui-input-block">
            <input type="text" name="imageUrl" readonly="readonly" lay-verify="required" lay-reqtext="头像地址是必填项，岂能为空？" autocomplete="off" placeholder="请输入头像地址" class="layui-input">
        </div>
        </div>
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">联系电话</label>
        <div class="layui-input-block">
            <input type="text" name="phone" lay-verify="required" lay-reqtext="联系电话是必填项，岂能为空？" autocomplete="off" placeholder="请输入联系电话" class="layui-input">
        </div>
        </div>
        <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">联系地址</label>
        <div class="layui-input-block">
                <input type="text" name="address" lay-reqtext="联系地址是必填项，岂能为空？" autocomplete="off" placeholder="请输入联系地址" class="layui-input">
        </div>
        </div>
            
        <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnChangeProfile" id="btnSave">修改信息</button>
        </div>
        </div>
    </form>
</script>
<script src="layui/layui.js"></script>
<script>
//JavaScript代码区域
    layui.use(['element', 'layer', 'form','upload'], function(){
    var element = layui.element,
        $ = layui.$,
        form = layui.form,
        layer = layui.layer,
            upload = layui.upload;

    
    $("#xgmm").click(function () {
        layer.open({
            type: 1,
            area: ['300px', '230px'],
            fixed: false, //不固定
            content: $("#changePwdForm").html(),
            success: function () {

            }
        });
    }); $("#xgxx").click(function () {
        layer.open({
            type: 1,
            area: ['500px', '480px'],
            fixed: false, //不固定
            content: $("#changeProfile").html(),
            success: function () {
                var index = layer.load(0, {
                    shade: [0.1, '#fff'] //0.1透明度的白色背景
                });
                $.ajax({
                    url: "/Default.aspx",
                    data: {action:"getProfile"},
                    dataType: "json",
                    type: "post",
                    success: function (res) {
                        layer.close(index);
                        if (res.code === 0) { //成功
                            var index1;
                            //普通图片上传
                            var uploadInst = upload.render({
                                elem: '#test1'
                                , url: '/Default.aspx?action=uploadImg' //改成您自己的上传接口
                                , before: function (obj) {
                                    index1 = layer.load(0, {
                                        shade: [0.1, '#fff'] //0.1透明度的白色背景
                                    });
                                    //预读本地文件示例，不支持ie8
                                    obj.preview(function (index, file, result) {
                                        $('#demo1').attr('src', result); //图片链接（base64）
                                    });
                                }
                                , done: function (res) {
                                    layer.close(index1);
                                    //如果上传失败
                                    if (res.code > 0) {
                                        return layer.msg('上传失败');
                                    }
                                    //上传成功

                                    $("input[name='imageUrl']").val(res.data.fileUrl);
                                }
                                , error: function () {
                                    layer.close(index1);
                                    //演示失败状态，并实现重传
                                    var demoText = $('#demoText');
                                    demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                                    demoText.find('.demo-reload').on('click', function () {
                                        index1 = layer.load(0, {
                                            shade: [0.1, '#fff'] //0.1透明度的白色背景
                                        });
                                        uploadInst.upload();
                                    });
                                }
                            });


                            form.val("changeProfile", res.data);
                            $('#demo1').attr('src', res.data.imageUrl); //图片链接（base64）
                        } else {
                            layer.msg("获取个人信息失败\r\n错误原因：" + res.msg);
                        }
                    },
                    error: function (a, b, c) {
                        layer.close(index);
                        layer.msg("请求出错\r\n错误代码：" + a.status + ",错误原因：" + a.statusText)
                    }
                });
            }
        });
    });
    form.on("submit(btnChangePwd)", function (data) {
        var formData = data.field;
        if (formData.newPwd1 !== formData.newPwd2) {
            layer.msg("两次密码输入不一致");
            return false;
        }
        formData.action = "changePwd";
        $.ajax({
            url: "/Default.aspx",
            data: formData,
            dataType: "json",
            type: "post",
            success: function (res) {
                if (res.code === 0) { //成功
                    layer.closeAll();
                    layer.msg("修改成功");
                } else {
                    layer.msg("修改失败\r\n错误原因：" + res.msg);
                }
            },
            error: function (a, b, c) {
                layer.msg("请求出错\r\n错误代码：" + a.status + ",错误原因：" + a.statusText)
            }
        });
        return false;
    });
    form.on("submit(btnChangeProfile)", function (data) {
        var formData = data.field;
        formData.action = "changeProfile";
        $.ajax({
            url: "/Default.aspx",
            data: formData,
            dataType: "json",
            type: "post",
            success: function (res) {
                if (res.code === 0) { //成功
                    layer.closeAll();
                    layer.msg("修改成功");
                } else {
                    layer.msg("修改失败\r\n错误原因：" + res.msg);
                }
            },
            error: function (a, b, c) {
                layer.msg("请求出错\r\n错误代码：" + a.status + ",错误原因：" + a.statusText)
            }
        });
        return false;
    });
    $.ajax({
        url: "/Default.aspx",
        data: {action:"checkLoginUser"},
        dataType: "json",
        type: "post",
        success: function (res) {
            if (res.code !== 0) { //成功
                layer.alert(res.msg, function () {
                    window.location.href = "Login.aspx";
                });
            }
        },
        error: function (a, b, c) {
            layer.alert("请求出错\r\n错误代码：" + a.status + ",错误原因：" + a.statusText, function () {
                window.location.href = "Login.aspx";
            });
        }
    });
});
</script>
</body>
</html>
