package com.fh.util.upload;

import com.fh.util.Const;
import com.fh.util.Tools;

/**
 * Created by 15600 on 2017/9/6.
 */
public class SshConfiguration {
    private static String host;
    private static int    port;
    private static String userName;
    private static String password;
    private static String path;

    public SshConfiguration() {
    	String strUPLOAD = Tools.readTxtFile(Const.UPLOAD);
    	System.out.print(strUPLOAD);
		if(null != strUPLOAD && !"".equals(strUPLOAD)){
			String strEM[] = strUPLOAD.split("\\,");
			if(strEM.length == 5){
				this.host =(strEM[0]);
				this.port = (Integer.valueOf(strEM[1]));
				this.userName = (strEM[2]);
				this.password = (strEM[3]);
				this.path = (strEM[4]);
			}
		}
    	
    }
    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public static String getPath() {
		return path;
	}
	public static void setPath(String path) {
		SshConfiguration.path = path;
	}
	public SshConfiguration(String host, int port, String userName, String password, String path) {
        this.host = host;
        this.port = port;
        this.userName = userName;
        this.password = password;
        this.path = path;
    }

}
