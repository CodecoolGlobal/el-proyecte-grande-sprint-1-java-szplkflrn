package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.AppUserDto;
import com.codecool.bytebattlers.mapper.AppUserMapper;
import com.codecool.bytebattlers.model.AppUser;
import com.codecool.bytebattlers.repository.AppUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.UUID;

@Service
public class UserService {

    private final AppUserRepository userRepository;
    private final AppUserMapper entityMapper;

    @Autowired
    public UserService(AppUserRepository userRepository, AppUserMapper entityMapper) {
        this.userRepository = userRepository;
        this.entityMapper = entityMapper;
    }

    public List<AppUserDto> findAll() {
        return userRepository.findAll().stream()
                .map(entityMapper::toDto).toList();
    }


    public AppUserDto save(AppUserDto entity) {
        userRepository.save(entityMapper.toEntity(entity));
        return entityMapper.toDto(entityMapper.toEntity(entity));
    }

    public AppUserDto findById(UUID publicID) {
        return entityMapper.toDto(userRepository.findAppUsersByPublicID(publicID));
    }

    public AppUser findByPublicID(UUID uuid) {
        return userRepository.findAppUsersByPublicID(uuid);
    }

    public void deleteById(UUID publicID) {
        userRepository.deleteByPublicID(publicID);
    }
}
