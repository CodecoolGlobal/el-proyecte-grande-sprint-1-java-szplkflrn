package com.codecool.bytebattlers.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/")
public class BoardGameController {

    private final BoardGameService boardGameService;

    @Autowired
    public BoardGameController(BoardGameService boardGameService) {
        this.boardGameService = boardGameService;
    }

    @GetMapping("/games")
    public String getAllBoardGame() {
        return "BoardGameService.getAllBoardGames()";
    }

    @GetMapping("/{id}")
    public BoardGame getBoardGameById(@PathVariable int id) {
       return "BoardGameService.getQuestionById(id)";
    }

    @PostMapping("/newGame")
    public int addNewBoardGame(RequestBody BoardGame newBoardGame) {
        return "BoardGameService.addNewBoardGame(newBoardGame)";
    }

    @DeleteMapping("/{id}")
    public boolean deleteGameBoardById(@PathVariable int id) {
        return "BoardGameService.deleteBoardGameById(id)";
    }

}
