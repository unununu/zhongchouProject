package com.hehuiming.zc.manager.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hehuiming.zc.bean.Role;
import com.hehuiming.zc.manager.dao.RoleMapper;
import com.hehuiming.zc.manager.service.RoleService;
import com.hehuiming.zc.util.bean.Page;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	RoleMapper roleMapper;
	
	@Override
	public List<Role> queryAllRoles() {
		List<Role> roles = roleMapper.selectAll();
		return roles;
	}

	@Override
	public Page<Role> queryRolesByPage(Map<String,Object> params) {
		Page page = (Page) params.get("page");
		Integer pageNo = page.getPageNo();
		Integer pageSize = page.getPageSize();
		List<Role> roleList = roleMapper.selectLimit((pageNo-1)*pageSize,pageSize);
		page.setDataList(roleList);
		page.setTotalCount(roleMapper.selectCount());
		return page;
	}

}
