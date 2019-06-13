<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!--  引入shiro标签 -->
<%@ taglib  uri="http://shiro.apache.org/tags" prefix="shiro" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title>所有员工信息</title>
		<style type="text/css">

			
			h3 {
				text-align: center;
			}
			

		</style>
		<link rel="stylesheet" href="layui/css/layui.css" />
		<script type="text/javascript" src="js/jquery-1.12.2.min.js" ></script>
		<script type="text/javascript" src="layui/layui.js"></script>
	</head>

	<body>
	<!--  显示登录用户的用户名 -->
	<shiro:principal></shiro:principal>
	<a href="logout.do">退出</a>

	<a href="javascript:testPerms()">test</a>


		<div>
			<h3>所有员工信息</h3>
			<button type="button" class="layui-btn" onclick="add()">添加</button>
			<table class="layui-hide" id="demo" lay-filter="test"></table>
		</div>

	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-xs" lay-event="edit">更新</a>
		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
	<script>
        //一般直接写在一个js文件中
        layui.use(['layer', 'form', 'table'], function() {
            var layer = layui.layer, form = layui.form, table = layui.table;

            //执行一个 table 实例
            table.render({
                elem: '#demo'  // table标签的id
                //,height: 420
                , url: 'page.do' //数据接口  跨域
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                    //,curr: 5 //设定初始在第 5 页
                    , groups: 1 //只显示 1 个连续页码
                    , first: false //不显示首页
                    , last: false //不显示尾页
                    , limit: 5
                    , limits: [5, 10, 20]

                } //开启分页
                , cols: [[ //表头
                    {field: 'id', title: '编号', width: 80, sort: true, fixed: 'left'}
                    , {field: 'name', title: '员工名', width: 80}
                    , {field: 'sex', title: '性别', width: 90, sort: true}
                    , {field: 'age', title: '年龄', width: 90, sort: true}
                    , {field: 'phone', title: '手机号', width: 90, sort: true}

                    , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
                ]]
            });

            //监听行工具事件
            table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data //获得当前行数据
                    ,layEvent = obj.event; //获得 lay-event 对应的值
                if(layEvent === 'del'){
                    layer.confirm('真的删除行么', function(index){
                        obj.del(); //删除对应行（tr）的DOM结构
                        layer.close(index);
                        //向服务端发送删除指令
                        $.ajax({
                            type:"get",
                            url:"delete.do?id=" + data.id,
                            dataType:"json",
                            success:function(data){
                                if(data.code == 1){
                                    table.reload('demo');
                                }else{
                                    alert(data.info);
                                }
                            }
                        })
                    });
                } else if(layEvent === 'edit'){
                    //layer.msg('编辑操作');
                    layer.open({
                        type: 2 //此处以iframe举例
                        , title: '修改员工'
                        , area: ['390px', '400px']
                        , content: 'update.jsp?id=' + data.id
                    })
                }
            });
        })
	</script>


		<script type="text/javascript">
			function add(){
                layer.open({
                    type: 2 //此处以iframe举例
                    , title: '添加员工'
                    , area: ['390px', '400px']
                    , content: 'add.jsp'
                })
			}

		</script>

		<script type="text/javascript">
			function delInfo(id){
			    $.ajax({
					type:"get",
					url:"delete.do?id=" + id,
					dataType:"json",
					success:function(data){
						if(data.code == 1){
							loadData();
						}else{
						    alert(data.info);
						}
					}
				})
			}


			function testPerms(){
			    $.ajax({
					type:"get",
					url:"test2.do",
					dataType:"json",
					success:function(data){
					    alert(data.code);
					}
				})
			}

		</script>

	</body>

</html>