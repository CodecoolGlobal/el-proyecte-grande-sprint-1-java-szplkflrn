package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.UserDto;
import com.codecool.bytebattlers.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/users")
    public List<UserDto> getAllUsers() {
        return userService.findAll();
    }

    @GetMapping("/{id}")
    public UserDto getUserById(@PathVariable Long id) {
        return userService.findById(id);
    }

    @PostMapping("/newUser")
    public void addNewUser(@RequestBody UserDto user) {
        userService.save(user);
    }

    @DeleteMapping("/{id}")
    public void deleteUserById(@PathVariable Long id) {
        userService.deleteById(id);
    }

}


