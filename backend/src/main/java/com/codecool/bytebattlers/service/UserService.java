package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.config.JwtService;
import com.codecool.bytebattlers.controller.dto.AppUserDto;
import com.codecool.bytebattlers.mapper.AppUserMapper;
import com.codecool.bytebattlers.model.AppUser;
import com.codecool.bytebattlers.model.AuthenticationResponse;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Role;
import com.codecool.bytebattlers.repository.AppUserRepository;
import com.codecool.bytebattlers.repository.BoardGameRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;


import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final PasswordEncoder passwordEncoder;
    private final AppUserRepository userRepository;
    private final AppUserMapper entityMapper;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final UserDetailsService appUserDetailsService;
    private final BoardGameRepository boardGameRepository;

    @Autowired
    public UserService(PasswordEncoder passwordEncoder, AppUserRepository userRepository, AppUserMapper entityMapper, JwtService jwtService, AuthenticationManager authenticationManager, UserDetailsService appUserDetailsService, BoardGameRepository boardGameRepository) {
        this.passwordEncoder = passwordEncoder;
        this.userRepository = userRepository;
        this.entityMapper = entityMapper;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
        this.appUserDetailsService = appUserDetailsService;
        this.boardGameRepository = boardGameRepository;
    }

    public List<AppUserDto> findAll() {
        return userRepository.findAll().stream()
                .map(entityMapper::toDto).toList();
    }

    public List<AppUserDto> findAllByBoardGame(List<String> userIds) {
       return userIds.stream().map(userid -> userRepository.findAppUsersByPublicID(UUID.fromString(userid))).toList().stream()
               .map(entityMapper::toDto).toList();
    }

    public AppUserDto register(AppUserDto userDto) {
        Set<BoardGame> favoritedBoardGames = userDto.favoriteBoardGamePublicIDS().stream().map(boardGameRepository::findBoardGameByPublicID).collect(Collectors.toSet());
        AppUser user = entityMapper.toEntity(userDto);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.USER);
        user.setFavoriteBoardGames(favoritedBoardGames);
        userRepository.save(user);
        return entityMapper.toDto(user);
    }

    public AuthenticationResponse authenticate(AppUserDto appUserDto){
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        appUserDto.email(),
                        appUserDto.password()
                )
        );
        UserDetails user = appUserDetailsService.loadUserByUsername(appUserDto.email());
        AppUser foundUser = userRepository.findByEmail(appUserDto.email())
                .orElseThrow(NoSuchElementException::new);
        var jwtToken = jwtService.generateToken(user, foundUser.getPublicID(), foundUser.getName());
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .build();
    }

    public AppUserDto save(AppUserDto entity) {
       AppUser user = entityMapper.toEntity(entity);
        userRepository.save(user);
        return entityMapper.toDto(user);
    }

    public AppUserDto findById(UUID publicID) {
        return entityMapper.toDto(userRepository.findAppUsersByPublicID(publicID));
    }
    public AppUserDto findByEmail(String email) {
        Optional<AppUser> appUser = userRepository.findByEmail(email);

        if (appUser.isEmpty()) {
            throw new UsernameNotFoundException("User not found!");
        }

        AppUser user = appUser.get();
        return entityMapper.toDto(user);
    }

    public AppUser findByPublicID(UUID uuid) {
        return userRepository.findAppUsersByPublicID(uuid);
    }

    public void deleteById(UUID publicID) {
        userRepository.deleteByPublicID(publicID);
    }

    public AppUserDto update(UUID id, UUID uuid) {
          AppUser user = userRepository.findAppUsersByPublicID(id);
          Set<BoardGame> bg = user.getFavoriteBoardGames();
          BoardGame board = boardGameRepository.findBoardGameByPublicID(uuid);
          bg.add(board);
        user.setFavoriteBoardGames(bg);
        userRepository.save(user);
        return entityMapper.toDto(user);
    }

    public AppUserDto deleteFromFavorites (UUID userID, UUID bgID){
        AppUser user = userRepository.findAppUsersByPublicID(userID);
        Set<BoardGame> bg = user.getFavoriteBoardGames();
        BoardGame board = boardGameRepository.findBoardGameByPublicID(bgID);
        bg.remove(board);
        user.setFavoriteBoardGames(bg);
        userRepository.save(user);
        return entityMapper.toDto(user);
    }
}
