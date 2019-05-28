package com.hehuiming.zc.util;

import java.awt.Color;
import java.util.Random;

public class CodeUtil {
	

	/*该方法主要作用是获得随机生成的颜色*/ 
	public static Color getRandColor(int s,int e){
		Random random=new Random ();
		if(s>255) s=255;
		if(e>255) e=255;
		int r,g,b;
		r=s+random.nextInt(e-s);	//随机生成RGB颜色中的r值
		g=s+random.nextInt(e-s);	//随机生成RGB颜色中的g值
		b=s+random.nextInt(e-s);	//随机生成RGB颜色中的b值
		return new Color(r,g,b);
	}

}
