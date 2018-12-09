package com.hwua.rbac.controller;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.User;
import com.hwua.rbac.service.AuthService;
import com.hwua.rbac.service.UserService;
import com.hwua.rbac.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class LoginController {
    @Autowired
    private AuthService authService;
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
            List<Auth> auths = authService.getAuthByUserId(user.getDbid());
            session.setAttribute("user",user);
            session.setAttribute("auths",auths);
            return JSON.toJSONString(R.ok());
        }else{
            JSON.toJSONString(R.error());
            return JSON.toJSONString(R.error());
        }
    }
    @RequestMapping("/logout")
    public String logout(){
        return "login";
    }
}
