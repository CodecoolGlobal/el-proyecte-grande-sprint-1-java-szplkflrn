package com.codecool.bytebattlers.controller;
import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.service.BoardGameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class BoardGameController {


    private final BoardGameService boardGameService;
    @Autowired
    public BoardGameController(BoardGameService boardGameService) {
        this.boardGameService = boardGameService;
    }

    @GetMapping("/games")
    public List<BoardGameDto> getAllBoardGame() {
        return boardGameService.findAll();
    }

    @GetMapping("/{id}")
    public BoardGameDto getBoardGameById(@PathVariable Long id) {
       return boardGameService.findById(id);
    }

    @PostMapping("/newGame")
    public void addNewBoardGame(@RequestBody BoardGameDto board) {
        boardGameService.save(board);
    }

    @DeleteMapping("/{id}")
    public void deleteGameBoardById(@PathVariable Long id) {
         boardGameService.deleteById(id);
    }

}
