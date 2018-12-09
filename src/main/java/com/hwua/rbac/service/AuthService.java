package com.hwua.rbac.service;

import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.RoleAuth;
import com.hwua.rbac.po.TreeNode;

import java.util.List;
import java.util.Map;

public interface AuthService {
    List<Auth> getAllAuths();

    List<TreeNode> getValidAuth(Integer roleId);

    List<Auth> getAuthByUserId(Integer userId);

    int edit(Auth auth);

    int add(Auth auth);

    int submit(Integer roleId, Integer[] authIds);

}
