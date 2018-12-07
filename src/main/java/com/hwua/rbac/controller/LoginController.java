package com.hwua.rbac.controller;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.User;
import com.hwua.rbac.service.UserService;
import com.hwua.rbac.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @Autowired
    private UserService userService;
    @RequestMapping("/login")
    public String login(){
        return "login";
    }
    @RequestMapping(value = "/doLogin",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String doLogin(String username, String password, HttpSession session){
        User user = userService.doLogin(username, password);
        if(user != null){
            session.setAttribute("user",user);
            System.out.println(JSON.toJSONString(R.ok()));
            return JSON.toJSONString(R.ok());
        }else{
            JSON.toJSONString(R.error());
            return JSON.toJSONString(R.error());
        }
    }
}
