package com.hwua.rbac.service.impl;

import com.hwua.rbac.dao.RoleMapper;
import com.hwua.rbac.po.Role;
import com.hwua.rbac.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service("roleService")
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;
    @Override
    public List<Role> getAllRoles() {
        return roleMapper.query();
    }

    @Override
    public List<Role> getValidRoles() {
        return roleMapper.queryValidRoles();
    }

    @Override
    public List<Integer> getRolesByUserId(Integer userId) {
        return roleMapper.queryRoleIdByUserId(userId);
    }

    @Override
    public List<Role> search(Role role) {
        return roleMapper.queryByProperties(role);
    }

    @Override
    public int add(Role role) {
        return roleMapper.doInsert(role);
    }

}
