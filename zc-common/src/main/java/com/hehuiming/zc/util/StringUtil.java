package com.hehuiming.zc.util;

public class StringUtil {

	
	
	public static boolean isEmpty(String inStr) {
		boolean flag = (inStr == null) || ("".equals(inStr)); //防止空指针异常
		return flag;
	}

}
