package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.dao.model.BoardGame;
import com.codecool.bytebattlers.service.BoardGameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/")
public class BoardGameController {

    private final BoardGameService boardGameService;

    @Autowired
    public BoardGameController(BoardGameService boardGameService) {
        this.boardGameService = boardGameService;
    }

    @GetMapping("/games")
    public List<BoardGame> getAllBoardGame() {
        return BoardGameService.getAllBoardGames();
    }

    @GetMapping("/{id}")
    public BoardGame getBoardGameById(@PathVariable int id) {
       return BoardGameService.getBoardGameById(id);
    }

    @PostMapping("/newGame")
    public int addNewBoardGame(RequestBody BoardGame boardGame) {
        return BoardGameService.addNewBoardGame(boardGame);
    }

    @DeleteMapping("/{id}")
    public boolean deleteGameBoardById(@PathVariable int id) {
        return BoardGameService.deleteBoardGame(id);
    }

}
