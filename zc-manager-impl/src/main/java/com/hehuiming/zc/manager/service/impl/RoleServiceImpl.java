package com.hehuiming.zc.manager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hehuiming.zc.bean.Role;
import com.hehuiming.zc.manager.dao.RoleMapper;
import com.hehuiming.zc.manager.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	RoleMapper roleMapper;
	
	@Override
	public List<Role> queryAllRoles() {
		List<Role> roles = roleMapper.selectAll();
		return roles;
	}

}
