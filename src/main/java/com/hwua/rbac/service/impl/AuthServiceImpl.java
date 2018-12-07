package com.hwua.rbac.service.impl;

import com.hwua.rbac.dao.AuthMapper;
import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.RoleAuth;
import com.hwua.rbac.po.TreeNode;
import com.hwua.rbac.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("authService")
public class AuthServiceImpl implements AuthService {
    @Autowired
    private AuthMapper authMapper;
    @Override
    public List<Auth> getAllAuths() {
        return authMapper.queryByParentId(-1);
    }

    @Override
    public List<TreeNode> getValidAuth(Integer roleId) {
        //所有有效的权限
        List<TreeNode> nodes = authMapper.queryValidByParentId(-1);
        //查询角色对应的权限
        List<Integer> authIds = authMapper.queryAuthIdByRoleId(roleId);
        parseAuth(nodes,authIds);
        return nodes;
    }

    private void parseAuth(List<TreeNode> nodes, List<Integer> authIds) {
        for (TreeNode treeNode:nodes) {
            if(authIds.contains(treeNode.getId())){
                treeNode.setChecked(true);
            }
            List<TreeNode> children = treeNode.getChildren();
            parseAuth(children,authIds);
        }
    }

    @Override
    public int edit(Auth auth) {
        return authMapper.doUpdateByDbid(auth);
    }

    @Override
    public int add(Auth auth) {
        return authMapper.doInsert(auth);
    }

    @Override
    public int submit(Integer roleId, Integer[] authIds) {
        int result = 0;
        result = authMapper.doDelete(roleId);
        Map<String,Object> map = new HashMap<>();
        map.put("roleId",roleId);
        map.put("authIds",authIds);
        result += authMapper.doInsertByRoleIdAndAuthId(map);
        return result;
    }
}
