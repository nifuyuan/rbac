package com.hwua.rbac.test;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Auth;
import com.hwua.rbac.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class Test {
    @org.junit.Test
    public void test(){
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        AuthService authService = context.getBean(AuthService.class);
        List<Auth> allAuths = authService.getAllAuths();
        System.out.println(JSON.toJSONString(allAuths));
    }
}
