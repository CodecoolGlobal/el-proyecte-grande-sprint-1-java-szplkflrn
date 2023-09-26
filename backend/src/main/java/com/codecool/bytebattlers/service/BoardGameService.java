package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.service.storage.BoardGameStorage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
public class BoardGameService {

    private BoardGameStorage storage;

    @Autowired
    public BoardGameService(BoardGameStorage storage) {
        this.storage = storage;
    }

    public Set<BoardGame> getAllBoardGames() {
        return storage.getAllGame();
    }

    public BoardGame getBoardGameById(int id){
        return storage.getBoardGame(id);
    }

    public int addNewBoardGame(BoardGame boardGame) {
        storage.addBoardGame(boardGame);
        return boardGame.id();
    }

    public void deleteBoardGame(int id) {
         storage.removeGameById(id);
    }
}

