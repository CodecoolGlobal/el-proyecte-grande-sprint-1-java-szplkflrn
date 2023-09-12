package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.dao.model.BoardGame;
import com.codecool.bytebattlers.dao.model.DAO.BoardGameDAO;
import org.springframework.aop.target.LazyInitTargetSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardGameService {

    private BoardGameDAO boardGameDAO;

    @Autowired
    public BoardGameService(BoardGameDAO boardGameDAO) {
        this.boardGameDAO = boardGameDAO;
    }

    public List<BoardGame> getAllBoardGames() {
        return BoardGameDAO.getAllBoardGames();
    }

    public BoardGame getBoardGameById(int id){
        return BoardGameDAO.getBoardGameById(id);
    }

    public int addNewBoardGame(BoardGame boardGame) {
        return BoardGameDAO.addNewBoardGame(boardGame);
    }

    public boolean deleteBoardGame(int id) {
        return BoardGameDAO.deleteBoardGame(id);
    }
}

