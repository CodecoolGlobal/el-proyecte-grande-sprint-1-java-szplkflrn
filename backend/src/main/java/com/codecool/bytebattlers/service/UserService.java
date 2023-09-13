package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.UserDTO;
import com.codecool.bytebattlers.dao.BoardGameDAO;
import com.codecool.bytebattlers.dao.UsersDAO;
import com.codecool.bytebattlers.dao.model.User;


import java.util.Set;
import java.util.stream.Collectors;

public class UserService {

    private final UsersDAO usersDao;

    private final BoardGameDAO boardGameDAO;


    public UserService(UsersDAO usersDao, BoardGameDAO boardGameDAO) {
        this.usersDao = usersDao;
        this.boardGameDAO = boardGameDAO;
    }

    public Set<UserDTO> getAllUsers() {
        return usersDao.getAllUsers()
                .stream().map(this::transformDAOToDTO)
                .collect(Collectors.toSet());
    }

    public UserDTO getUserById(int id){
        return transformDAOToDTO(usersDao.getUserById(id));
    }

    public int addNewUser(User user) {
        usersDao.addNewUser(user);
        return user.id();
    }

    public void deleteUser(int id) {
        usersDao.deleteUser(id);
    }

    private UserDTO transformDAOToDTO(User user) {
        return new UserDTO(user.id(), user.userName(), user.email(), user.password());
    }

}
