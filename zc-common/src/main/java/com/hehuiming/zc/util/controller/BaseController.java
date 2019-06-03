package com.hehuiming.zc.util.controller;
/*
 * 该类用于给普通controller继承，使得单例的每个controller有一个单例的threadlocal,
 * 每个request线程，在该threadlocal里可添加有一个对应的map变量，提供存放数据服务，
 * 执行controller方法完成后删除该线程对应的map变量
 * 由于不同线程操作的threadlocal里的map不同，不会发生冲突，不要担心并发问题
 */

import java.util.HashMap;
import java.util.Map;

public class BaseController {
	
	ThreadLocal<Map<String,Object>> tl= new ThreadLocal();
	
	//初始化：创建对应map
	public void start() {
		tl.set(new HashMap<String,Object>());
	}
	
	//结束：销毁线程对应map,返回该map
	public Map end() {
		Map<String, Object> map = tl.get();
		tl.remove();
		return map;
	}
	
	//将参数保存到本线程对应map
	public void saveParam(String key,Object value) {
		Map<String, Object> map = tl.get();
		map.put(key, value);
	}
	
		
	//将参数移出到本线程对应map
	public void removeParam(String key) {
		Map<String, Object> map = tl.get();
		map.put(key, null);
	}


}
