<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
		<jsp:include page="/WEB-INF/jsp/main-side.jsp"></jsp:include>

       
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

			<div class="panel panel-default">
              <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限分配列表<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
                  <button class="btn btn-success">分配许可</button>
                  <br><br>
                  <ul id="treeDemo" class="ztree"></ul>
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
				<h4>没有默认类</h4>
				<p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>没有默认类</h4>
				<p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
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
	<script src="${APP_PATH }/jquery/zTree_v3/js/jquery.ztree.all-3.5.min.js"></script>
       
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
	    
	    
	    getZNode();
        
       });
       
       //1.z-tree的设置属性
	
       function getZNode(){
    	   var setting = {
                   check : {
                       enable : true 
                   },
				};
       	var zNodes;
       	var loadingIndex ;
       	$.ajax({
       		"type" :"post",
       		"url"  :"${APP_PATH}/role/dorolepermissiontree.do",
			"data" :{"roleId":${requestScope.roleId}},
			"beforeSend" :function(){
				loadingIndex = layer.msg('处理中', {icon: 16});
			},
			"success" :function(result){
				layer.close(loadingIndex);
				zNodes = result.treeObj;
alert(JSON.stringify(zNodes));

				$.fn.zTree.init($("#treeDemo"),setting,zNodes); 
			},
			"error" :function(){
				layer.msg("错误");
				layer.close(loadingIndex);
			}
       	});
       	
       }
       
       </script>
</body>
</html>
    