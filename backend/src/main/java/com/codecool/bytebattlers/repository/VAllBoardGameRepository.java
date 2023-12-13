package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.VAllBoardGame;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface VAllBoardGameRepository extends JpaRepository<VAllBoardGame, UUID> {
}