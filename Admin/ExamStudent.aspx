<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamStudent.aspx.cs" Inherits="zxksglxtWeb.Admin.ExamStudent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>考试安排</title>
    <link href="../layui/css/layui.css" rel="stylesheet" />
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


        #card1,#card2{
            position:absolute;
            top:50px;
            bottom:5px;
            margin-bottom:0px;
            overflow-y: auto;
        }

        #card1{
            left:5px;
            width:300px;
        }
        #card2 {
            left: 310px;
            right: 5px;
        }
    </style>
</head>
<body>
    <div class="layui-card" id="card3">
        <div class="layui-card-body">
            <span class="layui-breadcrumb">
              <a href="#">业务管理</a>
              <a><cite>考试安排</cite></a>
            </span>
        </div>
    </div>
    <div class="layui-card" id="card1">
        <div class="layui-card-body">
            <div id="test1" class="demo-tree demo-tree-box"></div>
        </div>
    </div>
            
    <div class="layui-card" id="card2">
        <div class="layui-card-body">
            <blockquote class="layui-elem-quote" id="exam_desc_title"></blockquote>
            <table class="layui-hide" id="test" lay-filter="test"></table>
 
            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm" lay-event="refreshExam"><i class="layui-icon layui-icon-refresh"></i>刷新</button>
                <button class="layui-btn layui-btn-sm" lay-event="importStudent"><i class="layui-icon layui-icon-export"></i>导入考生</button>
                </div>
            </script>
 
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
        </div>
    </div>


    <script type="text/html" id="importStudentTable">
        <div style="padding:10px;">
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
                        <button class="layui-btn" id="btnQuery"><i class="layui-icon layui-icon-search"></i>查询</button>
                    </div>
                </div>
            </div>
            <table class="layui-hide" id="testStu" lay-filter="testStu"></table>
            <div>
                <button class="layui-btn" id="btnImport"><i class="layui-icon layui-icon-add-1"></i>导入</button>
            </div>
        </div>
    </script>

    <script src="../layui/layui.js"></script>
    <script>
        layui.use(["element", "tree", "layer", "table", "form"], function () {
            var element = layui.element,
                tree = layui.tree,
                layer = layui.layer,
                table = layui.table,
                $ = layui.$,
                form = layui.form;
            var selectedExamDesc = {};
            var tableIns = table.render({
                elem: '#test'
                , url: '/Admin/ExamStudent.aspx'
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print']
                , where: {
                    action: "getExamStudent",
                    examDescription_id: 0
                }
                , title: $("#exam_desc_title").html()
                , cols: [[
                    { field: 'scode', title: '学号', width: 100, unresize: true, sort: true }
                    , { field: 'sname', title: '姓名', width: 100, sort: true }
                    , { field: 'sfzh', title: '身份证号', width: 180, sort: true }
                    , { field: 'phone', title: '联系电话', width: 150 }
                    , { field: 'kszt', title: '考试状态', width: 150 }
                    , { fixed: 'right', title: '操作', toolbar: '#barDemo', width: 150 }
                ]]
                , page: true
            });
            getTree();
            function reloadTree(data_exam_desc) {
                if (data_exam_desc.length <= 0) {
                    selectedExamDesc = {};
                }
                var pp = [];
                pp.push({ title: "试题库", id: 0, spread: true, children: data_exam_desc });
                tree.render({
                    id: "test1",
                    elem: "#test1", data: pp, click: function (obj) {
                        if (obj.data.id === 0) {
                            return;
                        }
                        selectedExamDesc = obj.data;
                        selectChanged(selectedExamDesc);
                    }, oncheck: function (obj) {

                        console.log(obj);
                    }, operate: function (obj) {
                        var type = obj.type; //得到操作类型：add、edit、del
                        var data = obj.data; //得到当前节点的数据
                        var elem = obj.elem; //得到当前节点元素

                        //Ajax 操作
                        var id = data.id; //得到节点索引
                        if (type === 'update') { //修改节点
                            if (id === 0) {
                                layer.msg("不允许修改根节点");
                                getTree();
                                return;
                            }
                            console.log(elem.find('.layui-tree-txt').html()); //得到修改后的内容
                        } else if (type === 'del') { //删除节点
                            if (id === 0) {
                                layer.msg("不允许删除根节点");
                                getTree();
                                return;
                            }
                            var tmp = [];
                            tmp.push(id);
                            delExamDesc(tmp);
                        };
                    }
                });

                if (data_exam_desc.length <= 0) {
                    reloadExamTable(0);
                    $("#exam_desc_title").html("");
                } else {
                    selectedExamDesc = data_exam_desc[0];
                    selectChanged(selectedExamDesc);
                }
            }

            function reloadExamTable(id) {
                tableIns.reload({
                    where: {
                        action: "getExamStudent",
                        examDescription_id: id
                    }, page: {
                        curr: 1
                    }
                });
            }

            


            function selectChanged(data) {
                if (data === undefined) {
                    return;
                }
                var isPublish = "未发布";
                if (data.isPublished === 1) {
                    isPublish = "已发布";
                }
                $("#exam_desc_title").html("[试卷编号："+data.id+"] - "+data.title+" - 【及格分：<i style='color:red'>"+data.passScore+"</i>分，时间限制：<i style='color:red'>"+data.costTime+"</i>分钟，是否发布：<i style='color:red;font:bold;'>"+isPublish+"</i>】");
                reloadExamTable(data.id);
            }
            


            function getTree() {
                layer.load(0, {
                    shade: [0.1, '#fff'] //0.1透明度的白色背景
                });
                $.ajax({
                    data: { action: "getExamDesc" },
                    dataType: "json",
                    type: "post",
                    url: "/Admin/ExamStudent.aspx",
                    success: function (res) {
                        if (res.code === 0) {
                            layer.closeAll();
                            reloadTree(res.data);
                        } else {
                            layer.closeAll();
                            layer.msg("获取试卷信息失败，错误信息：" + res.msg);
                        }
                    },
                    error: function (a, b, c) {
                        layer.closeAll();
                        layer.msg("发生异常，错误代码" + a.status + ",错误信息" + a.statusText);
                    }
                })
            }
            
           
            form.on("submit(btnSaveExam)", function (data) {
                var formData = data.field;
                if (formData.id === undefined) {
                    formData.id = 0;
                }
                if (formData.id <= 0) {
                    formData.action = "addExam";
                } else {
                    formData.action = "editExam";
                }
                formData.examDescription_id = selectedExamDesc.id;
                layer.load(0, {
                    shade: [0.1, '#fff'] //0.1透明度的白色背景
                });
                $.ajax({
                    data: formData,
                    dataType: "json",
                    type: "post",
                    url: "/Admin/ExamDesc.aspx",
                    success: function (res) {
                        if (res.code === 0) {
                            layer.closeAll();
                            layer.msg("保存成功");
                            getTree();
                        } else {
                            layer.closeAll();
                            layer.msg("保存失败，错误信息：" + res.msg);
                        }
                    },
                    error: function (a, b, c) {
                        layer.closeAll();
                        layer.msg("发生异常，错误代码" + a.status + ",错误信息" + a.statusText);
                    }
                })

                return false;
            });
            


            //头工具栏事件
            table.on('toolbar(test)', function (obj) {
                switch (obj.event) {
                    case "importStudent":
                        layer.open({
                            type: 1,
                            area: ['781px', '433px'],
                            title: "新增",
                            fixed: false, //不固定
                            content: $("#importStudentTable").html(),
                            success: function () {
                                var tableStu = table.render({
                                    elem: '#testStu'
                                    , url: '/Admin/ExamStudent.aspx'
                                    , where: {
                                        action: "queryStudent",
                                        examDescription_id: selectedExamDesc.id
                                    }
                                    , title: "学生信息"
                                    , cols: [[
                                        { type: 'checkbox', fixed: 'left' }
                                        , { field: 'code', title: '学号', width: 100, unresize: true, sort: true }
                                        , { field: 'name', title: '姓名', width: 100, sort: true }
                                        , { field: 'sfzh', title: '身份证号', width: 180, sort: true }
                                        , { field: 'phone', title: '联系电话', width: 150 }
                                    ]]
                                    , height: 260
                                });

                                $("#btnQuery").click(function () {
                                    tableStu.reload({
                                        where: {
                                            action: "queryStudent",
                                            examDescription_id: selectedExamDesc.id,
                                            code: $("#code").val(),
                                            name: $("#name").val()
                                        }
                                    })
                                });

                                $("#btnImport").click(function () {
                                    var checkStatus = table.checkStatus("testStu");
                                    var data = checkStatus.data;
                                    if (data.length <= 0) {
                                        layer.msg("请选择要导入的学生信息");
                                        return;
                                    }
                                    var index = layer.load(0, {
                                        shade: [0.1, '#fff'] //0.1透明度的白色背景
                                    });
                                    $.ajax({
                                        data: { action: "importStudent", data: JSON.stringify(data), examDescription_id: selectedExamDesc.id },
                                        dataType: "json",
                                        type: "post",
                                        url: "/Admin/ExamStudent.aspx",
                                        success: function (res) {
                                            if (res.code === 0) {
                                                layer.closeAll();
                                                layer.msg("导入成功");
                                                reloadExamTable(selectedExamDesc.id);
                                            } else {
                                                layer.closeAll();
                                                layer.msg("导入失败，错误信息：" + res.msg);
                                            }
                                        },
                                        error: function (a, b, c) {
                                            layer.closeAll();
                                            layer.msg("发生异常，错误代码" + a.status + ",错误信息" + a.statusText);
                                        }
                                    });
                                });
                            }
                        });
                        break;
                    case "refreshExam":
                        var id;
                        if (selectedExamDesc.length <= 0) {
                            id = 0;
                        } else {
                            id = selectedExamDesc.id;
                        }
                        reloadExamTable(id);
                        break;
                };
            });
            

            //监听行工具事件
            table.on('tool(test)', function (obj) {
                var data = obj.data;
                //console.log(obj)
                if (obj.event === 'del') {
                    layer.confirm('真的删除行么', function (index) {
                        $.ajax({
                            data: { action: "delExamStudent", id: data.id },
                            dataType: "json",
                            type: "post",
                            url: "/Admin/ExamStudent.aspx",
                            success: function (res) {
                                if (res.code === 0) {
                                    layer.closeAll();
                                    obj.del();
                                    layer.msg("删除成功");
                                } else {
                                    layer.closeAll();
                                    layer.msg("删除失败，错误信息：" + res.msg);
                                }
                            },
                            error: function (a, b, c) {
                                layer.closeAll();
                                layer.msg("发生异常，错误代码" + a.status + ",错误信息" + a.statusText);
                            }
                        });
                    });
                }
            });
        });
    </script>
</body>
</html>
