<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title>添加信息</title>
		<style type="text/css">

			
			h3 {
				text-align: center;
			}
			


		</style>
		<link rel="stylesheet" href="layui/css/layui.css" />
		<script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
		<script type="text/javascript" src="layui/layui.js"></script>
	</head>

	<body>
		<div>
			<h3>添加员工信息</h3>
			<form class="layui-form" action="">
				<div class="layui-form-item">
					<label class="layui-form-label">姓名</label>
					<div class="layui-input-block">
						<input type="text" name="name" lay-verify="required" autocomplete="off" placeholder="请输入标题" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">性别</label>
					<div class="layui-input-block">
						<input type="radio" name="sex" value="男" title="男" checked="">
						<input type="radio" name="sex" value="女" title="女">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">年龄</label>
					<div class="layui-input-block">
						<input type="text" name="age" lay-verify="required|age" lay-reqtext="用户名是必填项，岂能为空？" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>

				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">手机号</label>
						<div class="layui-input-inline">
							<input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input">
						</div>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
						<button type="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div>

		<script>
            //一般直接写在一个js文件中
            layui.use(['layer', 'form'], function(){
                var layer = layui.layer
                    ,form = layui.form;

                //自定义验证规则
                form.verify({
                    phone: [
                        /^1[3578]\d{9}$/
                        ,'手机格式不正确'
                    ],
					age: [
						/^[1-9]\d{0,2}$/
						,'年龄格式不正确'
					]

                });

                //监听提交
                form.on('submit(demo1)', function(data){
                    // JSON.stringify 将js对象转为json格式的字符串
                    // data.field 表单中提交的数据
//                    layer.alert(JSON.stringify(data.field), {
//                        title: '最终的提交信息'
//                    })
                    $.ajax({
                        type:"post",
                        url:"add.do",
                        data:data.field,
                        dataType:"json",
                        success:function(data){  //{code:1,info:....}
                            if(data.code == 1){
                                var t = parent.layui.table;
                                t.reload('demo');// 重新加载页面,demo 表示父窗体table标签的id值
                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                parent.layer.close(index); //再执行关闭
                            }else{
                                alert(data.info);
                            }
                        }
                    })


                    // 阻止默认的提交
                    return false;
                });

                //layer.msg('Hello World');
            });
		</script>


	</body>

</html>