package com.fh.controller.system.secCode;

import java.io.FileInputStream;  
import java.io.FileNotFoundException;  
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.io.InputStream;  
import java.io.OutputStream;  
import java.util.Enumeration;  
import java.util.Properties;  
  
import org.apache.log4j.Logger; 

/**
* @author liangjy@asiainfo.com
* 创建时间：2018年3月8日
* 类说明
*/

public class PropertiesTool {

	// LOG  
    private static final Logger LOG = Logger.getLogger(PropertiesTool.class);  
    // Singleton instance  
    private static PropertiesTool instance = new PropertiesTool();  
      
    private static Properties properties;  
    /** 
     *  
     * Creates a new Singleton instance of PropertiesFileOperation.<br/> 
     */  
    private PropertiesTool() {  
          
    }  
    /** 
     * getInstance :get properties object  
     * @param propertiesFilePathName properties file path and name 
     * @return 
     */  
    public static PropertiesTool getInstance(String propertiesFilePathName){  
        properties = loadPropertiesFile(propertiesFilePathName);  
        return instance;  
    }  
    /** 
     *  
     * loadPropertiesFile:Load properties file by  path and name<br/> 
     * @param propertiesFilePathName path and name of properties file <br/> 
     * @return properties properties  
     */  
    private static Properties loadPropertiesFile(String propertiesFilePathName) {  
        Properties properties = new Properties();  
        InputStream isLoad = PropertiesTool.class.getClassLoader().getResourceAsStream(propertiesFilePathName);  
        try {  
            // loader properties  
            properties.load(isLoad);  
        } catch (IOException e) {  
            LOG.error(propertiesFilePathName + " properties file read failure", e);  
        } finally {  
            try {  
                isLoad.close();  
            } catch (IOException e) {  
                LOG.error("properties file stream close error",e);  
            }  
        }  
        return properties;  
    }  
    /** 
     * * 
     * getPropertiesValue:Get properties value by key <br/> 
     * @param key properties key  <br/> 
     * @return value properties value 
     */  
    public String getPropertiesValue(String key) {  
        return properties.getProperty(key);  
    }  
      
      
    public static String getInstanceByServerRealPathOfValue(String propertiesFileServerRealPathName,String key){  
        String pValue = null;  
        try {  
                InputStream isrLoad = new FileInputStream(propertiesFileServerRealPathName);  
                properties.load(isrLoad);  
                isrLoad.close();  
                pValue =  properties.getProperty(key);  
            } catch (IOException e) {  
                LOG.error("Failed to get the value under the server of the properties file",e);  
            }  
        return pValue;  
    }  
    /** 
     *  
     * getProperties:Get properties by key and value <br/> 
     * @param key properties key  <br/> 
     * @param value  properties value 
     */  
    public void setProperties(String filePath,String key,String value){  
        try {  
            InputStream is = new FileInputStream(filePath);  
            OutputStream os = new FileOutputStream(filePath);  
            properties.load(is);  
            properties.setProperty(key, value);  
            properties.store(os, null);  
            os.flush();  
            is.close();  
            os.close();  
        } catch (IOException e) {  
            LOG.error("properties file stream close error",e);  
        }  
    }  
      
    /** 
     *  
     * alterProperties:alter properties by key and value <br/> 
     * @param key properties key  <br/> 
     * @param value  properties value 
     */  
    public void alterProperties(String filePath,String key,String value){  
        try{  
            InputStream is = new FileInputStream(filePath);  
            OutputStream os = new FileOutputStream(filePath);  
            properties.load(is);  
            properties.remove(key);  
            properties.setProperty(key, value);  
            properties.store(os, null);  
            os.flush();  
            is.close();  
            os.close();  
        } catch (IOException e) {  
            LOG.error("properties file stream close error",e);  
        }  
    }  
    /** 
     *  
     * getAllProperties:Read the properties of all the information <br/> 
     * @return properties information 
     */  
    @SuppressWarnings("rawtypes")  
    public String getAllProperties(){  
        Enumeration en = properties.propertyNames();  
        StringBuffer sf = new StringBuffer();  
        while (en.hasMoreElements()) {  
           String key = (String) en.nextElement();  
           String value = properties.getProperty (key);  
           sf.append("\n"+key);  
           sf.append("=");  
           value = value.replace(":", "\\:");  
           sf.append(value);  
        }  
        return sf.toString();  
    }  
}
