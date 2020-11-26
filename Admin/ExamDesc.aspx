<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamDesc.aspx.cs" Inherits="zxksglxtWeb.Admin.ExamDesc" %>

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
        #card3{
            position:absolute;
            top:5px;
            left:5px;
            right:5px;
            height:40px;
        }

        #card4{
            position:absolute;
            top:50px;
            left:5px;
            width:300px;
            height:50px;
            border-bottom:3px solid #f5f5f5;
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
            top:102px;
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
              <a href="#">首页</a>
              <a><cite>导航元素</cite></a>
            </span>
        </div>
    </div>
    <div class="layui-card" id="card4">
        <div class="layui-card-body">
            <button class="layui-btn layui-btn-sm" id="btnAdd"><i class="layui-icon layui-icon-add-1"></i></button>
            <button class="layui-btn layui-btn-sm" id="btnEdit"><i class="layui-icon layui-icon-edit"></i></button>
            <button class="layui-btn layui-btn-sm layui-btn-danger" id="btnDel"><i class="layui-icon layui-icon-delete"></i></button>
        </div>
    </div>
    <div class="layui-card" id="card1">
        <div class="layui-card-body">
            <div id="test1" class="demo-tree demo-tree-box"></div>
        </div>
    </div>
            
    <div class="layui-card"  id="card2">
        <div class="layui-card-body">
            <blockquote class="layui-elem-quote" id="exam_desc_title"></blockquote>
            <table class="layui-hide" id="test" lay-filter="test"></table>
 
            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
                <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
                <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
                </div>
            </script>
 
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
        </div>
    </div>
    <script src="../layui/layui.js"></script>
    <script>
        layui.use(["element", "tree", "layer", "table"], function () {
            var element = layui.element,
                tree = layui.tree,
                layer = layui.layer,
                table = layui.table,
                $ = layui.$;
            var selectedExamDesc = {};
            getTree();
            function reloadTree(data_exam_desc) {
                if (data_exam_desc.length <= 0) {
                    selectedExamDesc = {};
                    return;
                }
                var pp = [];
                pp.push({ title: "试题库", id: 0, spread: true, children: data_exam_desc });
                tree.render({
                    id: "test1",
                    elem: "#test1", data: pp, showCheckbox: true, click: function (obj) {
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

                
                selectedExamDesc = data_exam_desc[0];
                selectChanged(selectedExamDesc);
            }

            function selectChanged(data) {
                if (data === undefined) {
                    return;
                }
                $("#exam_desc_title").html(data.title);

                table.render({
                    elem: '#test'
                    , url: '/Admin/ExamDesc.aspx'
                    , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                    , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                        title: '提示'
                        , layEvent: 'LAYTABLE_TIPS'
                        , icon: 'layui-icon-tips'
                    }]
                    , where:{
                        action: "getExam",
                        examDescription_id: selectedExamDesc.id
                    }
                    , title: '用户数据表'
                    , cols: [[
                        { type: 'checkbox', fixed: 'left' }
                        , { field: 'orderNo', title: '序号', width: 80, unresize: true, sort: true }
                        , { field: 'type', title: '类型', width: 80 , sort: true }
                        , { field: 'score', title: '分值', width: 80  , sort: true }
                        , { field: 'title', title: '题目', width: 150 }
                        , { field: 'correctResult', title: '正确答案', width: 120 }
                        , { field: 'resultA', title: '选项A', width: 150 }
                        , { field: 'resultB', title: '选项B', width: 150 }
                        , { field: 'resultC', title: '选项C', width: 150 }
                        , { field: 'resultD', title: '选项D', width: 150 }
                    ]]
                    , page: true
                });
            }

            function getTree() {
                layer.load(0, {
                    shade: [0.1, '#fff'] //0.1透明度的白色背景
                });
                $.ajax({
                    data: {action:"getExamDesc"},
                    dataType: "json",
                    type: "post",
                    url: "/Admin/ExamDesc.aspx",
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

            function delExamDesc(data) {
                layer.load(0, {
                    shade: [0.1, '#fff'] //0.1透明度的白色背景
                });
                $.ajax({
                    data: { action: "delExamDesc", data: JSON.stringify(data) },
                    dataType: "json",
                    type: "post",
                    url: "/Admin/ExamDesc.aspx",
                    success: function (res) {
                        if (res.code === 0) {
                            layer.closeAll();
                            getTree();
                        } else {
                            layer.closeAll();
                            layer.msg("删除试卷信息失败，错误信息：" + res.msg);
                        }
                    },
                    error: function (a, b, c) {
                        layer.closeAll();
                        layer.msg("发生异常，错误代码" + a.status + ",错误信息" + a.statusText);
                    }
                })


            }
            $("#btnDel").click(function () {
                var checkedData = tree.getChecked("test1");
                if (checkedData.length <= 0) {
                    layer.msg("请勾选要删除的记录");
                    return;
                }
                var tmp = [];
                $.each(checkedData, function (key1, val1) {
                    $.each(val1.children, function (key2, val2) {
                        tmp.push(val2.id);
                    });
                });
                delExamDesc(tmp);
            });
            
            $("#btnEdit").click(function () {
                if (selectedExamDesc.length <= 0) {
                    layer.msg("没有要修改的记录");
                    return;
                }
            });
            //头工具栏事件
            table.on('toolbar(test)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id);
                switch (obj.event) {
                    case 'getCheckData':
                        var data = checkStatus.data;
                        layer.alert(JSON.stringify(data));
                        break;
                    case 'getCheckLength':
                        var data = checkStatus.data;
                        layer.msg('选中了：' + data.length + ' 个');
                        break;
                    case 'isAll':
                        layer.msg(checkStatus.isAll ? '全选' : '未全选');
                        break;

                    //自定义头工具栏右侧图标 - 提示
                    case 'LAYTABLE_TIPS':
                        layer.alert('这是工具栏右侧自定义的一个图标按钮');
                        break;
                };
            });

            //监听行工具事件
            table.on('tool(test)', function (obj) {
                var data = obj.data;
                //console.log(obj)
                if (obj.event === 'del') {
                    layer.confirm('真的删除行么', function (index) {
                        obj.del();
                        layer.close(index);
                    });
                } else if (obj.event === 'edit') {
                    layer.prompt({
                        formType: 2
                        , value: data.email
                    }, function (value, index) {
                        obj.update({
                            email: value
                        });
                        layer.close(index);
                    });
                }
            });
        });
    </script>
</body>
</html>
