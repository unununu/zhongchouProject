package com.hehuiming.zc.manager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hehuiming.zc.bean.Role;
import com.hehuiming.zc.bean.User;
import com.hehuiming.zc.util.bean.Page;
import com.hehuiming.zc.vo.Data;

public interface UserService {


	/*
	 * 登陆查询
	 */
	User queryLogin(HashMap map);

	/*
	 * 按页查询用户列表
	 */

	Page<User> queryList(Map params);

	/*
	 * 增加用户
	 */
	boolean saveUser(User user);

	/*
	 * 按id查询用户
	 */
	User queryUser(Integer id);

	/*
	 * 按id更新用户修改的数据(loginacct,username,email)
	 */
	Boolean updateUserbyId(User user);

	/*
	 * 按id删除user
	 */
	void delectUser(Integer id);

	/*
	 * 查找用户对应角色的id
	 */
	List<Integer> queryUserRoleId(Integer id);

	/*
	 * 给user添加角色
	 */
	void saveUserRoles(Integer userId, Data data);

	
	/*
	 *  给user移除角色
	 */
	void removeUserRoles(Integer userId, Data data);


	
	
	
	
	
	

}
