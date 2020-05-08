package com.fh.util.upload;

import com.jcraft.jsch.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

/**
 * Created by 15600 on 2017/9/6.
 */
public class SshUtil {
    private ChannelSftp channelSftp;
    private ChannelExec channelExec;
    private Session session=null;
    private int timeout=60000;

    public SshUtil(SshConfiguration conf) throws JSchException {
        System.out.println("try connect to  "+conf.getHost()+",username: "+conf.getUserName()+",password: "+conf.getPassword()+",port: "+conf.getPort());
        JSch jSch=new JSch(); //创建JSch对象
        session=jSch.getSession(conf.getUserName(), conf.getHost(), conf.getPort());//根据用户名，主机ip和端口获取一个Session对象
        session.setPassword(conf.getPassword()); //设置密码
        Properties config=new Properties();
        config.put("StrictHostKeyChecking", "no");
        session.setConfig(config);//为Session对象设置properties
        session.setTimeout(timeout);//设置超时
        session.connect();//通过Session建立连接
        
        channelSftp=(ChannelSftp) session.openChannel("sftp");
        channelSftp.connect();
    }
    public void download(String src,String dst) throws JSchException, SftpException{
        //src linux服务器文件地址，dst 本地存放地址
        channelSftp.get(src, dst);
        channelSftp.quit();
    }
    public void upLoad(String src,String dst) throws JSchException,SftpException{
        //src 本机文件地址。 dst 远程文件地址
        channelSftp.put(src, dst);
        channelSftp.quit();
    }
    
    public void delete(String path) throws JSchException,SftpException{
        //path远程文件地址
        channelSftp.rm(path);
        channelSftp.quit();
    }
    
    /** 
     * 判断目录是否存在 
     */  
    public boolean isDirExist(String directory) {  
       boolean isDirExistFlag = false;
       try {
           SftpATTRS sftpATTRS = channelSftp.lstat(directory);
           isDirExistFlag = true;
           return sftpATTRS.isReg();
       } catch (Exception e) {
           if (e.getMessage().toLowerCase().equals("no such file")) {
               isDirExistFlag = false;
           }
       }
       channelSftp.quit();
       return isDirExistFlag;
    } 
 
    /**
     * 流操作
     * @param src
     * @param dst
     * @throws JSchException
     * @throws SftpException
     */
    
    public void download(OutputStream out,String dst) throws Exception{
        //src linux服务器文件地址，dst 本地存放地址
        channelSftp=(ChannelSftp) session.openChannel("sftp");
        channelSftp.connect();
        channelSftp.get(dst,out);
        channelSftp.quit();
    }
    public void upLoad(InputStream in,String dst) throws Exception{
        //src 本机文件地址。 dst 远程文件地址
        channelSftp=(ChannelSftp) session.openChannel("sftp");
        channelSftp.connect();
        channelSftp.put(in, dst);
        channelSftp.quit();
    }
    
    public void close(){
        session.disconnect();
    }
    public static void main(String[] args){
        SshConfiguration configuration=new SshConfiguration();
        try{
//            SshUtil sshUtil=new SshUtil(configuration);
//            sshUtil.download("/home/cafintech/Logs/metaData/meta.log","D://meta.log");
//            sshUtil.close();
//            System.out.println("文件下载完成");
            SshUtil sshUtil=new SshUtil(configuration);
            File file = new File("F:\\tmp001.xlsx");
            sshUtil.upLoad(new FileInputStream(file),configuration.getPath()+"/11.xlsx");
            sshUtil.close();
            System.out.println("文件上传完成");
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
