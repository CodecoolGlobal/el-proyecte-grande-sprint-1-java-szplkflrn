package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface AppUserRepository extends JpaRepository<AppUser, Long> {

    AppUser findAppUsersByPublicID(UUID publicID);
}