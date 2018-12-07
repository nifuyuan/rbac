package com.hwua.rbac.service;

import com.hwua.rbac.po.User;

import java.util.List;

public interface UserService {
    List<User> getAllUsers();

    List<User> search(User user);

    int add(User user);

    int submit(Integer userId,Integer[] roleIds);

    User doLogin(String username,String password);
}
