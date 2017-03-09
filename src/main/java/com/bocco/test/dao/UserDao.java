package com.bocco.test.dao;

import com.bocco.test.model.User;

import java.util.List;

/**
 * Created by zandr on 26.02.2017.
 */
public interface UserDao {
    void addUser(User user);

    void updateUser(User user);

    void removeUser(int id);

    User getUserById(int id);

    List<User> listUsers();
}
