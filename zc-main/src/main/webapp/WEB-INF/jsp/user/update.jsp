<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/WEB-INF/jsp/main-side.jsp"></jsp:include>
    
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="${APP_PATH }/main.htm">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form" id="userInputForm">
				  <div class="form-group">
					<label for="floginacct">登陆账号</label>
					<input type="text" class="form-control" id="floginacct" value="${requestScope.selectedUserdata.loginacct }">
				  </div>
				  <div class="form-group">
					<label for="fusername">用户名称</label>
					<input type="text" class="form-control" id="fusername" value="${requestScope.selectedUserdata.username }">
				  </div>
				  <div class="form-group">
					<label for="femail">邮箱地址</label>
					<input type="email" class="form-control" id="femail" value="${requestScope.selectedUserdata.email }">
					<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
				  </div>
				  <button type="button" class="btn btn-success" id = "updateBtu"><i class="glyphicon glyphicon-edit"></i> 修改</button>
				  <button type="button" class="btn btn-danger" id = "theResetBtu"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>测试标题1</h4>
				<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>测试标题2</h4>
				<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
			  </div>
		  </div>
		  <!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
		</div>
	  </div>
	</div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/script/docs.min.js"></script>
	<script src="${APP_PATH }/jquery/layer/layer.js"></script>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
            });
            
            
            
            /* 修改按钮注册点击事件 */
            $("#updateBtu").click(function(){
         	   var floginacct = $("#floginacct").val();
         	   var fusername = $("#fusername").val();
         	   var femail = $("#femail").val();
         	   if((floginacct =="")||(fusername =="")||(femail =="")){
         		   layer.msg("三个内容全部不可为空哦");	
         		   return;
         	   }else{
         		   //发送ajax请求
         		   var loadingTip;
         		   $.ajax({
         			   "type" : "post",
         			   "data" :{
         				   "id" : ${requestScope.selectedUserdata.id},
         				   "loginacct" :floginacct,
         				   "username"  :fusername,
         				   "email"	   :femail
         			   },
         			   "url"  :"${APP_PATH}/user/updateUser.do",
         			   "beforeSend" :function(){
         				   loadingTip = layer.msg('处理中...', {icon: 16});
         			   },
         			   "success" :function(result){
         				   layer.close(loadingTip);
    							if(result.success){
    								layer.msg("修改成功");
    								window.location.href = "${APP_PATH}/user/list.htm";
    							}else{
    								layer.msg("修改失败"+result.message);
    							}
         			   },
         			   "error" :function(){
         				   layer.msg("错误");
         			   }
         		   });
         	   }
            });
             
        /* 重置按钮 */    
 		$("#theResetBtu").click(function(){
      	   //方法二：dom对象有个reset()方法，回到最初状态,jquery对象没有注意转成dom对象
      	   $("#userInputForm")[0].reset();
 		
 		});
        </script>
  </body>
</html>
    