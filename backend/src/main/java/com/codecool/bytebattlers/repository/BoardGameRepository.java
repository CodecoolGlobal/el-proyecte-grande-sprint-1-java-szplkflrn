package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.BoardGame;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BoardGameRepository extends JpaRepository<BoardGame, Long> {
    @Query("SELECT bg FROM BoardGame bg LEFT JOIN FETCH bg.reviews")
    List<BoardGame> findBoardGamesByReviews();

}