package com.fh.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import com.fh.util.upload.SshConfiguration;
import com.fh.util.upload.SshUtil;
import com.jcraft.jsch.JSchException;

/**
 * 上传文件
 * 创建人：liangjy@asiainfo.com
 * 创建时间：2014年12月23日
 * @version
 */
public class FileUpload {

	/**
	 * @param file 			//文件对象
	 * @param filePath		//上传路径
	 * @param fileName		//文件名
	 * @return  文件名
	 * @throws Exception 
	 * @throws IOException 
	 */
	public static String fileUp(MultipartFile file, String filePath, String fileName ,String filepath){
		String extName = ""; // 扩展名格式：
		if (file.getOriginalFilename().lastIndexOf(".") >= 0) {
			extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		}
//		copyFile(file.getInputStream(), filePath, fileName+extName).replaceAll("-","");
		try {
			String path = copyFile(file.getInputStream(), fileName + extName, filepath);
			return path;
		}catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		
	}
	
	
	/**
	 * 写文件到当前远程的upload目录中
	 * 
	 * @param in
	 * @param fileName
	 * @throws IOException
	 * @throws JSchException 
	 */
	private static String copyFile(InputStream in, String realName,String filepath) {
		SshConfiguration configuration = new SshConfiguration();
		try {
			realName = configuration.getPath() + filepath + realName;
			SshUtil sshUtil = new SshUtil(configuration);
			sshUtil.upLoad(in, realName);
			sshUtil.close();
			System.out.println("文件上传完成");
			return realName;
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	/**
	 * 删除远端文件
	 * 
	 * @param in
	 * @param fileName
	 * @throws IOException
	 * @throws JSchException 
	 */
	public static boolean delete(String path) throws Exception {
		boolean flag = false;
		SshConfiguration configuration = new SshConfiguration();
		SshUtil sshUtil = new SshUtil(configuration);
		if (sshUtil.isDirExist(path)) {
			sshUtil.delete(path);
			sshUtil.close();
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 下载远端文件
	 * 
	 * @param in
	 * @param fileName
	 * @throws IOException
	 * @throws JSchException 
	 */
	public static boolean download(String savepath,String remotefile) throws Exception {
		boolean flag = false;
		SshConfiguration configuration = new SshConfiguration();
		SshUtil sshUtil = new SshUtil(configuration);
		if(sshUtil.isDirExist(remotefile)) {
			File file = new File(savepath);
			sshUtil.download(new FileOutputStream(file),remotefile);
			sshUtil.close();
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 写文件到当前目录的upload目录中
	 * 
	 * @param in
	 * @param fileName
	 * @throws IOException
	 */
//	private static String copyFile(InputStream in, String dir, String realName) throws IOException {
//		File file = new File(dir, realName);
//		if (!file.exists()) {
//			if (!file.getParentFile().exists()) {
//				file.getParentFile().mkdirs();
//			}
//			file.createNewFile();
//		}
//		FileUtils.copyInputStreamToFile(in, file);
//		return realName;
//	}

}
