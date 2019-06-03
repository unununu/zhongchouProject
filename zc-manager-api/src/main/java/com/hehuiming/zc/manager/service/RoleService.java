package com.hehuiming.zc.manager.service;

import java.util.List;
import java.util.Map;

import com.hehuiming.zc.bean.Role;
import com.hehuiming.zc.util.bean.Page;

public interface RoleService {

	/*
	 * 查找所有的role
	 */
	List<Role> queryAllRoles();
	
	/*
	 * 按照页面要求查找roles,params里面可能含有page(要填充的数据),searchText(要查询的字符串)
	 */
	
	Page<Role> queryRolesByPage(Map<String,Object> params);

}
