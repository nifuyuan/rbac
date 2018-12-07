package com.hwua.rbac.service.impl;

import com.hwua.rbac.dao.UserMapper;
import com.hwua.rbac.po.User;
import com.hwua.rbac.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("userService")
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public List<User> getAllUsers() {
        return userMapper.query();
    }

    @Override
    public List<User> search(User user) {
        return userMapper.queryByProperties(user);
    }

    @Override
    public int add(User user) {
        return userMapper.doInsert(user);
    }

    @Override
    public int submit(Integer userId, Integer[] roleIds) {
        int result = 0;
        result = userMapper.doDelete(userId);
        Map<String,Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("roleIds",roleIds);
        result = userMapper.doInsertByUserIdAndRoleIds(map);
        return result;
    }

    @Override
    public User doLogin(String username, String password) {
        return userMapper.queryByUsernameAndPassword(username,password);
    }

}
