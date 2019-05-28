<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
    <jsp:include page="/WEB-INF/jsp/main-side.jsp"></jsp:include>
    
 <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
				<form role="form" class="form-inline">
				  <div class="form-group">
					<label for="exampleInputPassword1">未分配角色列表</label><br>
					<select id = "unassgined" class="form-control" multiple size="10" style="width:210px;overflow-y:auto;">
					
						<c:forEach items = "${unassginedRoles }" var="role" >
							<option value="${role.id }">${role.name }</option>
						</c:forEach>
                        
                        
                    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li class="btn btn-default glyphicon glyphicon-chevron-right"  id ="leftTorigtht"> </li><!-- 分配角色 -->
                            <br>
                            <li class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px"  id ="rightToleft"></li><!-- 取消角色 -->
                            <br>
                            <br>
                            <li class="btn btn-default glyphicon glyphicon-backward" style="marin-top:20px"  id ="allleftTorigtht"></li><!-- 全取消角色 -->
                        </ul>
				  </div>
				  <div class="form-group" style="margin-left:40px;">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select id = "assgined" class="form-control" multiple size="10" style="width:210px;overflow-y:auto;">
                       <c:forEach items = "${assginedRoles }" var="role" >
							<option value="${role.id }">${role.name }</option>
						</c:forEach>
                        
                    </select>
				  </div>
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
            
            
            
            
			/* selected:被选中的option集合，type:save/remove,表添加或删除 */	
            function doSaveOrRemoveUserRole(selected,type){
            	//未分配的被选中的
            	//var selected = $("#unassgined option:selected");
            	
            	var data = {};
            	data.userId = ${param.id };
            	data.type = type;
            	
            	var loadingTip ;
            	
            	if(selected.size() > 0){
            		$.each(selected,function(i,n){
                		data["ids["+i+"]"] = n.value;
                	});
            		
                 $.ajax({
                		
                		"type" : "post",
                		"url" :"${APP_PATH}/user/doSaveOrRemoveUserRole.do",
                		"data" :data,
                		"beforeSend" :function(){
                			loadingTip = layer.load(2, {time: 10*1000});
                		},
                		"success" :function(result){
                			layer.close(loadingTip);
                			if(result.success){
                				layer.msg("操作成功");
                			}else{
                				layer.msg("操作失败");
                			}
                			//刷新当前页面：重新请求当前角色状态
                			window.location.reload();
                		},
                		"error" : function(){
                			loadingTip.close();
                			layer.msg("抱歉，出现错误");
                		}
                	}); 
                	
            	}else{
            		layer.msg("没有选中哦！");
            	}
            }
            //注意：将回调函数传给click()时，不能有(),有了(),就会立刻执行函数，但是要传参又一定有(),所以 内容放里,相当于函数里调用
            $("#leftTorigtht").click(function(){doSaveOrRemoveUserRole($("#unassgined option:selected"),"save");});
            $("#rightToleft").click(function(){doSaveOrRemoveUserRole($("#assgined option:selected"),"remove")});
            $("#allleftTorigtht").click(function(){doSaveOrRemoveUserRole($("#assgined option"),"remove")});
            
            
            
        </script>
  </body>
</html>
