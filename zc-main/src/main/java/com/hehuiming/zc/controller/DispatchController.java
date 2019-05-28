package com.hehuiming.zc.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hehuiming.zc.bean.Member;
import com.hehuiming.zc.bean.User;
import com.hehuiming.zc.exception.WrongUserException;
import com.hehuiming.zc.manager.service.UserService;
import com.hehuiming.zc.potal.service.MemberService;
import com.hehuiming.zc.util.CodeUtil;
import com.hehuiming.zc.util.Const;
import com.hehuiming.zc.util.JsonMessage;
import java.awt.*;
import java.awt.geom.*;
import java.awt.image.*;
import java.io.*;
import java.util.*;
 

import javax.imageio.ImageIO;
@Controller
public class DispatchController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MemberService memberService;
	
	
	@RequestMapping("/index")//可省略后缀
	public String forwordIndexPage() {
		return "index";
		
	}
	
	@RequestMapping("/login")
	public ModelAndView forwordloginPage(String exMessage,HttpServletRequest request) {
		//如果有异常信息，放入request域
	
		return new ModelAndView("login").addObject("exMessage",exMessage);
	}

	@RequestMapping("/main")//可省略后缀
	public String forwordMainPage() {
		return "main";
		
	}
	
	/*
	 * 退出登陆
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate(); //注销session 
		
		return "redirect:/index.htm";
		
	}


	
	
	
	/*
	 * 异步请求返回json
	 */
	@ResponseBody //表返回的内容object放在body体里
	@RequestMapping("/doLogin")
	public Object login(String loginacct,String userpswd,String type,HttpSession session) {
		
		JsonMessage jsonMessage = new JsonMessage();
		User user = null;
		Member member = null;
		
		HashMap map = new HashMap<String,Object>();
		map.put("loginacct", loginacct);
		map.put("userpswd", userpswd);
		/*
		 * 会员与管理用户对应不同的service
		 */
		try {
			if(type.equals("member")) {
				member = memberService.queryLogin(map);
				session.setAttribute(Const.Login_User, member); //用户信息放入session
				
			}else {
				 user = userService.queryLogin(map);
				 session.setAttribute(Const.Login_User, user);
			}
		} catch (Exception e) {
			e.printStackTrace();
			/*
			 * 异常：不合法:设置json数据false
			 */
			jsonMessage.setSuccess(false);
			jsonMessage.setMessage("请检查用户名密码，正确选择‘会员’或‘管理’");
			e.printStackTrace();
			return jsonMessage;
		}
		/*
		 * 返回json数据:合法true
		 */
		jsonMessage.setSuccess(true);
		return jsonMessage;
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * 验证码功能尝试
	 */
	
	@RequestMapping("/getcode")
	public void code(HttpSession session,HttpServletResponse response,HttpServletRequest request) {
				//设置不缓存图片
				response.setHeader("Pragma", "No-cache");
				response.setHeader("Cache-Control", "No-cache");
				response.setDateHeader("Expires", 0);
				//指定生成的响应图片,一定不能缺少这句话,否则错误.
				response.setContentType("image/jpeg");
				int width=86,height=22;		//指定生成验证码的宽度和高度
				BufferedImage image=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);	//创建BufferedImage对象,其作用相当于一图片
				Graphics g=image.getGraphics();		//创建Graphics对象,其作用相当于画笔
				Graphics2D g2d=(Graphics2D)g;		//创建Grapchics2D对象
				Random random=new Random();
				Font mfont=new Font("楷体",Font.BOLD,16);	//定义字体样式
				g.setColor(CodeUtil.getRandColor(200,250));
				g.fillRect(0, 0, width, height);	//绘制背景
				g.setFont(mfont);					//设置字体
				g.setColor(CodeUtil.getRandColor(180,200));
				
				//绘制100条颜色和位置全部为随机产生的线条,该线条为2f
				for(int i=0;i<100;i++){
					int x=random.nextInt(width-1);
					int y=random.nextInt(height-1);
					int x1=random.nextInt(6)+1;
					int y1=random.nextInt(12)+1;
					BasicStroke bs=new BasicStroke(2f,BasicStroke.CAP_BUTT,BasicStroke.JOIN_BEVEL);	//定制线条样式
					Line2D line=new Line2D.Double(x,y,x+x1,y+y1);
					g2d.setStroke(bs);
					g2d.draw(line);		//绘制直线
				}
				//输出由英文，数字，和中文随机组成的验证文字，具体的组合方式根据生成随机数确定。
				String sRand="";
				String ctmp="";
				int itmp=0;
				//制定输出的验证码为四位
				for(int i=0;i<4;i++){
					switch(random.nextInt(3)){
						case 1:		//生成A-Z的字母
						     itmp=random.nextInt(26)+65;
						     ctmp=String.valueOf((char)itmp);
						     break;
						case 2:		//生成汉字
							 String[] rBase={"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"}; 
							 //生成第一位区码
							 int r1=random.nextInt(3)+11;
							 String str_r1=rBase[r1];
							 //生成第二位区码
							 int r2;
							 if(r1==13){
								 r2=random.nextInt(7);	 
							 }else{
								 r2=random.nextInt(16);
							 }
							 String str_r2=rBase[r2];
							 //生成第一位位码
							 int r3=random.nextInt(6)+10;
							 String str_r3=rBase[r3];
							 //生成第二位位码
							 int r4;
							 if(r3==10){
								 r4=random.nextInt(15)+1;
							 }else if(r3==15){
								 r4=random.nextInt(15);
							 }else{
								 r4=random.nextInt(16);
							 }
							 String str_r4=rBase[r4];
							 //将生成的机内码转换为汉字
							 byte[] bytes=new byte[2];
							 //将生成的区码保存到字节数组的第一个元素中
							 String str_12=str_r1+str_r2;
							 int tempLow=Integer.parseInt(str_12, 16);
							 bytes[0]=(byte) tempLow;
							 //将生成的位码保存到字节数组的第二个元素中
							 String str_34=str_r3+str_r4;
							 int tempHigh=Integer.parseInt(str_34, 16);
							 bytes[1]=(byte)tempHigh;
							 ctmp=new String(bytes);
							 break;
						default:
							 itmp=random.nextInt(10)+48;
							 ctmp=String.valueOf((char)itmp);
							 break;
					}
					sRand+=ctmp;
					Color color=new Color(20+random.nextInt(110),20+random.nextInt(110),random.nextInt(110));
					g.setColor(color);
					//将生成的随机数进行随机缩放并旋转制定角度 PS.建议不要对文字进行缩放与旋转,因为这样图片可能不正常显示
					/*将文字旋转制定角度*/
					Graphics2D g2d_word=(Graphics2D)g;
					AffineTransform trans=new AffineTransform();
					trans.rotate((45)*3.14/180,15*i+8,7);
					/*缩放文字*/
					float scaleSize=random.nextFloat()+0.8f;
					if(scaleSize>1f) scaleSize=1f;
					trans.scale(scaleSize, scaleSize);
					g2d_word.setTransform(trans);
					g.drawString(ctmp, 15*i+18, 14);
				}
				
				session.setAttribute("randCheckCode", sRand);
				g.dispose();	//释放g所占用的系统资源
				try {
					ImageIO.write(image,"JPEG",response.getOutputStream());
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	//输出图片
			
		
		
		
		
	}
	
	
	
	/*
	 * 同步的登陆，返回页面（重定向或跳转）
	 */
//	@RequestMapping("/doLogin")
//	public String login(String loginacct,String userpswd,String type,HttpSession session) {
//		HashMap map = new HashMap<String,Object>();
//		map.put("loginacct", loginacct);
//		map.put("userpswd", userpswd);
//		map.put("type", type);
//		/*
//		 * 检查用户，查询不到则抛出异常runntime exception，由异常处理器处理，不会往下执行
//		 */
//		userService.queryLogin(map);
//		/*
//		 * 放入session域中
//		 */
//		session.setAttribute(Const.Login_User, loginacct);
//		
//		/*
//		 * 重定向：刷新页面会刷新新页面不会重复流程
//		 */
//		return "redirect:/main.htm";

		
//	}
}
