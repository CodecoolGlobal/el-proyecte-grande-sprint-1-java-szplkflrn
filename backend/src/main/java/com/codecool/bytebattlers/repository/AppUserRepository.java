package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.AppUser;
import org.apache.catalina.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface AppUserRepository extends JpaRepository<AppUser, Long> {

    AppUser findAppUsersByPublicID(UUID publicID);

    Optional<AppUser> findByEmail(String email);

    void deleteByPublicID(UUID publicID);
}
