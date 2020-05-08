package com.fh.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Vector;

import org.apache.commons.lang.StringUtils;
import org.slf4j.LoggerFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.ChannelSftp.LsEntry;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class SftpUtil {
	private final static org.slf4j.Logger log = LoggerFactory.getLogger(SftpUtil.class);

	/** SFTP */
	public static final String SFTP = "sftp";
	/** 通道 */
	private static ChannelSftp channel;
	private static Channel channel1;
	/** session */
	private static Session session;

	/** 规避多线程并发不断开问题 */
	private static ThreadLocal<SftpUtil> sftpLocal = new ThreadLocal<SftpUtil>();

	/**
	 * 获取sftpchannel
	 * 
	 * @param connectConfig
	 *            连接配置
	 * @return
	 * @throws Exception
	 * @throws JSchException
	 */
	private void init(ConnectConfig connectConfig) throws Exception {
		String host = connectConfig.getHost();
		int port = connectConfig.getPort();

		String userName = connectConfig.getUserName();

		// 创建JSch对象
		JSch jsch = new JSch();

		// 添加私钥(信任登录方式)
		if (StringUtils.isNotBlank(connectConfig.getPrivateKey())) {
			jsch.addIdentity(connectConfig.getPrivateKey());
		}

		session = jsch.getSession(userName, host, port);
		// if (log.isInfoEnabled()) {
		// log.info(" JSCH Session created,sftpHost = {}, sftpUserName={}", host,
		// userName);
		// }

		// 设置密码
		if (StringUtils.isNotBlank(connectConfig.getPassWord())) {
			session.setPassword(connectConfig.getPassWord());
		}

		Properties config = new Properties();
		config.put("StrictHostKeyChecking", "no");
		session.setConfig(config);
		// 设置超时
		session.setTimeout(connectConfig.getTimeout());
		// 建立连接
		session.connect();

		if (log.isInfoEnabled()) {
			log.info("JSCH Session connected.sftpHost = {}, sftpUserName={}", host, userName);
		}

		// 打开SFTP通道
		channel = (ChannelSftp) session.openChannel(SFTP);
		// 建立SFTP通道的连接
		channel.connect();
		if (log.isInfoEnabled()) {
			log.info("Connected successfully to sftpHost = {}, sftpUserName={}", host, userName);
		}
	}

	/**
	 * 是否已连接
	 * 
	 * @return
	 */
	private boolean isConnected() {
		return null != channel && channel.isConnected();
	}

	/**
	 * 获取本地线程存储的sftp客户端
	 * 
	 * @return
	 * @throws Exception
	 */
	public static SftpUtil getSftpUtil(ConnectConfig connectConfig) throws Exception {
		SftpUtil sftpUtil = sftpLocal.get();
		if (null == sftpUtil || !sftpUtil.isConnected()) {
			sftpLocal.set(new SftpUtil(connectConfig));
		}
		return sftpLocal.get();
	}

	/**
	 * 释放本地线程存储的sftp客户端
	 */
	public static void release() {
		System.out.println("sftpLocal.get()-------------" + sftpLocal.get());
		if (null != sftpLocal.get()) {
			sftpLocal.get().closeChannel();
			sftpLocal.set(null);
		}
	}

	/**
	 * 构造函数
	 * <p>
	 * 非线程安全，故权限为私有
	 * </p>
	 * 
	 * @throws Exception
	 */
	private SftpUtil(ConnectConfig connectConfig) throws Exception {
		super();
		init(connectConfig);
	}

	/**
	 * 关闭通道
	 * 
	 * @throws Exception
	 */
	public void closeChannel() {
		System.out.println("closeChannel=====================----");
		if (null != channel) {
			try {
				channel.disconnect();
			} catch (Exception e) {
				log.error("关闭SFTP通道发生异常:", e);
			}
		}
		if (null != session) {
			try {
				session.disconnect();
			} catch (Exception e) {
				log.error("SFTP关闭 session异常:", e);
			}
		}
	}

	/**
	 * 下载文件
	 * 
	 * @param downDir
	 *            下载目录
	 * @param src
	 *            源文件
	 * @param dst
	 *            保存后的文件名称或目录
	 * @throws Exception
	 */
	public void downFile(String downDir, String src, String dst) throws Exception {
		channel.cd(downDir);
		channel.get(src, dst);
	}

	/**
	 * 删除文件
	 * 
	 * @param filePath
	 *            文件全路径
	 * @throws SftpException
	 */
	public void deleteFile(String filePath) throws SftpException {
		channel.rm(filePath);
	}

	@SuppressWarnings("unchecked")
	public static List<String> listFiles(String dir) throws SftpException {
		Vector<LsEntry> files = channel.ls(dir);
		if (null != files) {
			List<String> fileNames = new ArrayList<String>();
			Iterator<LsEntry> iter = files.iterator();
			while (iter.hasNext()) {
				String fileName = iter.next().getFilename();
				if (StringUtils.equals(".", fileName) || StringUtils.equals("..", fileName)) {
					continue;
				}
				fileNames.add(fileName);
			}
			return fileNames;
		}
		return null;
	}

	protected static void sshTesting() {
		String name = "";
		String userName = "upload";
		String password = "1q1w1e1r";
		String ip = "10.143.4.122";
		int port = 22;
		String command = "date";

		try {
			JSch jsch = new JSch();
			Session session = jsch.getSession(userName, ip, port);
			session.setPassword(password);

			// Missing code
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			session.setTimeout(1000);
			session.connect();
			System.out.println("Establishing connection----");

			Channel channel = session.openChannel("sftp");
			// ((ChannelExec) channel).setCommand(command);
			channel.setInputStream(null);
			channel.connect();

		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {

		}
	}

	private static class Worker extends Thread {
		private int i;
		private int idx = 0;

		public Worker(int i) {
			this.i = i;
		}

		@Override
		public void run() {
			while (true) {
				try {
					// sshTesting();
					System.out.println("Tread name:" + Thread.currentThread().getName()
							+ "--------------------------------------000");
					getSftpUtil(new ConnectConfig());
					List<String> aa = listFiles("/home/upload/4aserver/attach");
					System.out.println(
							"Tread name:" + Thread.currentThread().getName() + "---i:" + i + "----name:" + aa.get(0));
					System.out.println("Tread name:" + Thread.currentThread().getName()
							+ "--------------------------------------111");
					Thread.sleep(1000);

				} catch (Exception e) {
					System.out.println("Tread name:" + Thread.currentThread().getName()
							+ "--------------------------------------222");
					release();
					System.out.println("Tread name:" + Thread.currentThread().getName()
							+ "--------------------------------------33");
					e.printStackTrace();
				} finally {
					System.out.println("Tread name:" + Thread.currentThread().getName()
							+ "--------------------------------------44");
					release();
					System.out.println("Tread name:" + Thread.currentThread().getName()
							+ "--------------------------------------55");
				}

			}
		}
	}

	public static void main(String[] args) throws Exception {
		for (int i = 1; i <= 10; i++) {
			Thread worker = new Worker(i);
			worker.start();
			Thread.sleep(10000);
		}
	}
}