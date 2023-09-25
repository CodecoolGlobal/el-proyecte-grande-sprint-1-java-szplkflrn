package com.codecool.bytebattlers.dao;

import com.codecool.bytebattlers.model.BoardGame;

import java.util.List;

public interface BoardGameDAO {
    List<BoardGame> getAllBoardGames();
    BoardGame getBoardGameById(int id);
    int addNewBoardGame(BoardGame boardGame);
    boolean deleteBoardGame(int id);
}
