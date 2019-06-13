package com.qfedu.dao;

import com.qfedu.pojo.User;

import java.util.List;

public interface UserDao {

    public User findByName(String name);
    // 根据用户查询用户拥有的角色
    public List<String> findRolesByName(String name);
    // 查询用户拥有的权限
    public List<String> findPermsByName(String name);
}
