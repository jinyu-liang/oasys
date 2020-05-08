package com.fh.util.upload;
 
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;
import java.util.Properties;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;
 
/**
 * @author : lzq
 * @group : huchi
 * @Date : 2015-2-26 上午10:13:30
 * @Comments : 通过SFTP，读取数据
 * @Version : 1.0.0
 */
public class SFTPChannel {
 
	Session session = null;
	Channel channel = null;
 
	private static final Logger LOG = Logger.getLogger(SFTPChannel.class);
 
	/**
	 * @MethodName : getChannel
	 * @Description : 得到Channel
	 * @param sftpDetails
	 * @param timeout
	 *            超时时间
	 * @return
	 * @throws JSchException
	 */
	public ChannelSftp getChannel(Map<String, String> sftpDetails, int timeout)
			throws JSchException {
 
		String ftpHost = sftpDetails.get(SFTPConstants.SFTP_REQ_HOST);
		String port = sftpDetails.get(SFTPConstants.SFTP_REQ_PORT);
		String ftpUserName = sftpDetails.get(SFTPConstants.SFTP_REQ_USERNAME);
		String ftpPassword = sftpDetails.get(SFTPConstants.SFTP_REQ_PASSWORD);
 
		JSch jsch = new JSch(); // 创建JSch对象
		session = jsch.getSession(ftpUserName, ftpHost, Integer.parseInt(port)); // 根据用户名，主机ip，端口获取一个Session对象
		LOG.debug("Session created.");
		if (ftpPassword != null) {
			session.setPassword(ftpPassword); // 设置密码
		}
		Properties config = new Properties();
		config.put("StrictHostKeyChecking", "no");
		session.setConfig(config); // 为Session对象设置properties
		session.setTimeout(timeout); // 设置timeout时间
		session.connect(); // 通过Session建立链接
		LOG.debug("Session connected.");
 
		LOG.debug("Opening Channel.");
		channel = session.openChannel("sftp"); // 打开SFTP通道
		channel.connect(); // 建立SFTP通道的连接
		LOG.debug("Connected successfully to ftpHost = " + ftpHost + ",as ftpUserName = "
				+ ftpUserName + ", returning: " + channel);
		return (ChannelSftp) channel;
	}
 
	/**
	 * @MethodName : closeChannel
	 * @Description : 关闭channel
	 * @throws Exception
	 */
	public void closeChannel() throws Exception {
		if (channel != null) {
			channel.disconnect();
		}
		if (session != null) {
			session.disconnect();
		}
	}
 
	/**
	 * @MethodName : getSFTPChannel
	 * @Description : 得到SFTPChannel 类实例对象
	 * @return
	 */
	public SFTPChannel getSFTPChannel() {
		return new SFTPChannel();
	}
	
	/**
	 * @MethodName	: download
	 * @Description	: 下载文件
	 * @param directory  下载目录
	 * @param downloadFile 下载的文件
	 * @param saveFile 存在本地的路径
	 * @param sftp 
	 */
	public void download(String directory, String downloadFile, String saveFile, ChannelSftp sftp) {
		try {
			sftp.cd(directory);
			File file = new File(saveFile);
			sftp.get(downloadFile, new FileOutputStream(file));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @MethodName	: upload
	 * @Description	: 上传文件
	 * @param directory  上传的目录
	 * @param uploadFile  要上传的文件
	 * @param sftp
	 */
	public void upload(String directory, String uploadFile, ChannelSftp sftp) {
		try {
			sftp.cd(directory);
			File file = new File(uploadFile);
			sftp.put(new FileInputStream(file), file.getName());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @MethodName	: delete
	 * @Description	:  删除文件
	 * @param directory 要删除文件所在目录
	 * @param deleteFile 要删除的文件
	 * @param sftp
	 */
	public void delete(String directory, String deleteFile, ChannelSftp sftp) {
		try {
			sftp.cd(directory);
			sftp.rm(deleteFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @MethodName	: listFiles
	 * @Description	: 列出目录下的文件
	 * @param directory  要列出的目录
	 * @param sftp sftp
	 * @return
	 * @throws SftpException
	 */
	public Vector listFiles(String directory, ChannelSftp sftp) throws SftpException {
		return sftp.ls(directory);
	}
	
	
	public static void main(String[] args) throws Exception {
		// 设置主机ip，端口，用户名，密码
		Map<String, String> sftpDetails = BackendUtils.GetConfigProperty(
				"property/account.properties", SFTPConstants.SFTP_REQ_HOST,
				SFTPConstants.SFTP_REQ_USERNAME, SFTPConstants.SFTP_REQ_PASSWORD,
				SFTPConstants.SFTP_REQ_PORT, SFTPConstants.SFTP_PARTNER);
 
		SFTPChannel channel = new SFTPChannel();
		ChannelSftp chSftp = channel.getChannel(sftpDetails, 60000);
 
		// 获取昨天
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String yesterday = new SimpleDateFormat("yyyyMMdd").format(cal.getTime()); // 昨天
 
		//连连文件目录
		String directory = "/bjmx/"+sftpDetails.get(SFTPConstants.SFTP_PARTNER)+"/";
		
		//连连交易记录文件
		String downloadFile = "JYMX_"+sftpDetails.get(SFTPConstants.SFTP_PARTNER)+"_"+yesterday+".txt";
		
		//保存本地的文件全路径
		String saveFile = "D:\\lianTradeRecord\\JYMX_"+sftpDetails.get(SFTPConstants.SFTP_PARTNER)+"_"+yesterday+".txt";
		
		//下载文件
		channel.download(directory, downloadFile, saveFile, chSftp); 
 
		//中文正则表达式
		String regEx = "[\\u4e00-\\u9fa5]";  
        Pattern p = Pattern.compile(regEx);  
 
		try {
			BufferedReader br = new BufferedReader(new FileReader(saveFile));
			String str;
			while ((str = br.readLine()) != null) {
				Matcher m = p.matcher(str.substring(0, 1));
				if (m.find()) {
					continue;
				}
				String[] rows = str.split(",");
				for (String row : rows) {
					System.out.println(row);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			chSftp.quit();
			channel.closeChannel();
		}
	}

	
}
