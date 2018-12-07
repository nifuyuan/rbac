package com.hwua.rbac.dao;

import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.Role;

import java.util.List;

public interface RoleMapper {
    /**
     * 查询所有角色
     * @return
     */
    List<Role> query();

    /**
     * 查询所有角色
     * @return
     */
    List<Role> queryValidRoles();

    /**根据用户id查询角色id
     * 根据
     * @param userId
     * @return
     */
    List<Integer> queryRoleIdByUserId(Integer userId);

    /**
     * 根据角色名称、角色编码、是否有效查询角色
     * @param role
     * @return
     */
    List<Role> queryByProperties(Role role);

    /**
     * 添加角色
     * @param role
     * @return
     */
    int doInsert(Role role);
}
