package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.controller.exception.ResourceNotFoundException;
import com.codecool.bytebattlers.service.BoardGameService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

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
    public ResponseEntity<List<BoardGameDto>> getAllCategory() {
        if (boardGameService.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(boardGameService.findAll(), HttpStatus.OK);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<BoardGameDto> getCategoryById(@PathVariable UUID id) {
        if (boardGameService.findByPublicID(id) == null) {
            throw new ResourceNotFoundException("Not found Tutorial with id = " + id);
        } else {
            return new ResponseEntity<>(boardGameService.findByPublicIdToDTO(id), HttpStatus.OK);
        }
    }

    @PostMapping
    public ResponseEntity<BoardGameDto> addNewCategory(@RequestBody BoardGameDto board) {
        return new ResponseEntity<>(boardGameService.save(board), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BoardGameDto> deleteCategoryById(@PathVariable UUID id) {
        boardGameService.deleteById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/api/search")
    @ResponseBody
    public ResponseEntity<List<BoardGameDto>> findBoardGamesByName(@RequestParam String boardGameName) {
        if (boardGameService.findBoardGamesDtoByGameName(boardGameName).isEmpty()) {
            throw new ResourceNotFoundException("No found game");
        } else {
            return new ResponseEntity<>(boardGameService.findBoardGamesDtoByGameName(boardGameName), HttpStatus.OK);
        }
    }

}
