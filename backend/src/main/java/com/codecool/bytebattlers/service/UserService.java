package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.config.JwtService;
import com.codecool.bytebattlers.controller.dto.AppUserDto;
import com.codecool.bytebattlers.mapper.AppUserMapper;
import com.codecool.bytebattlers.model.AppUser;
import com.codecool.bytebattlers.model.AuthenticationResponse;
import com.codecool.bytebattlers.model.Role;
import com.codecool.bytebattlers.repository.AppUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final PasswordEncoder passwordEncoder;
    private final AppUserRepository userRepository;
    private final AppUserMapper entityMapper;
    private final JwtService service;
    private final AuthenticationManager authenticationManager;

    @Autowired
    public UserService(PasswordEncoder passwordEncoder, AppUserRepository userRepository, AppUserMapper entityMapper, JwtService service, AuthenticationManager authenticationManager) {
        this.passwordEncoder = passwordEncoder;
        this.userRepository = userRepository;
        this.entityMapper = entityMapper;
        this.service = service;
        this.authenticationManager = authenticationManager;
    }

    public List<AppUserDto> findAll() {
        return userRepository.findAll().stream()
                .map(entityMapper::toDto).toList();
    }

    public List<AppUserDto> findAllByBoardGame(List<String> userids) {
       return userids.stream().map(userid -> userRepository.findAppUsersByPublicID(UUID.fromString(userid))).toList().stream()
               .map(entityMapper::toDto).toList();
    }


    public AppUserDto register(AppUserDto userDto) {
        AppUser user = entityMapper.toEntity(userDto);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.USER);
        userRepository.save(user);
        return entityMapper.toDto(user);
    }

    public AuthenticationResponse authenticate(AppUserDto appUserDto){
        AppUser user = userRepository.findByEmail(appUserDto.email())
                .orElseThrow();


        if(passwordEncoder.matches(appUserDto.password(), user.getPassword())){
            List<SimpleGrantedAuthority> authorities = List.of(new SimpleGrantedAuthority(user.getRole().name()));
            User actualuser = new User(user.getEmail(), user.getPassword(), authorities);
            String pubID = String.valueOf(user.getPublicID());
            var jwtToken = service.generateToken(actualuser,pubID);
            return AuthenticationResponse.builder()
                    .token(jwtToken)
                    .build();
        } else {
            throw new BadCredentialsException("Username/password not matched!");
        }
    }

    public AppUserDto save(AppUserDto entity) {
        userRepository.save(entityMapper.toEntity(entity));
        return entityMapper.toDto(entityMapper.toEntity(entity));
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
}
