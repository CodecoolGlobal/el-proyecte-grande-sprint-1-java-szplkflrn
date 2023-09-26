package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.UserDto;
import com.codecool.bytebattlers.mapper.UserMapper;
import com.codecool.bytebattlers.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final UserMapper entityMapper;

    @Autowired
    public UserService(UserRepository userRepository, UserMapper entityMapper) {
        this.userRepository = userRepository;
        this.entityMapper = entityMapper;
    }

    public List<UserDto> findAll() {
        return userRepository.findAll().stream()
                .map(entityMapper::toDto1)
                .collect(Collectors.toList());
    }

    public void save(UserDto entity) {
        userRepository.save(entityMapper.toEntity(entity));
    }

    public UserDto findById(Long aLong) {
        return userRepository.findById(aLong)
                .map(entityMapper::toDto1)
                .orElseThrow(NoSuchElementException::new);
    }

    public void deleteById(Long aLong) {
        userRepository.deleteById(aLong);
    }
}
