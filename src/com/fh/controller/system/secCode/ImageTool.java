package com.fh.controller.system.secCode;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.filechooser.FileSystemView;

import org.apache.log4j.Logger;

/**
* @author liangjy@asiainfo.com
* 创建时间：2018年3月8日
* 类说明
*/

public class ImageTool {


	//LOG
	private final static Logger LOG = Logger.getLogger(ImageTool.class);
	//image
    private static BufferedImage image;   
    
    /**
     * createImage : out dest path for image
     * @param fileLocation dest path
     */
    private static void createImage(String fileLocation) {        
        try {            
            FileOutputStream fos = new FileOutputStream(fileLocation);            
            BufferedOutputStream bos = new BufferedOutputStream(fos);  
            ImageIO.write(image, "png", bos);
//            com.sun.image.codec.jpeg.JPEGImageEncoder encoder = com.sun.image.codec.jpeg.JPEGCodec.createJPEGEncoder(bos);            
//            encoder.encode(image);            
            bos.flush();
            bos.close(); 
            LOG.info("@2"+fileLocation+"图片生成输出成功");   
       } catch (Exception e) {            
            LOG.info("@2"+fileLocation+"图片生成输出失败",e);    
       }
    }
    /**
     * createFileIconImage ：create share file list icon
     * @param destOutPath  create file icon save dictory 
     */
    public void createFileIconImage(String destOutPath){
	     //get properties operate tool
	     PropertiesTool propertiesTool = PropertiesTool.getInstance("");
	     //get share file root path
	     String shareFileRootPath = propertiesTool.getPropertiesValue("FileShareRootPath");
	     //root dictory
	     File rootDictory = new File(shareFileRootPath);
	     //child file list
	     File [] fileList = rootDictory.listFiles();
	     //child list files
	     File file = null;
	     if(fileList != null && fileList.length>0){
	    	 LOG.info("分享文件根目录下文件数:"+fileList.length);
	    	 for(int i = 0,j = fileList.length;i < j;i++){
	    		 String fileName = fileList[i].getName();
	    		 String fileAllName = shareFileRootPath +fileName;
	    		 file = new File(fileAllName);
	    		 //get file system icon
	    		 ImageIcon fileIcon = (ImageIcon) FileSystemView.getFileSystemView().getSystemIcon(file);
	    		 image = (BufferedImage) fileIcon.getImage();
	    		 if(image != null){
	    			 LOG.info("@1"+fileName+"文件的图标获取成功");
	    		 }
	    		 Graphics g = image.getGraphics();
	    		 g.drawImage(image, 0, 0, null);
	    		 String fileNameX = fileName.substring(0,fileName.lastIndexOf("."));
	    		 //out image to dest
	    		 createImage(destOutPath+"\\"+fileNameX+".png");
	    		 LOG.info("@3"+fileName+"文件的图标生成成功");
	    	 }
	     }
    }
    
    /**
     * creatDefaultVerificationCode ：create default verification code
     * @param destOutPath  create creatDefaultVerificationCode save dictory 
     */
    public static void creatDefaultVerificationCode(String destOutPath){
    	//verification code image height
    	//comment to com.tss.fileshare.tools.VerificationCodeTool  65 row,please
    	int imgwidth=146;
    	int imgheight=30;
    	int disturblinesize = 15;
    	VerificationCodeTool vcTool = new VerificationCodeTool();
    	//default verification code
		 image = new BufferedImage(imgwidth, imgheight, BufferedImage.TYPE_INT_RGB);
		Graphics g = image.getGraphics();
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, 146, 30);
		g.setColor(vcTool.getRandomColor(200,250));
		g.drawRect(0, 0, imgwidth-2, imgheight-2);
		for(int i =0;i < disturblinesize; i++){
			vcTool.drawDisturbLine1(g);
			vcTool.drawDisturbLine2(g);
		}
		//玩命加载中…
		String defaultVCString = "\u73A9\u547D\u52A0\u8F7D\u4E2D\u2026";
		String dfch = null;
		for(int i = 0;i < 6;i++){
			dfch = String.valueOf(defaultVCString.charAt(i));
			vcTool.drawRandomString((Graphics2D)g, dfch, i);
		}
		LOG.info("默然验证码生成成功");
//		Graphics gvc = imagevc.getGraphics();
		createImage(destOutPath+"\\defaultverificationcode.jpg");
    }
   /**
    * graphicsGeneration : create image
    * @param imgurl display picture url . eg:F:/imagetool/7.jpg<br/>
    * @param imageOutPathName image out path+naem .eg:F:\\imagetool\\drawimage.jpg<br/>
    * @param variableParmeterLength ; int, third parameter length.<br/>
    * @param drawString variableParmeterLength ;String [] .<br/>
    */
    public void graphicsGeneration(String imgurl,String imageOutPathName,int variableParmeterLength,String...drawString) {
        //The width of the picture
        int imageWidth = 500;   
        //The height of the picture
        int imageHeight = 400;   
        image = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_RGB);        
        Graphics graphics = image.getGraphics();        
        graphics.setColor(Color.WHITE);    
        //drawing image
        graphics.fillRect(0, 0, imageWidth, imageHeight);        
        graphics.setColor(Color.BLACK);        
        //draw string  string , left margin,top margin
        for(int i = 0,j = variableParmeterLength;i < j;i++){
        	graphics.drawString(drawString[i], 50, 10+15*i);
        }
        //draw image url
        ImageIcon imageIcon = new ImageIcon(imgurl); 
        //draw image , left margin,top margin
        //The coordinates of the top left corner as the center(x,y)[left top angle]
        //Image observer :If img is null, this method does not perform any action
        graphics.drawImage(imageIcon.getImage(), 200, 0, null); 
        createImage(imageOutPathName);    
    }

    public BufferedImage getImage() {
		return image;
	}
	public void setImage(BufferedImage image) {
		this.image = image;
	}

}
