package com.hehuiming.zc.util;

import com.hehuiming.zc.util.bean.Page;

/*
 * 用于前后端传输数据：json
 * 将被框架格式化为json格式字符串传输
 */
public class JsonMessage {
	
	//1.后端是否成功
	boolean  success;
	
	//2.传输信息
	String message;
	
	//3.有些部分用到分页，传输多个对象封装到一个page中
	Page page;
	
	//4.传任意信息
	Object obj;

	
	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public boolean getSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
	
	
	

	
}
