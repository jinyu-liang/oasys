package com.fh.dao;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * Created by LB on 2017/6/14.
 * 配置多数据源
 */
public class DynamicDataSource extends AbstractRoutingDataSource {
    //配置文件 ApplicationContext.xml 中设置的两个"key"名称
    public static final String DATASOURCE_MYSQL = "dataSource_mysql";
    public static final String DATASOURCE_ORSQL = "dataSource_oracle";
    //本地线程，获取当前正在执行的currentThread
    public static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();
  
    public static void setDbType(String dbType) {
        //把当前请求的参数，存入当前线程，这个参数是我们定义的DATASOURCE_A或者DATASOURCE_B
        System.out.println("当前切换的数据源="+dbType);
        contextHolder.set(dbType);
    }
    public static String getDbType() {
  
        return contextHolder.get();
    }
    //切换默认数据源
    public static void clearDbType() {
        contextHolder.remove();
    }
  
    protected Object determineCurrentLookupKey() {
        return getDbType();
    }
  

}
