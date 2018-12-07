package com.hwua.rbac.dao;

import com.hwua.rbac.po.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    /**
     * 查询所有用户
     * @return
     */
    List<User> query();

    /**
     * 根据用户名称、真实姓名、用户状态查询用户
     * @param user
     * @return
     */
    List<User> queryByProperties(User user);

    /**
     * 添加用户
     * @param user
     * @return
     */
    int doInsert(User user);

    /**
     * 根据角色id删除user_role
     * @param userId
     * @return
     */
    int doDelete(Integer userId);

    /**
     * 根据userId和roleIds添加user_role
     * @param param
     * @return
     */
    int doInsertByUserIdAndRoleIds(Map<String,Object> param);

    /**
     * 根据用户名和密码查询用户
     * @param username
     * @param password
     * @return
     */
    User queryByUsernameAndPassword(@Param("username")String username,@Param("password") String password);
}
