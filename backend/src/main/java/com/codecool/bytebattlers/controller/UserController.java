package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.AppUserDto;
import com.codecool.bytebattlers.controller.exception.ResourceNotFoundException;
import com.codecool.bytebattlers.model.AuthenticationResponse;
import com.codecool.bytebattlers.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<List<AppUserDto>> getAllUser() {
        if (userService.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(userService.findAll(), HttpStatus.OK);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<AppUserDto> getUserById(@PathVariable UUID id) {
        if (userService.findById(id) == null) {
            throw new ResourceNotFoundException("User not found with id = " + id);
        } else {
            return new ResponseEntity<>(userService.findById(id), HttpStatus.OK);
        }
    }

    @PatchMapping("/{id}")
    public ResponseEntity<AppUserDto> updateUserById(@PathVariable UUID id, @RequestBody UUID appUserDto) {
        try {
            if (id == null || appUserDto == null) {
                throw new Exception("Invalid input data");
            }
            AppUserDto user = userService.findById(id);
            if (user == null) {
                throw new ResourceNotFoundException("User not found with id = " + id);
            }
            AppUserDto updatedUser = userService.update(id, appUserDto);
            return new ResponseEntity<>(updatedUser, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/favorites/{id}")
    public ResponseEntity<AppUserDto> deleteBGFromFavorites(@PathVariable UUID id, @RequestBody UUID bgID) {
        try {
            if (id == null || bgID == null) {
                throw new Exception("Invalid input data");
            }
            AppUserDto user = userService.findById(id);
            if (user == null) {
                throw new ResourceNotFoundException("User not found with id = " + id);
            }
            AppUserDto userWithDeletedFavorite = userService.deleteFromFavorites(id, bgID);
            return new ResponseEntity<>(userWithDeletedFavorite, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/register")
    public ResponseEntity<AppUserDto> registerNewUser(@RequestBody AppUserDto user) {
        return new ResponseEntity<>(userService.register(user), HttpStatus.CREATED);
    }
    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> authenticateUser(@RequestBody AppUserDto user) {
        return new ResponseEntity<>(userService.authenticate(user), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<AppUserDto> deleteUserById(@PathVariable UUID id) {
        userService.deleteById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}


