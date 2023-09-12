package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.dao.model.BoardGame;
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

    public void addNewBoardGame(BoardGame boardGame) {
        storage.addBoardGame(boardGame);
    }

    public boolean deleteBoardGame(int id) {
        return storage.removeGameById(id);
    }
}

