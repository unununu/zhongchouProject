package com.hehuiming.aboutMbg;

import java.util.ArrayList;
import java.util.List;

public class UpCase {

	/*
	 * 将数据库表名格式变类名格式
	 */
	public static void main(String[] args) {
		//再自动化一点可直接从数据库取表名
		//select table_name from information_schema.tables where table_schema='当前数据库'
		List<String> list = new ArrayList<String>();
		list.add("t_account_type_cert");
		list.add("t_advertisement");
		list.add("t_cert");
		list.add("t_dictionary");
		list.add("t_member");
		list.add("t_member_address");
		list.add("t_member_cert");
		list.add("t_member_project_follow");
		list.add("t_message");
		list.add("t_order");
		list.add("t_param");
		list.add("t_permission");
		list.add("t_project");
		list.add("t_project_tag");
		list.add("t_project_type");
		list.add("t_return");
		list.add("t_role");
		list.add("t_role_permission");
		list.add("t_student");
		list.add("t_tag");
		list.add("t_type");
		list.add("t_user");
		list.add("t_user_role");
		
		for(int i  = 0; i < list.size(); i++) {
			//System.out.print("before :"  + list.get(i) + "  //");
			String target = list.get(i).substring(2);
			target = target.replaceFirst("[a-z]", target.substring(0, 1).toUpperCase());
			int indexOf = target.indexOf("_");
			target = target.replaceFirst("_[a-z]", target.substring(indexOf+1,indexOf+2).toUpperCase());
			//有些有两个 _
			int indexOf2 = target.indexOf("_");
			target = target.replaceFirst("_[a-z]", target.substring(indexOf2+1,indexOf2+2).toUpperCase());
			//System.out.println("after :"+target );
			System.out.println(target );
			
		}
		

	}

}
