package com.hehuiming.zc.manager.dao;

import com.hehuiming.zc.bean.Role;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    Role selectByPrimaryKey(Integer id);

    List<Role> selectAll();

    int updateByPrimaryKey(Role record);

	List<Role> selectLimit(@Param("begin")int begin, @Param("size")Integer pageSize);
	
    int selectCount();
}