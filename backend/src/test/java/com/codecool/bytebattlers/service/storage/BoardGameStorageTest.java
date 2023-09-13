package com.codecool.bytebattlers.service.storage;

import com.codecool.bytebattlers.dao.model.BoardGame;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.NoSuchElementException;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

class BoardGameStorageTest {

    private BoardGameStorage storage;

    @BeforeEach
    void setUp() {
        this.storage = new BoardGameStorage();
    }

    @Test
    void test_addBoardGame_ReturnCorrectSize() {
        // Arrange
        int expected = 2;
        BoardGame game1 = new BoardGame(
                1, "A", 1, 2, 20,
                10, "aa", 2, 1, 1);
        BoardGame game2 = new BoardGame(
                2, "B", 2, 4, 300,
                18, "bb", 5, 2, 2);

        // Act
        this.storage.addBoardGame(game1);
        this.storage.addBoardGame(game2);
        int actual = this.storage.getAllGame().size();

        // Assert
        assertEquals(expected, actual);
    }

    @Test
    void test_addBoardGame_addSameGame() {
        // Arrange
        int expected = 1;
        BoardGame game1 = new BoardGame(
                1, "A", 1, 2, 20,
                10, "aa", 2, 1, 1);
        BoardGame game2 = new BoardGame(
                1, "A", 1, 2, 20,
                10, "aa", 2, 1, 1);

        // Act
        this.storage.addBoardGame(game1);
        this.storage.addBoardGame(game2);
        int actual = this.storage.getAllGame().size();

        // Assert
        assertEquals(expected, actual);
    }

    @Test
    void test_getBoardGame_withExistingId() {
        // Arrange
        BoardGame expectedGame = new BoardGame(
                1, "A", 1, 2, 20,
                10, "aa", 2, 1, 1);

        // Act
        this.storage.addBoardGame(expectedGame);
        BoardGame actualGame = this.storage.getBoardGame(1);

        // Assert
        assertEquals(expectedGame, actualGame);
    }

    @Test
    void test_getBoardGame_withNonExistingId() {
        // Assert
        assertThrows(NoSuchElementException.class, () -> {
            this.storage.getBoardGame(1);
        });
    }
}