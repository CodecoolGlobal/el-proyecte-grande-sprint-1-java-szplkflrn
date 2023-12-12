package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.controller.exception.ResourceNotFoundException;
import com.codecool.bytebattlers.mapper.BoardGameMapper;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.service.BoardGameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/games")
public class BoardGameController {

    private static final String ERROR_MESSAGE = "No found game";


    private final BoardGameService boardGameService;

    private final BoardGameMapper boardGameMapper;

    @Autowired
    public BoardGameController(BoardGameService boardGameService,
                               BoardGameMapper boardGameMapper) {
        this.boardGameService = boardGameService;
        this.boardGameMapper = boardGameMapper;
    }

    @GetMapping
    public ResponseEntity<List<BoardGameDto>> getAllBoardGame() {
        if (boardGameService.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(boardGameService.findAll(), HttpStatus.OK);
        }
    }

    @PostMapping("/myfavorites")
    public ResponseEntity<List<BoardGameDto>> getFavoriteBoardGamesByUser(@RequestBody List<UUID> uuids) {
       List<BoardGame> favBoardGames = uuids.stream().map(boardGameService::findByPublicID).toList();
       List<BoardGameDto> bgDtos = favBoardGames.stream().map(boardGameMapper::toDto).toList();
        return new ResponseEntity<>(bgDtos, HttpStatus.OK);
    }


    @GetMapping("/{id}")
    public ResponseEntity<BoardGameDto> getBoardGameById(@PathVariable UUID id) {
        if (boardGameService.findByPublicID(id) == null) {
            throw new ResourceNotFoundException("Not found Tutorial with id = " + id);
        } else {
            return new ResponseEntity<>(boardGameService.findByPublicIdToDTO(id), HttpStatus.OK);
        }
    }

    @PostMapping("/create")
    public ResponseEntity<BoardGameDto> addNewBoardGame(@RequestBody BoardGameDto board) {
        return new ResponseEntity<>(boardGameService.save(board), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BoardGameDto> deleteBoardGameById(@PathVariable UUID id) {
        boardGameService.deleteById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/search")
    public ResponseEntity<List<BoardGameDto>> findBoardGamesByName(@RequestParam String boardGameName) {
        if (boardGameService.findBoardGamesDtoByGameName(boardGameName).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(boardGameService.findBoardGamesDtoByGameName(boardGameName), HttpStatus.OK);
        }
    }
    @GetMapping("/publisher")
    public ResponseEntity<List<BoardGameDto>> findBoardGamesByPublisher(@RequestParam UUID publicID) {
        if (boardGameService.findBoardGamesByPublisherPublicID(publicID).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(boardGameService.findBoardGamesByPublisherPublicID(publicID), HttpStatus.OK);
        }
    }

    @GetMapping("/category")
    public ResponseEntity<List<BoardGameDto>> findBoardGamesByCategory(@RequestParam UUID publicID) {
        if (boardGameService.findBoardGamesByCategory(publicID).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(boardGameService.findBoardGamesByCategory(publicID), HttpStatus.OK);
        }
    }

    @GetMapping("/sort")
    public ResponseEntity<List<BoardGameDto>> sortBy(@RequestParam String sort) {
        if (boardGameService.sortByName(sort).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(boardGameService.sortByName(sort), HttpStatus.OK);
        }
    }

    @GetMapping("/description")
    public ResponseEntity<List<BoardGameDto>> findBoardGamesByDescription(@RequestParam String desc) {
        if (boardGameService.findBoardGamesByDescription(desc).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(boardGameService.findBoardGamesByDescription(desc), HttpStatus.OK);
        }
    }

    @GetMapping("/maxplayer")
    public ResponseEntity<List<BoardGameDto>> findAllBoardGamesLesserThanOrEqualsByMaxPlayer(@RequestParam int max) {
        if (boardGameService.findByLessThanOrEqualsMaxPlayer(max).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(boardGameService.findByLessThanOrEqualsMaxPlayer(max), HttpStatus.OK);
        }
    }

    @GetMapping("/minplayer")
    public ResponseEntity<List<BoardGameDto>> findAllBoardGamesGreaterThanOrEqualsByMinPlayer(@RequestParam int min) {
        if (boardGameService.findByMoreThanOrEqualsMinPlayer(min).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(boardGameService.findByMoreThanOrEqualsMinPlayer(min), HttpStatus.OK);
        }
    }
}
