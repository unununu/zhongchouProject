<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>


		<jsp:include page="/WEB-INF/jsp/main-side.jsp"></jsp:include>



        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
		<form class="form-inline" role="form" style="float:left;">
		  <div class="form-group has-feedback">
		    <div class="input-group">
		      <div class="input-group-addon">查询条件</div>
		      <input id = "searchText" class="form-control has-success" type="text" placeholder="请输入查询条件">
		    </div>
		  </div>
		  <button id = "searchButton" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
		</form>
		
	<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
	<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/user/add.htm'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox"></th>
                  <th>账号</th>
                  <th>名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              
             
               <tbody>
              	
 						 <!-- user data goes here -->
					   
              </tbody>
              
           
               <!-- 分页查询：使用同步请求：url地址栏请求 -->
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
				     	 <ul id = "pageIndex" class="pagination">
						   <!-- page index goes here -->
						 </ul>
					 </td>
				 </tr>

			  </tfoot>
			  
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>

    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/script/docs.min.js"></script>
	<script src="${APP_PATH }/jquery/layer/layer.js"></script>

	
        <script type="text/javascript">
        	//$(function(){}) 里面的函数在DOM文档加载完成后执行，等效于 $(document.ready(function(){...}); 			
        	//$(".xxx")根据class取对象  $("#xxx")根据id取对象 $("XXX") 直接取改类型的元素对象
        	
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
			    
			    //调用：发送ajax请求获取第一页用户列表
			    getUserData(1);
			    
            });
            
        	
        	
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
            
            /*定义一个全局对象：记录查询条件*/
            var searchText_username;
            
            /* 给模糊查询按钮绑定事件*/
            $("#searchButton").click(function(){
                text = $("#searchText").val(); 
            	if(text ==""){
            		layer.msg('输入不可为空');
            	}else{//发送ajax
            		searchText_username = text;  //点击按钮更新对象
            		getUserData(1,searchText_username);
            	}
            	
            })
            
            
            
            /* 分页链接点击 */
            function goPageNo(pageNo){
            	getUserData(pageNo,searchText_username);
            }
            
            
            /*定义函数：功能：ajax获取user列表数据：返回page */
            function getUserData(pageno,seachText){
            	var loadingTip;
            	$.ajax({
            		
					"type" : "post",
					"url"  :  "${APP_PATH}/user/queryUserlist.do",
					//要发送的数据
					"data" : {"pageNo" : pageno , "seachText" : seachText}, 
					"beforeSend" : function(){
						loadingTip = layer.msg('处理中', {icon: 16});
					},
					"success" : function(result){
						layer.close(loadingTip);
						
						var page = result.page;
						if(result.success == true){
							/*
								用户列表
							*/
							var userDataHtml="";  //拼接用户数据
							//也可用jquery循环：$.each(list/Array,function(i,n){})
							for(var i = 0; i<page.dataList.length;i++){
								var user = page.dataList[i];
								//注意：里面双引号外面就单引号
								userDataHtml +='<tr>';  
								userDataHtml +='	<td>'+(i+1)+'</td>';
								userDataHtml +='	<td><input type="checkbox"></td>';
								userDataHtml +='	<td>'+user.loginacct+'</td>';
								userDataHtml +='	<td>'+user.username+'</td>';
								userDataHtml +='	<td>'+user.email+'</td>';
								userDataHtml +='	<td>';                                                                                                           
								userDataHtml +='		<button type="button" class="btn btn-success btn-xs"  onclick = "window.location.href = \'${APP_PATH }/user/assignRole.do?id='+user.id+'\'"><i class=" glyphicon glyphicon-check"></i></button>'; //修改角色
								userDataHtml +='		<button type="button" class="btn btn-primary btn-xs" onclick = "window.location.href = \'${APP_PATH }/user/update.do?id='+user.id+'\'" ><i class=" glyphicon glyphicon-pencil"></i></button>';//修改按钮
								userDataHtml +='		<button type="button" class="btn btn-danger btn-xs" onclick = ifDelectUser("'+user.id+'","'+user.loginacct+'") ><i class=" glyphicon glyphicon-remove"></i></button>';//删除按钮
								userDataHtml +='	</td>';																	/* 注意：每个参数都要引号，不然 ifDelectUser(test1,test2)  ==>  test1 与test2被认为是js对象,会去寻找值*/
								userDataHtml +='</tr>';																		/* 注意：每个参数都要引号，不然 ifDelectUser('test1','test2')  ==>  test1 与test2被认为是字符串*/
							}
							 //更新tbody,刷新用户数据
			                $("tbody").html(userDataHtml);
							 
							 /*
							 	分页
							 */
			                var pageIndexDataHtml ="";
							 //上一页
							if(page.pageNo >1 ){
								pageIndexDataHtml += '<li><a href = "javascript:void(0)" onclick="goPageNo('+(page.pageNo-1)+')">上一页</a></li>';
							}else{
								pageIndexDataHtml +='<li class="disabled"><a href="javascript:void(0)">上一页</a></li>';
							}
							

							for(var i =1 ; i <=page.totalPageCount ;i++){
								
								pageIndexDataHtml +='<li';
									if(page.pageNo == i){
										pageIndexDataHtml +=' class = "active" '; //注意：拼接串时有些必要的空格,如：<liclass 与<li class
									}
								pageIndexDataHtml +='>';
								pageIndexDataHtml +='<a href="javascript:void(0)" onclick = "goPageNo('+i+')">'+i+'</a>';
								pageIndexDataHtml +='</li>';
							
							}
							
							//下一页
							if(page.totalPageCount > page.pageNo ){
								pageIndexDataHtml += '<li><a href="javascript:void(0)" onclick = "goPageNo('+(page.pageNo+1)+')">下一页</a></li>';
							}else{
								pageIndexDataHtml +='<li class="disabled"><a href="javascript:void(0)">下一页</a></li>';
							}
						
			               $("#pageIndex").html(pageIndexDataHtml);
							 
						}else{
							 layer.msg("服务器出错，sorry~~"+result.message);
								
						}
					
					},
					"error" : function(error){
						layer.close(loadingTip);
						layer.msg("出错啦，sorry~~");	
					 }
            	})
            }
            
            
            
            
			/* 删除功能 */
			
			function ifDelectUser(userId,loginacct){
				layer.confirm("是否确定删除，账号为("+loginacct+")的用户?",  {icon: 3, title:'提示'}, function(cindex){
				    layer.close(cindex);
				    //确认删除
				    delectUser(userId);
				}, function(cindex){
				    layer.close(cindex);
				    //不确认删除
				    return;
				});
			}	
			
			
			function delectUser(userId){
				var loadingTip ;
				$.ajax({
					"type" : "post",    
					"url":"${APP_PATH}/user/delectUser.do",
					"data" :{"id" : userId},
					"beforeSend" :function(){
						loadingTip = layer.msg('处理中', {icon: 16});
						
					},
					"success" :function(result){
						layer.close(loadingTip);
						if(result.success){
							layer.msg("删除成功", {time:1000, icon:4, shift:6});
							 getUserData(1);
						}else{
							layer.msg("删除失败", {time:1000, icon:5, shift:6});
						}
					},
					"error" :function(result){
						layer.close(loadingTip);
						layer.msg("出现错误："+result.message, {time:1000, icon:5, shift:6});
					}
				})
				
			};
			
            
            
            
            
            
            
        </script>
  </body>
</html>
