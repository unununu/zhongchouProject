package com.hehuiming.zc.manager.dao;

import com.hehuiming.zc.bean.UserRole;
import com.hehuiming.zc.vo.Data;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface UserRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserRole record);

    UserRole selectByPrimaryKey(Integer id);

    List<UserRole> selectAll();

    int updateByPrimaryKey(UserRole record);

    /*
     * 按userid查找
     */
	List<UserRole> selectByUserId(Integer id);

	/*
	 * 按data中的ids为roleid添加数据
	 */
	void insertUserRoles(@Param("userId")Integer userId,@Param("data") Data data);

	/*
	 * data中的ids list对象为roleId
	 */
	void delectUserRoles(@Param("userId")Integer userId, @Param("data")Data data);
}