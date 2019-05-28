package com.hehuiming.zc.potal.dao;

import com.hehuiming.zc.bean.Member;

import java.util.HashMap;
import java.util.List;

public interface MemberMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Member record);

    Member selectByPrimaryKey(Integer id);

    List<Member> selectAll();

    int updateByPrimaryKey(Member record);

	Member selectByloginacctAndUserpswd(HashMap map);
}