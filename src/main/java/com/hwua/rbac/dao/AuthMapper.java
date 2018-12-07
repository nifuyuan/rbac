package com.hwua.rbac.dao;

import com.hwua.rbac.po.Auth;
import com.hwua.rbac.po.TreeNode;

import java.util.List;
import java.util.Map;

public interface AuthMapper {
    /**
     * 根据parentId查询所有auth
     * @param parentId
     * @return
     */
    List<Auth> queryByParentId(Integer parentId);

    /**
     * 根据parentId查询所有有效的权限
     * @param parentId
     * @return
     */
    List<TreeNode> queryValidByParentId(Integer parentId);

    /**根据角色id查询权限id
     * 根据
     * @param roleId
     * @return
     */
    List<Integer> queryAuthIdByRoleId(Integer roleId);
    /**
     * 根据dbid修改auth
     * @param auth
     * @return
     */
    int doUpdateByDbid(Auth auth);

    /**
     * 添加auth
     * @param auth
     * @return
     */
    int doInsert(Auth auth);

    /**
     * 根据角色id删除role_auth
     * @param roleId
     * @return
     */
    int doDelete(Integer roleId);

    /**
     * 往role_auth表插入数据
     * @param param,包括roleId,List<Integer>
     * @return
     */
    int doInsertByRoleIdAndAuthId(Map<String,Object> param);
}
