package com.hwua.rbac.controller;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.TreeNode;
import com.hwua.rbac.service.AuthService;
import com.hwua.rbac.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private AuthService authService;
    @RequestMapping("/main")
    public String main(){
        return "auth";
    }

    @RequestMapping(value = "/getAuths",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAuths(){
        List<Auth> auths = authService.getAllAuths();
        return JSON.toJSONString(auths);
    }
    @RequestMapping(value = "/edit",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String editAuth(Auth auth){
        int edit = authService.edit(auth);
        return JSON.toJSONString(edit == 1 ? R.ok() : R.error());
    }

    @RequestMapping(value = "/add",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String addAuth(Auth auth){
        int add = authService.add(auth);
        return JSON.toJSONString(add == 1 ? R.ok() : R.error());
    }

    @RequestMapping(value = "/getValidAuths",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getValidAuths(Integer roleId){
        List<TreeNode> auths = authService.getValidAuth(roleId);
        return JSON.toJSONString(auths);
    }
    @RequestMapping(value = "/submit",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String submit(Integer roleId,Integer[] authIds){
        int submit = authService.submit(roleId, authIds);
        return JSON.toJSONString(submit > 0 ? R.ok() : R.error());
    }

}
