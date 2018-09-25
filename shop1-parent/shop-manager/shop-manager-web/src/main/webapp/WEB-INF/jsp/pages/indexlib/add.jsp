<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加订单-后台管理系统-Admin 1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/treeselect.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.11.1.js"></script>
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/treeselect.js" charset="utf-8"></script>--%>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="weadmin-body">
    <form class="layui-form" id="form1" action="${pageContext.request.contextPath}/addScenery.do" lay-filter="formScn">
        <div class="layui-form-item">
            <label for="sname" class="layui-form-label">
                <span class="we-red">*</span>景点名称
            </label>
            <div class="layui-input-inline">
                <input type="text" id="sname" name="sname" required="" lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sprice" class="layui-form-label">
                <span class="we-red">*</span>景点门票
            </label>
            <div class="layui-input-inline">
                <input type="text" id="sprice" name="sprice" required="" lay-verify="number" autocomplete="off"
                       class="layui-input">
                <input type="hidden" id="price" name="price">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="slocation" class="layui-form-label">
                <span class="we-red">*</span>景点位置
            </label>
            <div class="layui-input-inline">
                <input type="text" id="slocation" name="slocation" required="" lay-verify="" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label for="scontent" class="layui-form-label">景点简介</label>
            <div class="layui-input-block">
                <textarea placeholder="" id="scontent" name="scontent" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
             <label for="scnEdit" class="layui-form-label">景点图片</label>
             <div class="layui-input-block">
                 <textarea id="scnEdit" name="sdescribe" class="layui-textarea" style="display: none" lay-verify="content" ></textarea>
             </div>
         </div>
        <div class="layui-form-item">
            <label for="add" class="layui-form-label">
            </label>
            <button id="add" class="layui-btn" lay-filter="add" lay-submit="">增加</button>
        </div>
    </form>
</div>
<script>


    layui.extend({
        admin: '{/}../../static/js/admin',
        treeselect: '{/}../../static/js/treeselect'
    });
    layui.use(['form', 'admin', 'layer', 'layedit', 'treeselect'], function () {
        var form = layui.form,
            admin = layui.admin,
            layer = layui.layer,
            layedit = layui.layedit,
            treeselect = layui.treeselect;

        //初始化树形下拉框
        //treeselect.render(
        //     {
        //
        //
        //         elem: "#cid",
        //         data: [{ //节点
        //             name: arr,
        //             spread: false
        //         }
        //             ]
        /*, children: [{
            name: '子节点11'
        }, {
            name: '子节点12'
        }]
    }, {
        name: '父节点2',
        spread: false
        , children: [{
            name: '子节点21'
        }]
    }],
    method: "GET"*/
        // });

        //第二步
        //初始化富文本编辑器
        var result=layedit.build('scnEdit', {
            height: 100,//设置编辑器高度
            uploadImage: {
                url: '../../uploadImage',
                type: 'post'
            }
        });

        form.verify({
            content: function(value) {

                return layedit.sync(result);
            }
        });




        //监听提交
        form.on('submit(add)', function (data) {

            //设置不能两次点击按钮
            $("#add").addClass('layui-btn-disabled').attr('disabled',"true");
            //异步提交，把数据提交给action
            $.post(
                '${pageContext.request.contextPath}/addScenery.do',
                data.field,
                function (data) {
                    //至少删除一条记录
                    if (data > 0) {

                        layer.msg("恭喜，添加成功！", {icon: 1},function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                            //停留在原来页面刷新
                            window.parent.location.reload();
                        });
                    }else{
                        layer.msg("对不起，添加失败！")
                    }

                }
            );
            return false;
        });



    });


</script>
</body>

</html>