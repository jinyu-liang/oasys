package com.fh.test;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
/**
* @author liangjy@asiainfo.com
* 创建时间：2018年2月23日
* 类说明
*/
@RestController
@EnableAutoConfiguration
public class test {

	public test() {
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping("/")
	public String index() {
		System.out.println("11111");
		return "222222";
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		SpringApplication.run(test.class, args);
	}

}
