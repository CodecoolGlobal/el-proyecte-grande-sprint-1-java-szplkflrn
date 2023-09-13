package com.codecool.bytebattlers.controller;
import com.codecool.bytebattlers.dao.model.BoardGame;
import com.codecool.bytebattlers.service.BoardGameService;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

@RestController
@RequestMapping("/")
public class BoardGameController {

    private final BoardGameService boardGameService;

    public BoardGameController(BoardGameService boardGameService) {
        this.boardGameService = boardGameService;
    }

    @GetMapping("/games")
    public Set<BoardGame> getAllBoardGame() {
        return boardGameService.getAllBoardGames();
    }

    @GetMapping("/{id}")
    public BoardGame getBoardGameById(@PathVariable int id) {
       return boardGameService.getBoardGameById(id);
    }

    @PostMapping("/newGame")
    public int addNewBoardGame(@RequestBody BoardGame boardGame) {
        return boardGameService.addNewBoardGame(boardGame);
    }

    @DeleteMapping("/{id}")
    public void deleteGameBoardById(@PathVariable int id) {
         boardGameService.deleteBoardGame(id);
    }

}
