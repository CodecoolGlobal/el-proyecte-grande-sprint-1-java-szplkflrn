package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.AppUserDto;
import com.codecool.bytebattlers.controller.exception.ResourceNotFoundException;
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
    public ResponseEntity<List<AppUserDto>> getAllCategory() {
        if (userService.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(userService.findAll(), HttpStatus.OK);
        }
    }
    @GetMapping("/{id}")
    public ResponseEntity<AppUserDto> getCategoryById(@PathVariable UUID id) {
        if (userService.findById(id) == null) {
            throw new ResourceNotFoundException("Not found Tutorial with id = " + id);
        } else {
            return new ResponseEntity<>(userService.findById(id), HttpStatus.OK);
        }
    }
    @PostMapping
    public ResponseEntity<AppUserDto>  addNewCategory(@RequestBody AppUserDto board) {
        return new ResponseEntity<>(userService.save(board), HttpStatus.CREATED);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<AppUserDto> deleteCategoryById(@PathVariable UUID id) {
        userService.deleteById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}


