package com.test.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import redis.clients.jedis.Jedis;

import java.util.List;

/**
* @author liangjy@asiainfo.com
* 创建时间：2019年11月4日
* 类说明
*/

@DisplayName("我的第一个测试用例")
public class ValueSourcesExampleTest {
 
    @ParameterizedTest
    @ValueSource(ints = {2, 4, 8})
    void testNumberShouldBeEven(int num) {
        Assertions.assertEquals(0, num % 2);
    }

    @ParameterizedTest
    @ValueSource(strings = {"Effective Java", "Code Complete", "Clean Code"})
    void testPrintTitle(String title) {
        System.out.println(title);
    }


    @Test
    public void testBitField1(){

        Jedis jedis=new Jedis("10.143.4.122",12001);

        String key="test_"+System.currentTimeMillis();

        jedis.bitfield(key,"set","u1","1","1","set","u1","3","1","set","u1","6","1");

        for(int i=0;i<8;i++){
            System.out.println(i+"---"+jedis.getbit(key,i));
        }
    }

    @Test

    public void testBitField2(){

        Jedis jedis=new Jedis("10.143.4.122",12001);

        String key="test_"+System.currentTimeMillis();

        jedis.setbit(key,2,true);
        jedis.setbit(key,7,true);
        jedis.setbit(key,4,true);


        List<Long> result = jedis.bitfield(key,
                "get", "u1", "2",
                "get", "u1", "6",
                "get", "u1", "1",
                "get", "u1", "3",
                "get", "u1", "4",
                "get", "u1", "5",
                "get", "u1", "7",
                "get", "u1", "8");
        System.out.println(result);

    }



}

