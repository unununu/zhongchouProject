package com.hehuiming.zc.manager.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hehuiming.zc.bean.Permission;
import com.hehuiming.zc.manager.dao.PermissionMapper;
import com.hehuiming.zc.manager.dao.RolePermissionMapper;
import com.hehuiming.zc.manager.service.RolePermissionService;

@Service
public class RolePermissionServiceImpl implements RolePermissionService {

	@Autowired
	RolePermissionMapper rolePermissionMapper;
	
	@Autowired
	PermissionMapper permissionMapper;

	@Override
	public List<Integer> queryPermissonIdsByRoleid(Integer roleId) {
		List<Integer> permissionsid= rolePermissionMapper.selectPermissionsIdByRoleId(roleId);
		return permissionsid;
	}

	@Override
	public List<Permission> queryPermissiontreeCheckedbyRoleId(Integer roleId) {
		    List<Integer> permissionsid= rolePermissionMapper.selectPermissionsIdByRoleId(roleId);
			//为了减少去服务器查询的次数，这里查询所有数据出来后，内存中计算
			List<Permission> all = permissionMapper.selectAll(); //注意：mybatis没有查到数据则size为0，空集合非null
			Map<Integer,Permission> pers = new HashMap<>(); //map: id 与 permission对象
			for(Permission per : all) {
				pers.put(per.getId(), per);
				if(permissionsid.contains(per.getId())) {//设置是否选中（checked = true）
					per.setChecked(true);
				}
			}
		
			for(Permission per: all) {
				if(per.getPid() != null) {
					pers.get(per.getPid()).getChildren().add(per);  //建立与父亲的关系
				}
			}
			List<Permission> zTree = new ArrayList<Permission>();
			for(Permission per: all) {
				if(per.getPid() == null) { //拿到根
					zTree.add(per);
				}
				
			}
			
			return zTree;
		}
		
		
		//限本类使用：
		private List<Permission> queryPermissionChildren(List<Permission> all,Integer permissionId) {
			List<Permission> children = new ArrayList<Permission>();
			for(Permission per :all) {
				if(per.getPid() == permissionId) {
					children.add(per);
				}
				
			}
			return children;
			
		}
	}
