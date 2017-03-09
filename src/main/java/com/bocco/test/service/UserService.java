package com.bocco.test.service;

import com.bocco.test.model.User;

import java.util.List;

/**
 * Created by zandr on 03.03.2017.
 */
public interface UserService {
    void addUser(User user);

    void updateUser(User user);

    void removeUser(int id);

    User getUserById(int id);

    List<User> listUsers();
}
