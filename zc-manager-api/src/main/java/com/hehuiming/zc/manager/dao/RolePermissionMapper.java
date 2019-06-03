package com.hehuiming.zc.manager.dao;

import com.hehuiming.zc.bean.RolePermission;
import java.util.List;

public interface RolePermissionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RolePermission record);

    RolePermission selectByPrimaryKey(Integer id);

    List<RolePermission> selectAll();

    int updateByPrimaryKey(RolePermission record);

    /*
     * 根据roleidc查询permissionIds
     */
	List<Integer> selectPermissionsIdByRoleId(Integer roleId);
}