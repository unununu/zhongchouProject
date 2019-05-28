<%@ page language = "java" contentType = "text/html ; charset = utf-8"
pageEncoding = "UTF-8" %>
<!--编码问题：1.设置项目空间的文本编码 
				2.设置response编码：直接代码或者jsp中的contentType = "text/html ; charset = utf-8"
				 pageEncoding = "UTF-8"是浏览器的页面编码 
				 3.数据库编码-->  
<html>


<body>
<!-- 自定义监听器将根路径放入了servletcontext中，这里直接区，会从小范围到大范围搜索 -->

<%-- h><a href ="${APP_PATH }/test.do">点击测试</a></h> --%>

	<!-- 主页：请求转发到真正的主页：后台路径-->
 <jsp:forward page="/index.htm"></jsp:forward> 
</body>
</html>
