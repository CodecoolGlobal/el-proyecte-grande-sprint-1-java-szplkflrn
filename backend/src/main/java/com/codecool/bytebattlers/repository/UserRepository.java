package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
}