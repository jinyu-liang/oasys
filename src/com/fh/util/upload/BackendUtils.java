package com.fh.util.upload;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
* @author liangjy@asiainfo.com
* 创建时间：2018年9月21日
* 类说明
*/

public class BackendUtils {
	/**
	 * @MethodName	: GetConfigProperty
	 * @Description	:  去读配置文件中的property属性
	 * @param fileName 配置文件名称
	 * @param propName 获取的属性
	 * @return propMap
	 */
	public static Map<String, String> GetConfigProperty(String fileName,String...  propName){
		Properties prop = new Properties();  
		Map<String, String> propMap = new HashMap<String, String>();
        try {  
            prop.load(BackendUtils.class.getClassLoader().getResourceAsStream(fileName));  
            for (String propery : propName) {
            	propMap.put(propery, prop.getProperty(propery));
			}
        } catch(IOException e) {  
            e.printStackTrace();  
        }
		return propMap;  
	}
}
