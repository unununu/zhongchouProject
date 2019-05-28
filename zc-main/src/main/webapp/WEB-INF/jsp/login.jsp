<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header"> 
          <div><a class="navbar-brand" href="index.html" style="font-size:32px;">0317众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">
	
	<!-- 登陆表单 -->
      <form  id = "login_form" action = "${APP_PATH }/doLogin.do"  method = "post" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
		  <div class="form-group has-success has-feedback">
		  <!-- 同步提交表单用：用户信息不对，给的提示 -->
		  ${exMessage }
			<!-- 账号 -->
			<input name = "loginacct" type="text" id = "floginacct"  class="form-control" id="inputSuccess4" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
		   <!-- 密码-->
			<input name = "userpswd" type="password"  id = "fuserpswd" class="form-control" id="inputSuccess4" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
		  <!-- 类型 -->
			<select class="form-control" name = "type"  id = "ftype" >
                <option value="member">会员</option>
                <option value="user" selected >管理</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
          <br>
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="reg.html">我要注册</a>
          </label>
        </div>
        <!-- 提交 -->
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
      </form>
    </div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH }/jquery/layer/layer.js"></script>
    <script>
    function dologin() {
    	
    	var loginacct = $("#floginacct").val();
    	var userpswd = $("#fuserpswd").val();
    	var type = $("#ftype").val();
    	var loadingTip;
    	/* 异步提交表单数据：默认异步，不锁定浏览器且局部刷新 */
    	$.ajax({
    		"type" : "post",
    		"url"  : "${APP_PATH }/doLogin.do",
    		
    		/* 要发送的数据 ：jqury会转成参数的格式*/
    		"data" : {
    			"loginacct" : loginacct,
    			"userpswd"  : userpswd,
    			"type"		: type
    		},
    		/* 发送前执行：可参数检查：返回false表取消本次请求 */
    		"beforeSend" :function(){
    			//注意：这里文本框空的，得到的是"",不是null
    			if($.trim(loginacct) =="" || $.trim(userpswd) ==""){
    				layer.msg("用户名与密码不可为空", {time:2000, icon:5, shift:6});
    				$("#floginacct").focus(); //焦点回到第一个控件上
    				return false;			  
    			}else{
    				loadingTip = layer.msg('处理中...', {icon: 16});
    			}
    		},
    		
    		/* 发送成功后 */
    		"success" : function(result){  //jquery将json字串转为对象了(服务器发过来的头contentype表json)，直接用json结构见Java代码
    			
    			if(result.success == true){
    				layer.close(loadingTip);
    				layer.msg("登陆成功", {time:2000, icon:6, shift:6});
    				//跳转页面:会员跳主页，管理跳后台
    				if(type == "member"){
    					window.location.href = "${APP_PATH }/index.htm"
    				}else{
    					window.location.href = "${APP_PATH }/main.htm"
    				}
    			}else{
    				layer.msg(result.message, {time:5000, icon:5, shift:6});
    			}
    			
    			
    		},
    		
    		/* 出错 */
    		"error" : function(){
    			layer.close(loadingTip);
    			layer.msg("遇到问题", {time:2000, icon:5, shift:6});
    		}
    		
    		
    	})
    	
    	
    	
    	
    	
    	
    	/* 同步提交表单数据
        $("#login_form").submit();
    	 */
    }
    </script>
  </body>
</html>