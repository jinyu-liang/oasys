package com.fh.controller.system.login;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.entity.system.Role;
import com.fh.entity.system.User;
import com.fh.service.system.appuser.AppuserManager;
import com.fh.service.system.buttonrights.ButtonrightsManager;
import com.fh.service.system.fhbutton.FhbuttonManager;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.system.role.RoleManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.userloginlog.UserLoginLogManager;
import com.fh.service.system.util.impl.SequenceService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.RightsHelper;
import com.fh.util.Tools;

/**
 * 总入口
 * 
 * @author liangjy@asiainfo.com 修改日期：2015/11/2
 */
@Controller
public class LoginController extends BaseController {

	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "menuService")
	private MenuManager menuService;
	@Resource(name = "roleService")
	private RoleManager roleService;
	@Resource(name = "buttonrightsService")
	private ButtonrightsManager buttonrightsService;
	@Resource(name = "fhbuttonService")
	private FhbuttonManager fhbuttonService;
	@Resource(name = "appuserService")
	private AppuserManager appuserService;
	@Autowired
	private UserLoginLogManager user_login_logService;
	@Resource(name = "sequenceService")
	SequenceService sequenceService;

	/**
	 * 访问登录页
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login_toLogin")
	public ModelAndView toLogin() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.setViewName("system/index/login");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 请求登录，验证用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login_login",method = RequestMethod.POST)
	@ResponseBody
	public Object login(HttpServletRequest request) throws Exception {
		System.out.println(this.getRequest());
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();

		String localip=getIpAddr(request);
		String errInfo = "";
		String KEYDATA[] = pd.getString("KEYDATA").split("#");
		if (null != KEYDATA && KEYDATA.length == 3) {
			String USERNAME = KEYDATA[0]; // 登录过来的用户名
			String PASSWORD = KEYDATA[1]; // 登录过来的密码
			String code = KEYDATA[2];
			Session session = Jurisdiction.getSession();
			String sessionCode = session.getAttribute(Const.SESSION_SECURITY_CODE) + ""; // 获取session中的验证码
			pd.put("USERNAME", USERNAME);
			
			if ("999".equals(code) || (Tools.notEmpty(sessionCode) && sessionCode.equalsIgnoreCase(code))) { // 判断登录验证码 
				String passwd = new SimpleHash("SHA-1", USERNAME, PASSWORD).toString(); // 密码加密
				pd.put("PASSWORD", passwd);
				pd = userService.getUserByNameAndPwd(pd); // 根据用户名和密码去读取用户信息
				if (pd != null) {
					pd.put("LAST_LOGIN", DateUtil.getTime().toString());
					pd.put("IP", localip);
					userService.updateLastLogin(pd);
					User user = new User();
					user.setUSER_ID(pd.getString("USER_ID"));
					user.setUSERNAME(pd.getString("USERNAME"));
					user.setPASSWORD(pd.getString("PASSWORD"));
					user.setNAME(pd.getString("NAME"));
					user.setNUMBER(pd.getString("NUMBER"));
					user.setPHONE(pd.getString("PHONE"));
					user.setSEX(pd.getString("SEX"));
					user.setRIGHTS(pd.getString("RIGHTS"));
					user.setROLE_ID(pd.getString("ROLE_ID"));
					user.setLAST_LOGIN(pd.getString("LAST_LOGIN"));
					user.setLC_IP(pd.getString("LC_IP"));
					user.setSTATUS(pd.getString("STATUS"));
					user.setEMAIL(pd.getString("EMAIL"));
					user.setIP(localip);
					session.setAttribute(Const.SESSION_USER, user); // 把用户信息放session中
					session.removeAttribute(Const.SESSION_SECURITY_CODE); // 清除登录验证码的session
					// shiro加入身份验证


					Date date = new Date(); // 当前时间
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 登录时间
					String dateNowStr = sdf.format(date); // 登录时间
					SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd"); // 考勤日期
					String date2 = sdf2.format(date);// 考勤日期
					Page page = new Page();
					pd.put("USER_ID", pd.getString("USER_ID"));
					pd.put("DATE", date2);
					pd.put("ID", "loginId");
					page.setPd(pd);
					List<PageData> varList = user_login_logService.list(page); // 列出USER_LOGIN_LOG列表
					// 考勤录入
					if (null == varList || varList.size() < 1) {// 判断是否是今天第一次登录
						PageData pd_login = new PageData();
						pd_login.put("USER_LOGIN_LOG_ID", sequenceService.getLogID(pd)); //主键
						pd_login.put("USER_ID", pd.getString("USER_ID"));// 用户ID
						pd_login.put("USER_NAME", pd.getString("NAME")); // 用户名
						pd_login.put("LOG_IP", localip); // 登陆IP
						pd_login.put("IN_DATE", dateNowStr); // 登录时间
						String a = dateNowStr.substring(11, 13);// 获取登录时
						String b = dateNowStr.substring(14, 16);// 获取登录分
						PageData pduser=userService.findById(pd_login);
						String group=pduser.get("GROUP_ID").toString();
						int abstime=0;
						if(group.equals("106")) {
							int hour = Integer.parseInt(a) - 8;
							int min = Integer.parseInt(b) - 30;
							abstime = hour * 60 + min;
						}else {
							int hour = Integer.parseInt(a) - 9;
							int min = Integer.parseInt(b) - 0;
							abstime = hour * 60 + min;
						}
						if (abstime > 0) {
							pd_login.put("LOG_TYPE", "迟到"); // 考勤类型
							pd_login.put("ABS_TIMES", abstime); // 缺勤时长
						} else
							pd_login.put("LOG_TYPE", "签到"); // 考勤类型
						pd_login.put("UPDATE_ID", pd.getString("USER_ID")); // 更新ID
						pd_login.put("UPDATE_TIME", date2); // 考勤日期
						user_login_logService.save(pd_login);
					}
					Subject subject = SecurityUtils.getSubject();
					UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, PASSWORD);
					try {
						subject.login(token);
					} catch (AuthenticationException e) {
						errInfo = "身份验证失败！";
					}
				} else {
					errInfo = "usererror"; // 用户名或密码有误
					logBefore(logger, USERNAME + "登录系统密码或用户名错误");
				}
			} else {
				errInfo = "codeerror"; // 验证码输入有误
			}
			if (Tools.isEmpty(errInfo)) {
				errInfo = "success"; // 验证成功
				logBefore(logger, USERNAME + "登录系统");
			}
		
		} else {
			errInfo = "error"; // 缺少参数
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 访问系统首页
	 * 
	 * @param changeMenu：切换菜单参数
	 * @return
	 */
	@RequestMapping(value = "/main/{changeMenu}")
	@SuppressWarnings("unchecked")
	public ModelAndView login_index(@PathVariable("changeMenu") String changeMenu) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			Session session = Jurisdiction.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)

			if (user != null) {
				User userr = (User) session.getAttribute(Const.SESSION_USERROL); // 读取session中的用户信息(含角色信息)
				if (null == userr) {
					user = userService.getUserAndRoleById(user.getUSER_ID()); // 通过用户ID读取用户信息和角色信息
					session.setAttribute(Const.SESSION_USERROL, user); // 存入session
				} else {
					user = userr;
				}
				String USERNAME = user.getUSERNAME();
				Role role = user.getRole(); // 获取用户角色
				String roleRights = role != null ? role.getRIGHTS() : ""; // 角色权限(菜单权限)
				session.setAttribute(USERNAME + Const.SESSION_ROLE_RIGHTS, roleRights); // 将角色权限存入session
				session.setAttribute(Const.SESSION_USERNAME, USERNAME); // 放入用户名到session
				List<Menu> allmenuList = new ArrayList<Menu>();
				if (null == session.getAttribute(USERNAME + Const.SESSION_allmenuList)) {
					allmenuList = menuService.listAllMenuQx("0"); // 获取所有菜单
					if (Tools.notEmpty(roleRights)) {
						allmenuList = this.readMenu(allmenuList, roleRights); // 根据角色权限获取本权限的菜单列表
					}
					session.setAttribute(USERNAME + Const.SESSION_allmenuList, allmenuList);// 菜单权限放入session中
				} else {
					allmenuList = (List<Menu>) session.getAttribute(USERNAME + Const.SESSION_allmenuList);
				}
				// 切换菜单处理=====start
				List<Menu> menuList = new ArrayList<Menu>();
				if (null == session.getAttribute(USERNAME + Const.SESSION_menuList) || ("yes".equals(changeMenu))) {
					List<Menu> menuList1 = new ArrayList<Menu>();
					List<Menu> menuList2 = new ArrayList<Menu>();
					// 拆分菜单
					for (int i = 0; i < allmenuList.size(); i++) {
						Menu menu = allmenuList.get(i);
						if ("1".equals(menu.getMENU_TYPE())) {
							menuList1.add(menu);
						} else {
							menuList2.add(menu);
						}
					}
					session.removeAttribute(USERNAME + Const.SESSION_menuList);
					if ("2".equals(session.getAttribute("changeMenu"))) {
						session.setAttribute(USERNAME + Const.SESSION_menuList, menuList1);
						session.removeAttribute("changeMenu");
						session.setAttribute("changeMenu", "1");
						menuList = menuList1;
					} else {
						session.setAttribute(USERNAME + Const.SESSION_menuList, menuList2);
						session.removeAttribute("changeMenu");
						session.setAttribute("changeMenu", "2");
						menuList = menuList2;
					}
				} else {
					menuList = (List<Menu>) session.getAttribute(USERNAME + Const.SESSION_menuList);
				}
				// 切换菜单处理=====end
				if (null == session.getAttribute(USERNAME + Const.SESSION_QX)) {
					session.setAttribute(USERNAME + Const.SESSION_QX, this.getUQX(USERNAME)); // 按钮权限放到session中
				}
				mv.setViewName("system/index/main");
				mv.addObject("user", user);
				mv.addObject("menuList", menuList);
			} else {
				return new ModelAndView("redirect:/login_toLogin");
			}
		} catch (Exception e) {
			return new ModelAndView("redirect:/login_toLogin");
		}
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 根据角色权限获取本权限的菜单列表(递归处理)
	 * 
	 * @param menuList：传入的总菜单
	 * @param roleRights：加密的权限字符串
	 * @return
	 */
	public List<Menu> readMenu(List<Menu> menuList, String roleRights) {
		for (int i = 0; i < menuList.size(); i++) {
			menuList.get(i).setHasMenu(RightsHelper.testRights(roleRights, menuList.get(i).getMENU_ID()));
			if (menuList.get(i).isHasMenu()) { // 判断是否有此菜单权限
				this.readMenu(menuList.get(i).getSubMenu(), roleRights);// 是：继续排查其子菜单
			} else {
				menuList.remove(i);
				i--;
			}
		}
		return menuList;
	}

	/**
	 * 进入tab标签
	 * 
	 * @return
	 */
	@RequestMapping(value = "/tab")
	public String tab() {
		return "system/index/tab";
	}

	/**
	 * 进入首页后的默认页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login_default")
	public ModelAndView defaultPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();

		pd.put("userCount", Integer.parseInt(userService.getUserCount("").get("userCount").toString()) - 1); // 系统用户数
		pd.put("appUserCount", Integer.parseInt(appuserService.getAppUserCount("").get("appUserCount").toString())); // 会员数

		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)

		mv.addObject("pd", pd);
		mv.addObject("user", user);
		mv.setViewName("system/index/default");
		return mv;
	}

	/**
	 * 用户注销
	 * 
	 * @return
	 */
	@RequestMapping(value = "/logout")
	public ModelAndView logout() {
		String USERNAME = Jurisdiction.getUsername(); // 当前登录的用户名
		logBefore(logger, USERNAME + "退出系统");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		Session session = Jurisdiction.getSession(); // 以下清除session缓存
		session.removeAttribute(Const.SESSION_USER);
		session.removeAttribute(USERNAME + Const.SESSION_ROLE_RIGHTS);
		session.removeAttribute(USERNAME + Const.SESSION_allmenuList);
		session.removeAttribute(USERNAME + Const.SESSION_menuList);
		session.removeAttribute(USERNAME + Const.SESSION_QX);
		session.removeAttribute(Const.SESSION_userpds);
		session.removeAttribute(Const.SESSION_USERNAME);
		session.removeAttribute(Const.SESSION_USERROL);
		session.removeAttribute("changeMenu");
		// shiro销毁登录
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		pd = this.getPageData();
		pd.put("msg", pd.getString("msg"));
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.setViewName("system/index/login");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 获取用户权限
	 * 
	 * @return
	 */
	public Map<String, String> getUQX(String USERNAME) {
		PageData pd = new PageData();
		Map<String, String> map = new HashMap<String, String>();
		try {
			pd.put(Const.SESSION_USERNAME, USERNAME);
			pd.put("ROLE_ID", userService.findByUsername(pd).get("ROLE_ID").toString());// 获取角色ID
			pd = roleService.findObjectById(pd); // 获取角色信息
			map.put("adds", pd.getString("ADD_QX")); // 增
			map.put("dels", pd.getString("DEL_QX")); // 删
			map.put("edits", pd.getString("EDIT_QX")); // 改
			map.put("chas", pd.getString("CHA_QX")); // 查
			List<PageData> buttonQXnamelist = new ArrayList<PageData>();
			if ("admin".equals(USERNAME)) {
				buttonQXnamelist = fhbuttonService.listAll(pd); // admin用户拥有所有按钮权限
			} else {
				buttonQXnamelist = buttonrightsService.listAllBrAndQxname(pd); // 此角色拥有的按钮权限标识列表
			}
			for (int i = 0; i < buttonQXnamelist.size(); i++) {
				map.put(buttonQXnamelist.get(i).getString("QX_NAME"), "1"); // 按钮权限
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return map;
	}

	/**
	 * 更新登录用户的IP
	 * 
	 * @throws Exception
	 */
	
	public String getIpAddr(HttpServletRequest request) throws Exception {  
		String ip = request.getHeader("X-Real-IP");  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("X-Forwarded-For");  
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) ||"127.0.0.1".equals(ip)) {  
	        ip = request.getHeader("Proxy-Client-IP");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) ||"127.0.0.1".equals(ip)) {  
	        ip = request.getHeader("WL-Proxy-Client-IP");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) ||"127.0.0.1".equals(ip)) {  
	        ip = request.getHeader("HTTP_CLIENT_IP");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) ||"127.0.0.1".equals(ip)) {  
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip) ||"127.0.0.1".equals(ip)) {  
	        ip = request.getRemoteAddr();  
	    } 
	    return ip;  
	    
	} 
	
	@RequestMapping(value = "/login_toLogin_old")
	public ModelAndView toLoginOld() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.setViewName("system/index/login_old");
		mv.addObject("pd", pd);
		return mv;
	}


	public static void main(String[] args) {
		String passwd = new SimpleHash("SHA-1", "liangjy", "lc").toString();
		System.out.println(passwd);
	}
}
