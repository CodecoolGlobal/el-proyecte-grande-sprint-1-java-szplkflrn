package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.BoardGame;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardGameRepository extends JpaRepository<BoardGame, Long> {
}