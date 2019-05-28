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
      <input class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='add.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
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
              
              <!-- 同步方式对应 -->
               <tbody>
              

					   <c:forEach var="user"   items="${userPage.dataList }"   varStatus="status"  >
								   <tr>
					                  <td>${status.count }</td>
									  <td><input type="checkbox"></td>
					                  <td>${user.loginacct }</td>
					                  <td>${user.username }</td>
					                  <td>${user.email }</td>
					                  <td>
									      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
									      <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
										  <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
									  </td>
					                </tr>
					   </c:forEach>
              </tbody>
               <!-- 分页查询：使用同步请求：url地址栏请求 -->
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination">
						<!-- 上一页链接 -->
						<c:if test="${userPage.pageNo <= 1}">
							<li class="disabled"><a href="javascript:void(0)">上一页</a></li>
						</c:if>
						<c:if test="${userPage.pageNo > 1}">
							<li><a href = "javascript:void(0)" onclick="goPageNo(${userPage.pageNo-1})">上一页</a></li>
						</c:if>
								<!-- 循环列表:没有列表对象的循环：指定开始与结束的数字 -->
								<c:forEach var = "i" begin = "1" end ="${userPage.pageSize }">
								
									<!-- 点击后的样式 -->
									<li
										<c:if test="${userPage.pageNo == i}">
												class = "active" 
										</c:if>
									>
										<a href="javascript:void(0)" onclick = "goPageNo(${i })">${i }</a>
									</li>
								
								</c:forEach>
						<!-- 下一页链接 -->
						<c:if test="${userPage.pageNo >= userPage.totalPageCount }">
							<li class="disabled"><a href="javascript:void(0)">下一页</a></li>
						</c:if>
						<c:if test="${userPage.pageNo < userPage.totalPageCount }">
							<li><a href="javascript:void(0)" onclick = "goPageNo(${userPage.pageNo+1})">下一页</a></li>
						</c:if>
						
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
            
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
            
            /* 分页链接点击 */
            function goPageNo(pageNo){
            	 window.location.href = "${APP_PATH }/user/list.do?pageNo="+pageNo;
            }
            
        </script>
  </body>
</html>
