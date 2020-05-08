/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fh.listener;

import java.util.Timer;
import java.util.TimerTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Service;

import com.fh.controller.system.secCode.ImageTool;
import com.fh.util.PathUtil;

/**
 * 启动监听器
 *
 * @author Storezhang
 */
@Service
public class StartupListener implements ApplicationListener<ContextRefreshedEvent> {

    @Override
    public void onApplicationEvent(ContextRefreshedEvent evt) {
        if (evt.getApplicationContext().getParent() == null) {
            createSitemap();
        }
    }

    private void createSitemap() {
    	String  fileIconDictory = PathUtil.getClasspath()+"\\temp";  
		ImageTool.creatDefaultVerificationCode(fileIconDictory); 
    	 System.out.println("--->Create StartupListener...");
    }
}