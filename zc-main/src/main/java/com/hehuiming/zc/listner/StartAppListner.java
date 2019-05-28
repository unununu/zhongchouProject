package com.hehuiming.zc.listner;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class StartAppListner implements ServletContextListener {

	/*
	 * 容器启动时执行监听器，将上下文路径放入servletContext域中,jsp页面可直接取
	 * 注意：监听器要注册在web.xml文件中，tomcat调用
	 */
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext servletContext = sce.getServletContext();
		String contextPath = servletContext.getContextPath();
		servletContext.setAttribute("APP_PATH", contextPath);

	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}

}
