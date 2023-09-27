package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.AppUserDto;
import com.codecool.bytebattlers.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/api/appusers")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public List<AppUserDto> getAllUsers() {
        return userService.findAll();
    }

    @GetMapping("/{id}")
    public AppUserDto getUserById(@PathVariable Long id) {
        return userService.findById(id);
    }

    @PostMapping
    public void addNewUser(@RequestBody AppUserDto user) {
        userService.save(user);
    }

    @DeleteMapping("/{id}")
    public void deleteUserById(@PathVariable Long id) {
        userService.deleteById(id);
    }

}


