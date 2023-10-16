package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface AppUserRepository extends JpaRepository<AppUser, Long> {

    AppUser findAppUsersByPublicID(UUID publicID);

    Optional<AppUser> findByEmail(String email);

    void deleteByPublicID(UUID publicID);
}
