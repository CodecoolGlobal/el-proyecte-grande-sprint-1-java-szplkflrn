package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.VAllBoardGame;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface VAllBoardGameRepository extends JpaRepository<VAllBoardGame, UUID> {

    List<VAllBoardGame> findBoardGamesByGameNameContainingIgnoreCase(String boardGameName);

    List<VAllBoardGame> findVAllBoardGamesByPublisherName(String publisherName);

    List<VAllBoardGame> findVAllBoardGamesByCategoriesContaining(String category);

    List<VAllBoardGame> findVAllBoardGamesByDescriptionContainingIgnoreCase(String description);

    List<VAllBoardGame> findAllByOrderByGameNameAsc();

    List<VAllBoardGame> findAllByOrderByGameNameDesc();

    List<VAllBoardGame> findAllByMaxPlayerLessThanEqual(int max);

    List<VAllBoardGame> findAllByMinPlayerGreaterThanEqual(int min);

    List<VAllBoardGame> findAllByAverageRatingGreaterThanEqual(double rating);


}