<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>


		<jsp:include page="/WEB-INF/jsp/main-side.jsp"></jsp:include>



        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 权限菜单列表 </h3>
			  </div>
			  
			  <div class="panel-body">
					
 					<hr style="clear:both;"> <!-- 应用了外部的css.js组件1.引入文件2.js要获取元素使用 css要给元素加上class样式 -->
			          <div class="table-responsive"><!-- 注意看demo，加在ul上的 -->
			          		<ul id = "permissiontree" class="ztree"></ul>
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
	<script src="${APP_PATH }/jquery/zTree_v3/js/jquery.ztree.all-3.5.js"></script>
	
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
        		//字体图标：未解决
        		/* "view" :	{
        			addDiyDom : function(treeId,treeNode){
							var ico_obj =  $("#" + treeNode.tId + "_ico"); 
							ico_obj.removeClass("button ico_open ico_docu").addClass(treeNode.ico).css("background","");
        			}
        		} */
        	}
        	var zNodes;
        	var loadingIndex ;
        	$.ajax({
        		"type" :"post",
        		"url"  :"${APP_PATH}/permission/dopermissiontree.do",
				"data" :"",
				"beforeSend" :function(){
					loadingIndex = layer.msg('处理中', {icon: 16});
				},
				"success" :function(result){
					layer.close(loadingIndex);
					zNodes = result.obj;
					$.fn.zTree.init($("#permissiontree"),setting,zNodes);
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
