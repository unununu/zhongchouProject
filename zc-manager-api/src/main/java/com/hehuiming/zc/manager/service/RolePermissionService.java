package com.hehuiming.zc.manager.service;

import java.util.List;

import com.hehuiming.zc.bean.Permission;

public interface RolePermissionService {

	
	/*
	 * 根据角色id查询相关权限permissionId
	 */
	List<Integer> queryPermissonIdsByRoleid(Integer roleId);

	/*
	 * 根据roleid直接查出permission tree,并勾选相关许可(checked= true)
	 */
	List<Permission> queryPermissiontreeCheckedbyRoleId(Integer roleId);
	
}
