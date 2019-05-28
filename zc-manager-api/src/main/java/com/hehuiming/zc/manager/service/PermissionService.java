package com.hehuiming.zc.manager.service;

import java.util.List;

import com.hehuiming.zc.bean.Permission;

public interface PermissionService {

	/*
	 * 查询树的信息到一个对象 用于json前端展示
	 */
	List<Permission> queryPermissionImfoTree();

}
