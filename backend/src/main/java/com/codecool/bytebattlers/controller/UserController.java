package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.UserDTO;
import com.codecool.bytebattlers.dao.model.User;
import com.codecool.bytebattlers.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.Set;


@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/users")
    public Set<UserDTO> getAllUsers() {
        return userService.getAllUsers();
    }

    @GetMapping("/{id}")
    public UserDTO getUserById(@PathVariable int id) {
        return userService.getUserById(id);
    }

    @PostMapping("/newUser")
    public int addNewUser(@RequestBody User user) {
        return userService.addNewUser(user);
    }

    @DeleteMapping("/{id}")
    public void deleteUserById(@PathVariable int id) {
        userService.deleteUser(id);
    }

}


