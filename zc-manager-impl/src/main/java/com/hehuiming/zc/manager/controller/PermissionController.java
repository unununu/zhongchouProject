package com.hehuiming.zc.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hehuiming.zc.bean.Permission;
import com.hehuiming.zc.manager.service.PermissionService;
import com.hehuiming.zc.util.JsonMessage;

@Controller
@RequestMapping("/permission")
public class PermissionController {
	
	@Autowired
	PermissionService permissionService;
	
	@RequestMapping("/index")
	public String index() {
		return "permission/index";
	}

	
	/*
	 * ajax查询树 json
	 */
	@ResponseBody
	@RequestMapping("/dopermissiontree")
	public Object dopermissiontree() {
		List<Permission> treeImfo = permissionService.queryPermissionImfoTree();
		JsonMessage jm= new JsonMessage();
		jm.setObj(treeImfo);
		return jm;
	}
	
}
