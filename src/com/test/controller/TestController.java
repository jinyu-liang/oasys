package com.test.controller;


import java.util.Arrays;
import java.util.Collection;
 
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.jupiter.api.BeforeAll;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fh.entity.system.User;
import com.fh.service.system.user.UserManager;


/**
* @author liangjy@asiainfo.com
* 创建时间：2019年11月1日
* 类说明
*/
@RunWith(Parameterized.class) 
public class TestController {

	public static  UserManager userService = null;
	 

	
	@BeforeClass
	public static void setUp() {
		ApplicationContext FactoryManager = new ClassPathXmlApplicationContext("spring/ApplicationContext.xml");
		userService =  (UserManager) FactoryManager.getBean("userService");
	}
 
	// (2)步骤二：为测试类声明几个变量，分别用于存放期望值和测试所用数据。此处我只放了测试所有数据，没放期望值。
	public String idParam;
	public String usernameParam;
 
	// (3)步骤三：为测试类声明一个带有参数的公共构造函数，并在其中为第二个环节中声明的几个变量赋值。
	public TestController(String id, String username) {
		this.idParam = id;
		this.usernameParam = username;
	}
 
	// (4)步骤四：为测试类声明一个使用注解 org.junit.runners.Parameterized.Parameters 修饰的，返回值为
	// java.util.Collection 的公共静态方法，并在此方法中初始化所有需要测试的参数对。
	@Parameters
	public static Collection usernameData() {
 
		return Arrays.asList(new Object[][] { { "1", "jacky" }, { "2", "andy" },
				{ "3", "tomcat" }, });
 
	}
	
 
	// (5)步骤五：编写测试方法，使用定义的变量作为参数进行测试。
	@Test
	public void testFindByName() throws Exception {
		System.out.println("-------------"+idParam);
		User user2 = userService.getUserAndRoleById(idParam);
		System.out.println(user2);
	}
 
}
