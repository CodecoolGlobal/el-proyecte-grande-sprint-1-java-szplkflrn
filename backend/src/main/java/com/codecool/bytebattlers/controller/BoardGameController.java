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

    @PostMapping("/create")
    public ResponseEntity<BoardGameDto> addNewCategory(@RequestBody BoardGameDto board) {
        return new ResponseEntity<>(boardGameService.save(board), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BoardGameDto> deleteCategoryById(@PathVariable UUID id) {
        boardGameService.deleteById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/search")
    @ResponseBody
    public ResponseEntity<List<BoardGameDto>> findBoardGamesByName(@RequestParam String boardGameName) {
        if (boardGameService.findBoardGamesDtoByGameName(boardGameName).isEmpty()) {
            throw new ResourceNotFoundException("No found game");
        } else {
            return new ResponseEntity<>(boardGameService.findBoardGamesDtoByGameName(boardGameName), HttpStatus.OK);
        }
    }
    @GetMapping("/publisher")
    @ResponseBody
    public ResponseEntity<List<BoardGameDto>> findBoardGamesByPublisher(@RequestParam UUID publicID) {
        if (boardGameService.findBoardGamesByPublisherPublicID(publicID).isEmpty()) {
            throw new ResourceNotFoundException("No found game");
        } else {
            return new ResponseEntity<>(boardGameService.findBoardGamesByPublisherPublicID(publicID), HttpStatus.OK);
        }
    }

    @GetMapping("/category")
    @ResponseBody
    public ResponseEntity<List<BoardGameDto>> findBoardGamesByCategory(@RequestParam UUID publicID) {
        if (boardGameService.findBoardGamesByCategory(publicID).isEmpty()) {
            throw new ResourceNotFoundException("No found game");
        } else {
            return new ResponseEntity<>(boardGameService.findBoardGamesByCategory(publicID), HttpStatus.OK);
        }
    }

    @GetMapping("/sort")
    @ResponseBody
    public ResponseEntity<List<BoardGameDto>> sortBy(@RequestParam String sort) {
        if (boardGameService.sortByName(sort).isEmpty()) {
            throw new ResourceNotFoundException("No found game");
        } else {
            return new ResponseEntity<>(boardGameService.sortByName(sort), HttpStatus.OK);
        }
    }

    @GetMapping("/description")
    @ResponseBody
    public ResponseEntity<List<BoardGameDto>> findBoardGamesByDescription(@RequestParam String desc) {
        if (boardGameService.findBoardGamesByDescription(desc).isEmpty()) {
            throw new ResourceNotFoundException("No found game");
        } else {
            return new ResponseEntity<>(boardGameService.findBoardGamesByDescription(desc), HttpStatus.OK);
        }
    }

    @GetMapping("/maxplayer")
    @ResponseBody
    public ResponseEntity<List<BoardGameDto>> findAllBoardGamesLesserThanOrEqualsByMaxPlayer(@RequestParam int max) {
        if (boardGameService.findByLessThanOrEqualsMaxPlayer(max).isEmpty()) {
            throw new ResourceNotFoundException("No found game");
        } else {
            return new ResponseEntity<>(boardGameService.findByLessThanOrEqualsMaxPlayer(max), HttpStatus.OK);
        }
    }

    @GetMapping("/minplayer")
    @ResponseBody
    public ResponseEntity<List<BoardGameDto>> findAllBoardGamesGreaterThanOrEqualsByMinPlayer(@RequestParam int min) {
        if (boardGameService.findByMoreThanOrEqualsMinPlayer(min).isEmpty()) {
            throw new ResourceNotFoundException("No found game");
        } else {
            return new ResponseEntity<>(boardGameService.findByMoreThanOrEqualsMinPlayer(min), HttpStatus.OK);
        }
    }

    @GetMapping("/rating")
    @ResponseBody
    public ResponseEntity<List<BoardGameDto>> findAllBoardGamesGreaterThanOrEqualsByMinPlayer(@RequestParam double rating) {
        if (boardGameService.findByMoreThanOrEqualsRating(rating).isEmpty()) {
            throw new ResourceNotFoundException("No found game");
        } else {
            return new ResponseEntity<>(boardGameService.findByMoreThanOrEqualsRating(rating), HttpStatus.OK);
        }
    }




}
