<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/jsp/main-side.jsp"></jsp:include>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="glyphicon glyphicon-th"></i> 数据列表
			</h3>
		</div>
		<div class="panel-body">
			<form class="form-inline" role="form" style="float: left;">
				<div class="form-group has-feedback">
					<div class="input-group">
						<div class="input-group-addon">查询条件</div>
						<input class="form-control has-success" type="text"
							placeholder="请输入查询条件">
					</div>
				</div>
				<button type="button" class="btn btn-warning">
					<i class="glyphicon glyphicon-search"></i> 查询
				</button>
			</form>
			<button type="button" class="btn btn-danger"
				style="float: right; margin-left: 10px;">
				<i class=" glyphicon glyphicon-remove"></i> 删除
			</button>
			<button type="button" class="btn btn-primary" style="float: right;"
				onclick="window.location.href='form.html'">
				<i class="glyphicon glyphicon-plus"></i> 新增
			</button>
			<br>
			<hr style="clear: both;">
			<div class="table-responsive">
				<table class="table  table-bordered">
					<thead>
						<tr>
							<th width="30">#</th>
							<th width="30"><input type="checkbox"></th>
							<th>名称</th>
							<th width="100">操作</th>
						</tr>
					</thead>
					<tbody>
						<!-- 列表数据这里插入 -->
						
						
					</tbody>
					<tfoot>
						<tr>
							<td colspan="6" align="center">
								<ul class="pagination">
									<li class="disabled"><a href="#">上一页</a></li>
									<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
									<li><a href="#">2</a></li>
									<li><a href="#">3</a></li>
									<li><a href="#">4</a></li>
									<li><a href="#">5</a></li>
									<li><a href="#">下一页</a></li>
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
	$(function() {
		$(".list-group-item").click(function() {
			if ($(this).find("ul")) {
				$(this).toggleClass("tree-closed");
				if ($(this).hasClass("tree-closed")) {
					$("ul", this).hide("fast");
				} else {
					$("ul", this).show("fast");
				}
			}
		});
		getRolesByPageNo(1);
	});

	$("tbody .btn-success").click(function() {
		window.location.href = "assignPermission.html";
	});
	
	//发送ajax获取数据
	function getRolesByPageNo(pageNo){
		var loadingTip;

		$.ajax({
			
			"url" : "${APP_PATH }/role/listroles.do",
			"type" :"post",
			"data" : {},
			"beforeSend" : function(){loadingTip = layer.msg('处理中', {icon: 16});},
			"success" : function(result){
				layer.close(loadingTip);
				var roleDataHtml="";  //拼接数据
				//也可用jquery循环：$.each(list/Array,function(i,n){})
				$.each(result.page.dataList,function(i,val){
					//注意：里面双引号外面就单引号
					roleDataHtml +='<tr>                                                  ';
					roleDataHtml +='<td>'+(i+1)+'</td>                                            ';
					roleDataHtml +='<td><input type="checkbox"></td>                      ';
					roleDataHtml +='<td>'+(val.name)+'</td>                                ';
					roleDataHtml +='<td>                                                  ';
					roleDataHtml +='	<button type="button" class="btn btn-success btn-xs"  onclick = "window.location.href = \'${APP_PATH }/role/assign.do?id='+val.id+'\'">';
					roleDataHtml +='		<i class=" glyphicon glyphicon-check" ></i>      ';
					roleDataHtml +='	</button>                                           ';
					roleDataHtml +='	<button type="button" class="btn btn-primary btn-xs">';
					roleDataHtml +='		<i class=" glyphicon glyphicon-pencil"></i>     ';
					roleDataHtml +='	</button>                                           ';
					roleDataHtml +='	<button type="button" class="btn btn-danger btn-xs">';
					roleDataHtml +='		<i class=" glyphicon glyphicon-remove"></i>     ';
					roleDataHtml +='	</button>                                           ';
					roleDataHtml +='</td>                                                 ';
					roleDataHtml +='</tr>                                                 ';
				})
				 //更新tbody,刷新数据
                $("tbody").html(roleDataHtml);
			},
			"error"  : function(error){
				layer.close(loadingTip);
				layer.msg("出错啦，sorry~~");	
			}
		})
		
	}
	
	
</script>
</body>
</html>
>
