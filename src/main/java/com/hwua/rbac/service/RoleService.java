package com.hwua.rbac.service;

import com.hwua.rbac.po.Role;

import java.util.List;

public interface RoleService {
    List<Role> getAllRoles();

    List<Role> getValidRoles();

    List<Integer> getRolesByUserId(Integer userId);

    List<Role> search(Role role);

    int add(Role role);
}
