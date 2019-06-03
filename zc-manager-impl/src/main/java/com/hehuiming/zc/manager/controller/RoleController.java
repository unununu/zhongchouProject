package com.hehuiming.zc.manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hehuiming.zc.bean.Permission;
import com.hehuiming.zc.bean.Role;
import com.hehuiming.zc.manager.service.PermissionService;
import com.hehuiming.zc.manager.service.RolePermissionService;
import com.hehuiming.zc.manager.service.RoleService;
import com.hehuiming.zc.util.bean.Page;
import com.hehuiming.zc.util.controller.BaseController;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController{
	
	@Autowired
	RoleService roleService;
	@Autowired
	PermissionService permissionService;
	@Autowired
	RolePermissionService rolePermissionService;
	
	@RequestMapping("/index")
	public String index() {
		return "role/index";
	}
	@RequestMapping("/assign.do")
	public String assign(@RequestParam(required = true) Integer id,Model m) {
		m.addAttribute("roleId", id);
		return "role/assignpermission";
	}
	
	
	@ResponseBody
	@RequestMapping("/listroles")
	public Object listroles(Integer pageNo,Integer pageSize) {
		this.start();
		Page<Role> page = new Page<Role>(1,10);
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("page", page);
		Page<Role> finalPage = roleService.queryRolesByPage(params);
		this.saveParam("page", finalPage);
		return this.end();
	}

	
	
	@ResponseBody
	@RequestMapping("/dorolepermissiontree.do")
	public Object dopermissiontree(Integer roleId) {
		this.start();
//		List<Permission> treeImfo = permissionService.queryPermissionImfoTree();//或许许可树信息
//		this.saveParam("treeObj", treeImfo); 
//		//获取许可树与角色关系信息
//		List<Integer> permissionIds =  rolePermissionService.queryPermissonIdsByRoleid(roleId);
//		for(Integer permissionId :permissionIds) {
//			
//		}
		List<Permission> treeImfo = rolePermissionService.queryPermissiontreeCheckedbyRoleId(roleId);
		this.saveParam("treeObj", treeImfo); 
		return this.end();
	}
	
}
