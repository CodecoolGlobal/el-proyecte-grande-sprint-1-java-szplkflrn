package com.codecool.bytebattlers.dao;

import com.codecool.bytebattlers.dao.model.User;

import java.util.Set;


public interface UsersDAO {

    Set<User> getAllUsers();
    User getUserById(int id);
    int addNewUser(User user);
    boolean deleteUser(int id);
}
