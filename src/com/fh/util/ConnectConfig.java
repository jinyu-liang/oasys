package com.fh.util;


/**
* @author liangjy@asiainfo.com
* 创建时间：2018年8月10日
* 类说明
*/

public class ConnectConfig {
	private String Host = "10.143.4.122";
	private int Port = 22;
	private String UserName ="upload";
	private String PrivateKey = null;
	private String PassWord = "1q1w1e1r";
	private int Timeout =10000;
	
	
	public String getHost() {
		return Host;
	}
	public void setHost(String host) {
		Host = host;
	}
	public int getPort() {
		return Port;
	}
	public void setPort(int port) {
		Port = port;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	public String getPrivateKey() {
		return PrivateKey;
	}
	public void setPrivateKey(String privateKey) {
		PrivateKey = privateKey;
	}
	public String getPassWord() {
		return PassWord;
	}
	public void setPassWord(String passWord) {
		PassWord = passWord;
	}
	public int getTimeout() {
		return Timeout;
	}
	public void setTimeout(int timeout) {
		Timeout = timeout;
	}
	
	

}
