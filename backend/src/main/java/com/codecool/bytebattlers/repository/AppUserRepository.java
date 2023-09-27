package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppUserRepository extends JpaRepository<AppUser, Long> {
}