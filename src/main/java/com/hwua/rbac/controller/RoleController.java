package com.hwua.rbac.controller;

import com.alibaba.fastjson.JSON;
import com.hwua.rbac.po.Role;
import com.hwua.rbac.service.RoleService;
import com.hwua.rbac.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private RoleService roleService;
    @RequestMapping("/main")
    public String main(){
        return "role";
    }

    @RequestMapping(value = "/getRoles",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getRoles(){
        List<Role> roles = roleService.getAllRoles();
        return JSON.toJSONString(roles);
    }
    @RequestMapping(value = "/search",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String search(Role role){
        List<Role> roles = roleService.search(role);
        return JSON.toJSONString(roles);
    }

    @RequestMapping(value = "/add",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String add(Role role){
        int add = roleService.add(role);
        System.out.println("add = " + add);
        return JSON.toJSONString(add == 1 ? R.ok() : R.error());
    }

    @RequestMapping(value = "/getValidRoles",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getValidRoles(){
        List<Role> roles = roleService.getValidRoles();
        return JSON.toJSONString(roles);
    }

    @RequestMapping(value = "/getRolesByUserId",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getRolesByUserId(Integer userId){
        List<Integer> roleIds = roleService.getRolesByUserId(userId);
        return JSON.toJSONString(roleIds);
    }
}
