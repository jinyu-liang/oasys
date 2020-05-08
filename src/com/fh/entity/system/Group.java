package com.fh.entity.system;

import java.io.Serializable;

/**
 * 
* 类名称：组别
* 类描述： 
* @author liangjy@asiainfo.com
* 作者单位： 
* 联系方式：
* 创建时间：2014年3月10日
* @version 1.0
 */
public class Group implements Serializable{
	
	private String GROUP_ID;
	private String GROUP_NAME;
	private String REMARK;
	
	public String getGROUP_ID() {
		return GROUP_ID;
	}
	public void setGROUP_ID(String gROUP_ID) {
		GROUP_ID = gROUP_ID;
	}
	
	public String getGROUP_NAME() {
		return GROUP_NAME;
	}
	public void setGROUP_NAME(String gROUP_NAME) {
		GROUP_NAME = gROUP_NAME;
	}
	public String getREMARK() {
		return REMARK;
	}
	public void setREMARK(String rEMARK) {
		REMARK = rEMARK;
	}
	
	
}
