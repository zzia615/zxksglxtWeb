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
              <a><cite>题库维护</cite></a>
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
            
    <div class="layui-card" id="card2">
        <div class="layui-card-body">
            <blockquote class="layui-elem-quote" id="exam_desc_title"></blockquote>
            <table class="layui-hide" id="test" lay-filter="test"></table>
 
            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm" lay-event="refreshExam"><i class="layui-icon layui-icon-refresh"></i>刷新</button>
                <button class="layui-btn layui-btn-sm" lay-event="addExam"><i class="layui-icon layui-icon-add-1"></i>新增单选/多选题</button>
                <button class="layui-btn layui-btn-sm" lay-event="addExam1"><i class="layui-icon layui-icon-add-1"></i>新增判断题</button>
                <button class="layui-btn layui-btn-sm" lay-event="previewExamDesc"><i class="layui-icon layui-table-view"></i>预览试卷</button>

                </div>
            </script>
 
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
        </div>
    </div>

    <script type="text/html" id="addForm">
        <form class="layui-form" action="" style="padding:10px;">
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">试卷</label>
            <div class="layui-input-block">
                  <input type="text" name="title" lay-verify="required" lay-reqtext="试卷是必填项，岂能为空？" autocomplete="off" placeholder="请输入试卷" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">时间限制</label>
            <div class="layui-input-block">
                  <input type="text" name="costTime" lay-verify="required" lay-reqtext="时间限制是必填项，岂能为空？" autocomplete="off" placeholder="请输入时间限制" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">及格分</label>
            <div class="layui-input-block">
                  <input type="text" name="passScore" lay-verify="required" lay-reqtext="及格分是必填项，岂能为空？" autocomplete="off" placeholder="请输入及格分" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">是否发布</label>
            <div class="layui-input-block">
                  <select name="isPublished" lay-verify="required" lay-reqtext="是否发布是必填项，岂能为空？" autocomplete="off" class="layui-input">
                      <option value="">请选择</option>
                      <option value="0">否</option>                      
                      <option value="1">是</option>
                  </select>
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
		  <div class="layui-form-item layui-form-text" style="display:none">
            <label class="layui-form-label">编码</label>
            <div class="layui-input-block">
                  <input type="text" name="id" lay-verify="required" lay-reqtext="编码是必填项，岂能为空？" autocomplete="off" placeholder="请输入编码" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">试卷</label>
            <div class="layui-input-block">
                  <input type="text" name="title" lay-verify="required" lay-reqtext="试卷是必填项，岂能为空？" autocomplete="off" placeholder="请输入试卷" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">时间限制</label>
            <div class="layui-input-block">
                  <input type="text" name="costTime" lay-verify="required" lay-reqtext="时间限制是必填项，岂能为空？" autocomplete="off" placeholder="请输入时间限制" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">及格分</label>
            <div class="layui-input-block">
                  <input type="text" name="passScore" lay-verify="required" lay-reqtext="及格分是必填项，岂能为空？" autocomplete="off" placeholder="请输入及格分" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">是否发布</label>
            <div class="layui-input-block">
                  <select name="isPublished" lay-verify="required" lay-reqtext="是否发布是必填项，岂能为空？" autocomplete="off" class="layui-input">
                      <option value="">请选择</option>
                      <option value="0">否</option>                      
                      <option value="1">是</option>
                  </select>
            </div>
          </div>
            
          <div class="layui-form-item">
            <div class="layui-input-block">
              <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnSave" id="btnSave">保存</button>
            </div>
          </div>
        </form>
    </script>

    <script type="text/html" id="addExamForm">
        <form class="layui-form" action="" style="padding:10px;">
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">题目</label>
            <div class="layui-input-block">
                  <input type="text" name="title" lay-verify="required" lay-reqtext="题目是必填项，岂能为空？" autocomplete="off" placeholder="请输入题目" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <div class="layui-inline">
            <label class="layui-form-label">题目类型</label>
            <div class="layui-input-inline">
                  <select name="type" lay-verify="required" lay-reqtext="题目类型是必填项，岂能为空？" autocomplete="off" class="layui-input">
                      <option value="">请选择</option>
                      <option value="单选题">单选题</option>                      
                      <option value="多选题">多选题</option>
                  </select>
            </div>
            </div>
            
            <div class="layui-inline">
            <label class="layui-form-label">序号</label>
            <div class="layui-input-inline">
                  <input type="text" name="orderNo" lay-verify="required" lay-reqtext="序号是必填项，岂能为空？" autocomplete="off" placeholder="请输入序号" class="layui-input">
            </div>
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项A</label>
            <div class="layui-input-block">
                  <input type="text" name="resultA" lay-verify="required" lay-reqtext="选项A是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项A" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项B</label>
            <div class="layui-input-block">
                  <input type="text" name="resultB" lay-verify="required" lay-reqtext="选项B是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项B" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项C</label>
            <div class="layui-input-block">
                  <input type="text" name="resultC" lay-verify="required" lay-reqtext="选项C是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项C" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项D</label>
            <div class="layui-input-block">
                  <input type="text" name="resultD" lay-verify="required" lay-reqtext="选项D是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项D" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <div class="layui-inline">
            <label class="layui-form-label">正确答案</label>
            <div class="layui-input-inline">
                  <input type="text" name="correctResult" lay-verify="required" lay-reqtext="正确答案是必填项，岂能为空？" autocomplete="off" placeholder="请输入正确答案" class="layui-input">
            </div>
            </div>
            <div class="layui-inline">
            <label class="layui-form-label">分数</label>
            <div class="layui-input-inline">
                  <input type="text" name="score" lay-verify="required" lay-reqtext="分数是必填项，岂能为空？" autocomplete="off" placeholder="请输入分数" class="layui-input">
            </div>
            </div>
          </div>
            
          <div class="layui-form-item">
            <div class="layui-input-block">
              <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnSaveExam" id="btnSaveExam">保存</button>
              <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
          </div>
        </form>
    </script>
    <script type="text/html" id="editExamForm">
        <form class="layui-form" action="" style="padding:10px;" lay-filter="editExamForm">
		  <div class="layui-form-item layui-form-text" style="display:none">
            <label class="layui-form-label">编码</label>
            <div class="layui-input-block">
                  <input type="text" name="id" lay-verify="required" lay-reqtext="编码是必填项，岂能为空？" autocomplete="off" placeholder="请输入编码" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">题目</label>
            <div class="layui-input-block">
                  <input type="text" name="title" lay-verify="required" lay-reqtext="题目是必填项，岂能为空？" autocomplete="off" placeholder="请输入题目" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <div class="layui-inline">
            <label class="layui-form-label">题目类型</label>
            <div class="layui-input-inline">
                  <select name="type" lay-verify="required" lay-reqtext="题目类型是必填项，岂能为空？" autocomplete="off" class="layui-input">
                      <option value="">请选择</option>
                      <option value="单选题">单选题</option>                      
                      <option value="多选题">多选题</option>
                  </select>
            </div>
            </div>
            
            <div class="layui-inline">
            <label class="layui-form-label">序号</label>
            <div class="layui-input-inline">
                  <input type="text" name="orderNo" lay-verify="required" lay-reqtext="序号是必填项，岂能为空？" autocomplete="off" placeholder="请输入序号" class="layui-input">
            </div>
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项A</label>
            <div class="layui-input-block">
                  <input type="text" name="resultA" lay-verify="required" lay-reqtext="选项A是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项A" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项B</label>
            <div class="layui-input-block">
                  <input type="text" name="resultB" lay-verify="required" lay-reqtext="选项B是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项B" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项C</label>
            <div class="layui-input-block">
                  <input type="text" name="resultC" lay-verify="required" lay-reqtext="选项C是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项C" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项D</label>
            <div class="layui-input-block">
                  <input type="text" name="resultD" lay-verify="required" lay-reqtext="选项D是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项D" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <div class="layui-inline">
            <label class="layui-form-label">正确答案</label>
            <div class="layui-input-inline">
                  <input type="text" name="correctResult" lay-verify="required" lay-reqtext="正确答案是必填项，岂能为空？" autocomplete="off" placeholder="请输入正确答案" class="layui-input">
            </div>
            </div>
            <div class="layui-inline">
            <label class="layui-form-label">分数</label>
            <div class="layui-input-inline">
                  <input type="text" name="score" lay-verify="required" lay-reqtext="分数是必填项，岂能为空？" autocomplete="off" placeholder="请输入分数" class="layui-input">
            </div>
            </div>
          </div>
            
          <div class="layui-form-item">
            <div class="layui-input-block">
              <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnSaveExam" id="btnSaveExam">保存</button>
            </div>
          </div>
        </form>
    </script>

    
    <script type="text/html" id="addExamForm1">
        <form class="layui-form" action="" style="padding:10px;" lay-filter="addExamForm1">
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">题目</label>
            <div class="layui-input-block">
                  <input type="text" name="title" lay-verify="required" lay-reqtext="题目是必填项，岂能为空？" autocomplete="off" placeholder="请输入题目" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <div class="layui-inline">
            <label class="layui-form-label">题目类型</label>
            <div class="layui-input-inline">
                  <select name="type" lay-verify="required" lay-reqtext="题目类型是必填项，岂能为空？" autocomplete="off" class="layui-input">
                      <option value="">请选择</option>
                      <option value="判断题">判断题</option>   
                  </select>
            </div>
            </div>
            
            <div class="layui-inline">
            <label class="layui-form-label">序号</label>
            <div class="layui-input-inline">
                  <input type="text" name="orderNo" lay-verify="required" lay-reqtext="序号是必填项，岂能为空？" autocomplete="off" placeholder="请输入序号" class="layui-input">
            </div>
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项A</label>
            <div class="layui-input-block">
                  <input type="text" name="resultA" lay-verify="required" lay-reqtext="选项A是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项A" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项B</label>
            <div class="layui-input-block">
                  <input type="text" name="resultB" lay-verify="required" lay-reqtext="选项B是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项B" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <div class="layui-inline">
            <label class="layui-form-label">正确答案</label>
            <div class="layui-input-inline">
                  <input type="text" name="correctResult" lay-verify="required" lay-reqtext="正确答案是必填项，岂能为空？" autocomplete="off" placeholder="请输入正确答案" class="layui-input">
            </div>
            </div>
            <div class="layui-inline">
            <label class="layui-form-label">分数</label>
            <div class="layui-input-inline">
                  <input type="text" name="score" lay-verify="required" lay-reqtext="分数是必填项，岂能为空？" autocomplete="off" placeholder="请输入分数" class="layui-input">
            </div>
            </div>
          </div>
            
          <div class="layui-form-item">
            <div class="layui-input-block">
              <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnSaveExam" id="btnSaveExam">保存</button>
              <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
          </div>
        </form>
    </script>
    <script type="text/html" id="editExamForm1">
        <form class="layui-form" action="" style="padding:10px;" lay-filter="editExamForm1">
		  <div class="layui-form-item layui-form-text" style="display:none">
            <label class="layui-form-label">编码</label>
            <div class="layui-input-block">
                  <input type="text" name="id" lay-verify="required" lay-reqtext="编码是必填项，岂能为空？" autocomplete="off" placeholder="请输入编码" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">题目</label>
            <div class="layui-input-block">
                  <input type="text" name="title" lay-verify="required" lay-reqtext="题目是必填项，岂能为空？" autocomplete="off" placeholder="请输入题目" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <div class="layui-inline">
            <label class="layui-form-label">题目类型</label>
            <div class="layui-input-inline">
                  <select name="type" lay-verify="required" lay-reqtext="题目类型是必填项，岂能为空？" autocomplete="off" class="layui-input">
                      <option value="">请选择</option>
                      <option value="判断题">判断题</option>   
                  </select>            
            </div>
            </div>
            <div class="layui-inline">
            <label class="layui-form-label">序号</label>
            <div class="layui-input-inline">
                  <input type="text" name="orderNo" lay-verify="required" lay-reqtext="序号是必填项，岂能为空？" autocomplete="off" placeholder="请输入序号" class="layui-input">
            </div>
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项A</label>
            <div class="layui-input-block">
                  <input type="text" name="resultA" lay-verify="required" lay-reqtext="选项A是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项A" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">选项B</label>
            <div class="layui-input-block">
                  <input type="text" name="resultB" lay-verify="required" lay-reqtext="选项B是必填项，岂能为空？" autocomplete="off" placeholder="请输入选项B" class="layui-input">
            </div>
          </div>
          <div class="layui-form-item layui-form-text">
            <div class="layui-inline">
            <label class="layui-form-label">正确答案</label>
            <div class="layui-input-inline">
                  <input type="text" name="correctResult" lay-verify="required" lay-reqtext="正确答案是必填项，岂能为空？" autocomplete="off" placeholder="请输入正确答案" class="layui-input">
            </div>
            </div>
            <div class="layui-inline">
            <label class="layui-form-label">分数</label>
            <div class="layui-input-inline">
                  <input type="text" name="score" lay-verify="required" lay-reqtext="分数是必填项，岂能为空？" autocomplete="off" placeholder="请输入分数" class="layui-input">
            </div>
            </div>
          </div>
            
          <div class="layui-form-item">
            <div class="layui-input-block">
              <button type="submit" class="layui-btn" lay-submit="" lay-filter="btnSaveExam" id="btnSaveExam">保存</button>
            </div>
          </div>
        </form>
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
                , url: '/Admin/ExamDesc.aspx'
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print']
                , where: {
                    action: "getExam",
                    examDescription_id: 0
                }
                , title: $("#exam_desc_title").html()
                , cols: [[
                    { field: 'orderNo', title: '序号', width: 80, unresize: true, sort: true }
                    , { field: 'type', title: '类型', width: 80, sort: true }
                    , { field: 'score', title: '分值', width: 80, sort: true }
                    , { field: 'title', title: '题目', width: 150 }
                    , { field: 'correctResult', title: '正确答案', width: 120 }
                    , { field: 'resultA', title: '选项A', width: 150 }
                    , { field: 'resultB', title: '选项B', width: 150 }
                    , { field: 'resultC', title: '选项C', width: 150 }
                    , { field: 'resultD', title: '选项D', width: 150 }
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
                        action: "getExam",
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
                            layer.msg("删除试卷信息成功");
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
                //var checkedData = tree.getChecked("test1");
                //if (checkedData.length <= 0) {
                //    layer.msg("请勾选要删除的记录");
                //    return;
                //}
                
                if (selectedExamDesc.length <= 0) {
                    layer.msg("没有要删除的记录");
                    return;
                }
                var tmp = [];
                //$.each(checkedData, function (key1, val1) {
                //    $.each(val1.children, function (key2, val2) {
                //        tmp.push(val2.id);
                //    });
                //});
                tmp.push(selectedExamDesc.id);
                layer.confirm('真的删除数据么', function (index) {
                    delExamDesc(tmp);
                });
            });

            $("#btnEdit").click(function () {
                if (selectedExamDesc.length <= 0) {
                    layer.msg("没有要修改的记录");
                    return;
                }

                layer.open({
                    type: 1,
                    area: ['700px', '400px'],
                    title: "修改",
                    fixed: false, //不固定
                    content: $("#editForm").html(),
                    success: function () {
                        form.render();
                        form.val("editForm", selectedExamDesc);
                    }
                });
            });

            $("#btnAdd").click(function () {
                layer.open({
                    type: 1,
                    area: ['700px', '400px'],
                    title: "新增",
                    fixed: false, //不固定
                    content: $("#addForm").html(),
                    success: function () {
                        form.render();
                    }
                });
            });
            form.on("submit(btnSave)", function (data) {
                var formData = data.field;
                if (formData.id === undefined) {
                    formData.id = 0;
                }
                if (formData.id <= 0) {
                    formData.action = "addExamDesc";
                } else {
                    formData.action = "editExamDesc";
                }
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
                    case "addExam":
                        layer.open({
                            type: 1,
                            area: ['760px', '550px'],
                            title: "新增",
                            fixed: false, //不固定
                            content: $("#addExamForm").html(),
                            success: function () {
                                form.render();
                            }
                        });
                        break;
                    case "addExam1":
                        layer.open({
                            type: 1,
                            area: ['760px', '400px'],
                            title: "新增",
                            fixed: false, //不固定
                            content: $("#addExamForm1").html(),
                            success: function () {
                                form.render();
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
                    case "previewExamDesc":
                        var id;
                        if (selectedExamDesc.length <= 0) {
                            id = 0;
                        } else {
                            id = selectedExamDesc.id;
                        }
                        window.open("/Admin/ExamPreview.aspx?exam_des_id=" + id, "_blank");
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
                            data: { action: "delExam", id: data.id },
                            dataType: "json",
                            type: "post",
                            url: "/Admin/ExamDesc.aspx",
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
                } else if (obj.event === 'edit') {
                    if (data.type === "判断题") {
                        layer.open({
                            type: 1,
                            area: ['760px', '400px'],
                            title: "修改",
                            fixed: false, //不固定
                            content: $("#editExamForm1").html(),
                            success: function () {
                                form.render();
                                form.val("editExamForm1", data);
                            }
                        });
                    } else {
                        layer.open({
                            type: 1,
                            area: ['760px', '550px'],
                            title: "修改",
                            fixed: false, //不固定
                            content: $("#editExamForm").html(),
                            success: function () {
                                form.render();
                                form.val("editExamForm", data);
                            }
                        });
                    }
                }
            });
        });
    </script>
</body>
</html>
