package com.hehuiming.zc.manager.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hehuiming.zc.bean.Role;
import com.hehuiming.zc.bean.User;
import com.hehuiming.zc.manager.service.RoleService;
import com.hehuiming.zc.manager.service.UserService;
import com.hehuiming.zc.util.JsonMessage;
import com.hehuiming.zc.util.StringUtil;
import com.hehuiming.zc.util.bean.Page;
import com.hehuiming.zc.vo.Data;

/*
 * 用户模块controller
 */
@Controller
@RequestMapping("/user")  //user模块
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	RoleService roleService;
	
	
	
	/*
	 * 查找用户列表：异步请求：直接返回页面，不查数据库，减少等待时间，由返回页面在此ajax请求查数据
	 */
	@RequestMapping("/list")  
	public String forwardToUserPage() {
		return "user/index";
	}
	
	@RequestMapping("/add")  
	public String forwardToAddUserPage() {
		return "user/add";
	}
	
	
	/*
	 * 异步查询,查看user列表数据
	 */
	@ResponseBody
	@RequestMapping(value = {"/queryUserlist.do"},method = {RequestMethod.POST})  
	public Object queryUserlist(@RequestParam(value ="pageNo",defaultValue = "1",required = true) Integer pageNo,
														@RequestParam(value ="pageSize",defaultValue = "10",required = true)Integer pageSize,String seachText) {
		Map params = new HashMap<String,Object>(); //map传参数：参数个数可变：接口会少改动
		
		if(!StringUtil.isEmpty(seachText)) {  //模糊查询文本是否空
			params.put("seachText", seachText);
		}
		params.put("pageNo", pageNo);
		params.put("pageSize", pageSize);
		JsonMessage message = new JsonMessage();
		Page<User> userPage;
		try {//service如果发生异常，抛出异常后回滚事务，设置发送的json数据
			userPage = userService.queryList(params);
			message.setSuccess(true);
			message.setPage(userPage);
		} catch (Exception e) {
			message.setSuccess(false);
			message.setMessage("遇到错误");
			e.printStackTrace();
		}
		
		return message;
	}

	
	/*
	 * 新增用户
	 */
	@ResponseBody
	@RequestMapping(value = {"/saveUser.do" } ,method = {RequestMethod.POST})  
	public Object saveUser(User user) {
		Map params = new HashMap<String,Object>(); //map传参数：参数个数可变：接口会少改动
		
		JsonMessage message = new JsonMessage();
		boolean isSave;
		try {//service如果发生异常，抛出异常后回滚事务，设置发送的json数据
			isSave = userService.saveUser( user);
			if(isSave) {
				message.setSuccess(true);
			}else {
				message.setSuccess(false);
			}
			
		} catch (Exception e) {
			message.setSuccess(false);
			message.setMessage("遇到错误");
			e.printStackTrace();
		}
		
		return message;
	}
	
	/*
	 * 修改用户页面：用户数据回显
	 */
	@RequestMapping("/update")  
	public String forwardToUpdateUserPage(@RequestParam(required = true)Integer id,Model m) {
		//查询用户数据用于回显数据
		User user = userService.queryUser(id);
		
		m.addAttribute("selectedUserdata", user);
		
		return "user/update";
	}
	
	/*
	 * 修改用户数据
	 */
	@ResponseBody
	@RequestMapping("/updateUser")  
	public Object updateUser(User user) {
		JsonMessage jsonMessage = new JsonMessage();
		try {
		    userService.updateUserbyId(user);
			jsonMessage.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMessage.setSuccess(false);
			jsonMessage.setMessage(e.getMessage());
		}
		
		return jsonMessage;
	}
	
	
	/*
	 * 删除用户
	 */
	@ResponseBody
	@RequestMapping("/delectUser")  
	public Object delectUser(Integer id) {
		JsonMessage jsonMessage = new JsonMessage();
		try {
		    userService.delectUser(id);
			jsonMessage.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMessage.setSuccess(false);
			jsonMessage.setMessage(e.getMessage());
		}
		
		return jsonMessage;
	}
	
	
	/*
	 * 分配角色页面,id:该角色的id,用于查询回显数据
	 * assginRole
	 */
	@RequestMapping("/assignRole")  
	public String forwardToAssginRolePage(@RequestParam(required = true)Integer id,Model m) {
		//查询用户数据用于回显数据
		List<Integer> assginedRolesId= userService.queryUserRoleId(id);
		List<Role> allRoles= roleService.queryAllRoles();
		
		List<Role> assginedRoles = new ArrayList<Role> ();
		List<Role> unassginedRoles = new ArrayList<Role> ();
			for(Role role : allRoles) {
				if(assginedRolesId.contains(role.getId())) {
					assginedRoles.add(role);
				}else {
					unassginedRoles.add(role);
				}
		}
		m.addAttribute("assginedRoles", assginedRoles);
		m.addAttribute("unassginedRoles", unassginedRoles);
		return "user/assignrole";
	}
	
	/*
	 * 注意：这里的同一参数多值的封装data
	 */
	@ResponseBody
	@RequestMapping("/doSaveOrRemoveUserRole")  
	public Object doSaveOrRemoveUserRole(Integer userId ,String type , Data data) {
		
		JsonMessage jsonMessage = new JsonMessage();
		switch(type) {
		case "save" :
			try {
				userService.saveUserRoles(userId,data);
				jsonMessage.setSuccess(true);
			} catch (Exception e) {
				e.printStackTrace();
				jsonMessage.setSuccess(false);
			}
			break;
		case "remove":
			try {
				userService.removeUserRoles(userId,data);
				jsonMessage.setSuccess(true);
			} catch (Exception e) {
				e.printStackTrace();
				jsonMessage.setSuccess(false);
			}
			break;
		}
		
		return jsonMessage;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * 同步:查询用户列表：(直接查完数据，将数据放入request传给view对应jsp绘制页面)查看用户列表,一步到位
	 
	@RequestMapping("/list")  //map放参数,当前端两参数没有传时(null),设置默认值,避免空指针
	public String doList(Map map,@RequestParam(value ="pageNo",defaultValue = "1",required = true) Integer pageNo,@RequestParam(value ="pageSize",defaultValue = "10",required = true)Integer pageSize) {
		Page<User> userPage= userService.queryList(pageNo,pageSize);
		map.put("userPage", userPage);
		return "user/user";
	}*/
}
