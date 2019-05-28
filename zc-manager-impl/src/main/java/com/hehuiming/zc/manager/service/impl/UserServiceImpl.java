package com.hehuiming.zc.manager.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hehuiming.zc.bean.User;
import com.hehuiming.zc.bean.UserRole;
import com.hehuiming.zc.exception.WrongUserException;
import com.hehuiming.zc.manager.dao.UserMapper;
import com.hehuiming.zc.manager.dao.UserRoleMapper;
import com.hehuiming.zc.manager.service.UserService;
import com.hehuiming.zc.util.Const;
import com.hehuiming.zc.util.MD5Util;
import com.hehuiming.zc.util.bean.Page;
import com.hehuiming.zc.vo.Data;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	UserRoleMapper userRoleMapper;

	@Override
	public User queryLogin(HashMap map) throws WrongUserException{

		/*
		 * 将用户输入的密码加密
		 */
		String userpswd = MD5Util.digest((String)map.get("userpswd"));
		map.put("userpswd", userpswd);
		
		/*
		 * 查询用户
		 */
		User user = userMapper.selectByloginacctAndUserpswd(map);
		if(user == null) {
			/*
			 * 登陆失败,抛出一个runntime exception
			 */
			throw new WrongUserException("用户名或密码错误");
		}
		return user;
		
		
	}
	
	
	
	
/*
 * 笔记：service里面掉了多个userMapper方法，要让几个操作成为一个原子-->事务
 * 如果有异常就抛出异常，让事务回滚（默认运行异常回滚，但可设置）,然后连接归还连接池
 * 这里都是查询还好，有修改数据的要注意
 * 
 */
	@Override
	public Page queryList(Map params) {
		Integer pageNo  = (Integer)params.get("pageNo");
		Integer pageSize  = (Integer)params.get("pageSize");
		String searchText = (String)params.get("seachText");
		
		Page<User> page = new Page<User>(pageNo,pageSize);
		List<User> userList = userMapper.selectByLimit((pageNo-1)*pageSize , pageSize,searchText); //查用户列表
		int count = userMapper.selectCount(searchText);//查总记录数
		page.setTotalCount(count);
		page.setDataList(userList);
		return page;
	}



	@Override
	public boolean saveUser(User user) {
		user.setUserpswd(MD5Util.digest(Const.DEFAULT_USER_PASSWORD));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		user.setCreatetime(sdf.format(new Date()));
		
		int flag = userMapper.insert(user);
		
		if(flag == 1) {
			return true;
		}
		return false;
	}



	@Override
	public User queryUser(Integer id) {
		User user = userMapper.selectByPrimaryKey(id);
		
		return user;
	}


	@Override
	public Boolean updateUserbyId(User user) {
		int flag = userMapper.updateByPrimaryKey(user);
		if(flag == 1) {
			return true;
		}else {
			throw new RuntimeException("更新失败了");
		}
	}

	
	
	@Override
	public void delectUser(Integer id) {
		
		int flag = userMapper.deleteByPrimaryKey(id);
		if(flag == 1) {
			
			return ;
		}else {
			throw new RuntimeException("删除失败了");
		}
		
	}

	
	@Override
	public List<Integer> queryUserRoleId(Integer id) {
		List<UserRole> userRoles = userRoleMapper.selectByUserId(id);
		List<Integer> list = new ArrayList<Integer>();
		for(UserRole ur:userRoles) {
			list.add(ur.getRoleid());
		}
		return list;
	}

	
	

	@Override
	public void saveUserRoles(Integer userId, Data data) {
		userRoleMapper.insertUserRoles(userId,data);
		
	}




	@Override
	public void removeUserRoles(Integer userId, Data data) {
		userRoleMapper.delectUserRoles(userId,data);
	}




	
	
	
	
	
	
	
	
	
	
	
	/*
	 * test——————————————————————添加100条 user数据
	 */
	
	public void add100User() {
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(int i = 0;i<100;i++) {
			User u = new User();
			u.setLoginacct("test"+i);
			u.setUsername("name"+i);
			u.setEmail(756453428+i+"@qq.com");
			u.setUserpswd(MD5Util.digest("123"+i));
			u.setCreatetime(sdf.format(new Date()));
			userMapper.insert(u);
		}
		
	}




















	

}
