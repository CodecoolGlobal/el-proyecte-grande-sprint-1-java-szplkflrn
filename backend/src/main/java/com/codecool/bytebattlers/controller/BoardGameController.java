package com.codecool.bytebattlers.controller;
import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.service.BoardGameService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/games")
public class BoardGameController {


    private final BoardGameService boardGameService;

    private final Logger logger = LoggerFactory.getLogger(BoardGameController.class);

    @Autowired
    public BoardGameController(BoardGameService boardGameService) {
        this.boardGameService = boardGameService;
    }

    @GetMapping
    public List<BoardGameDto> getAllBoardGame() {
        return boardGameService.findAll();
    }

    @GetMapping("/{id}")
    public BoardGameDto getBoardGameById(@PathVariable Long id) {
       return boardGameService.findById(id);
    }

    @PostMapping
    public void addNewBoardGame(@RequestBody BoardGameDto board) {
        try {
            boardGameService.save(board);        }
        catch (Exception e) {
            logger.error("An error occurred during application startup", e);
        }
    }

    @DeleteMapping("/{id}")
    public void deleteBoardGameById(@PathVariable Long id) {
         boardGameService.deleteById(id);
    }

}
