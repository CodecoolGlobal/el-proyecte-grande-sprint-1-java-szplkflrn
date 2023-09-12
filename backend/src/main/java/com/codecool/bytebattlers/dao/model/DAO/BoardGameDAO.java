package com.codecool.bytebattlers.dao.model.DAO;

import com.codecool.bytebattlers.dao.model.BoardGame;

import java.util.List;

public interface BoardGameDAO {
    List<BoardGame> getAllBoardGames();
    BoardGame getBoardGameById(int id);
    int addNewBoardGame(BoardGame boardGame);
    boolean deleteBoardGame(int id);
}
