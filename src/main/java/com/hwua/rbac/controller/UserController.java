package com.hwua.rbac.controller;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Role;
import com.hwua.rbac.po.User;
import com.hwua.rbac.service.RoleService;
import com.hwua.rbac.service.UserService;
import com.hwua.rbac.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @RequestMapping("/main")
    public String main(){
        return "user";
    }

    @RequestMapping(value = "/getUsers",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getUsers(){
        List<User> users = userService.getAllUsers();
        return JSON.toJSONString(users);
    }
    @RequestMapping(value = "/search",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String search(User user){
        List<User> users = userService.search(user);
        return JSON.toJSONString(users);
    }

    @RequestMapping(value = "/add",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String add(User user){
        int add = userService.add(user);
        return JSON.toJSONString(add == 1 ? R.ok() : R.error());
    }

    @RequestMapping(value = "/submit",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String submit(Integer userId, Integer[] roleIds){
        int submit = userService.submit(userId, roleIds);
        return JSON.toJSONString(submit > 0 ? R.ok() : R.error());
    }
}
