package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.AppUser;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Rating;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface RatingRepository extends JpaRepository<Rating, Long> {

    List<Rating> findAllByBoardGame_PublicID(UUID boardGameId);

    Rating findByAppUserAndAndBoardGame(AppUser appUser, BoardGame boardGame);
}