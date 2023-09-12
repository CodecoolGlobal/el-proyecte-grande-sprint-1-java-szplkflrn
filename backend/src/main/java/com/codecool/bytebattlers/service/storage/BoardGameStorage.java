package com.codecool.bytebattlers.service.storage;

import com.codecool.bytebattlers.dao.model.BoardGame;

import java.util.HashSet;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.Set;

public class BoardGameStorage {

    private final Set<BoardGame> boardGames;

    public BoardGameStorage() {
        this.boardGames = new HashSet<>();
    }

    public void addBoardGame(BoardGame game) {
        this.boardGames.add(game);
    }

    private Optional<BoardGame> getGameById(Integer id) {
        return this.boardGames.stream()
                .filter(boardGame -> boardGame.id().equals(id))
                .findFirst();
    }

    public BoardGame getBoardGame(Integer id) {
        Optional<BoardGame> game = getGameById(id);
        return game.orElseThrow(NoSuchElementException::new);
    }

    public void removeGameById(Integer id) {
        BoardGame game = getGameById(id).orElseThrow(NoSuchElementException::new);
        this.boardGames.remove(game);
    }

    public Set<BoardGame> getAllGame() {
        return Set.copyOf(this.boardGames);
    }
}
