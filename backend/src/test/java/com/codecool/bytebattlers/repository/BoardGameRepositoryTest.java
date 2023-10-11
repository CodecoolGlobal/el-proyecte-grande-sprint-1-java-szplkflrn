package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Publisher;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
@ActiveProfiles("test")
class BoardGameRepositoryTest {

    @Autowired
    private BoardGameRepository boardGameRepository;

    @Test
    void test_findBoardGamesByGameNameContainingIgnoreCase_ReturnMatchedElements() {

        int expected = 2;

        Publisher publisher = new Publisher();
        publisher.setPublisherName("test");

        BoardGame boardGame1 = new BoardGame();
        boardGame1.setPublisher(publisher);
        boardGame1.setGameName("Game Name 1");
        this.boardGameRepository.save(boardGame1);

        BoardGame boardGame2 = new BoardGame();
        boardGame2.setPublisher(publisher);
        boardGame2.setGameName("Game Name 2");
        this.boardGameRepository.save(boardGame2);

        List<BoardGame> actual =
                this.boardGameRepository.findBoardGamesByGameNameContainingIgnoreCase("name");

        assertEquals(expected, actual.size());
    }
}