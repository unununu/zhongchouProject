package com.hehuiming.zc.potal.service.impl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hehuiming.zc.bean.Member;
import com.hehuiming.zc.bean.User;
import com.hehuiming.zc.exception.WrongUserException;
import com.hehuiming.zc.potal.dao.MemberMapper;
import com.hehuiming.zc.potal.service.MemberService;
import com.hehuiming.zc.util.MD5Util;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Override
	public Member queryLogin(HashMap map) {
		/*
		 * 将用户输入的密码加密
		 */
		String userpswd = MD5Util.digest((String)map.get("userpswd"));
		map.put("userpswd", userpswd);
		
		/*
		 * 查询用户
		 */
		Member member = memberMapper.selectByloginacctAndUserpswd(map);
		if(member == null) {
			/*
			 * 登陆失败,抛出一个runntime exception
			 */
			throw new WrongUserException("用户名或密码错误");
		}
		
		return member;
	}

}
