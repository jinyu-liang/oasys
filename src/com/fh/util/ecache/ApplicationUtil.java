package com.fh.util.ecache;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.ClassPathXmlApplicationContext;
/**
* @author liangjy@asiainfo.com
* 创建时间：2019年12月18日
* 类说明
*/
public class ApplicationUtil implements ApplicationContextAware{
 
    private static ApplicationContext applicationContext;
 
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        ApplicationUtil.applicationContext = applicationContext;
    }
 
    public static Object getBean(String name){
    	if(null == applicationContext) {
    		applicationContext = new ClassPathXmlApplicationContext("spring/ApplicationContext.xml");
    	}
        return applicationContext.getBean(name);
    }
 
}