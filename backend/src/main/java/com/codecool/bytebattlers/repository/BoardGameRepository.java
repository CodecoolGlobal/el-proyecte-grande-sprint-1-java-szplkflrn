package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Category;
import com.codecool.bytebattlers.model.Publisher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface BoardGameRepository extends JpaRepository<BoardGame, Long> {

    BoardGame findBoardGameByPublicID(UUID publicID);

    void deleteByPublicID(UUID publicID);

    List<BoardGame> findBoardGamesByGameNameContainingIgnoreCase(String boardGameName);

    List<BoardGame> findBoardGamesByPublisher(Publisher publicID);

    List<BoardGame> findBoardGamesByCategoriesContaining(Category publicID);

    List<BoardGame> findBoardGamesByDescriptionContainsIgnoreCase(String description);

    List<BoardGame> findAllByOrderByGameNameAsc();

    List<BoardGame> findAllByOrderByGameNameDesc();

    List<BoardGame> findAllByMaxPlayerLessThanEqual(int max);

    List<BoardGame> findAllByMinPlayerGreaterThanEqual(int min);

}
