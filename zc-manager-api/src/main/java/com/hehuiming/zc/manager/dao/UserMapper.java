package com.hehuiming.zc.manager.dao;

import com.hehuiming.zc.bean.User;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    User selectByPrimaryKey(Integer id);

    List<User> selectAll();

    int updateByPrimaryKey(User record);
    
    User selectByloginacctAndUserpswd(Map paramMap);

	List<User> selectByLimit(@Param("begin")Integer begin, @Param("Size")Integer Size, @Param("searchText")String searchText); //第一个数是从0开始的

	int selectCount(@Param("searchText")String searchText);
	
	
}