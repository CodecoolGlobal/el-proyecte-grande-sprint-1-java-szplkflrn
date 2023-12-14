package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.VAllBoardGameDto;
import com.codecool.bytebattlers.controller.exception.ResourceNotFoundException;
import com.codecool.bytebattlers.service.VAllBoardGameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/all")
public class VAllBoardGameController {

    private static final String ERROR_MESSAGE = "No found game";

    private final VAllBoardGameService vAllBoardGameService;

    @Autowired
    public VAllBoardGameController(VAllBoardGameService vAllBoardGameService) {
        this.vAllBoardGameService = vAllBoardGameService;
    }

    @GetMapping
    public ResponseEntity<List<VAllBoardGameDto>> getAllVGames() {
        if (vAllBoardGameService.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.findAll(), HttpStatus.OK);
        }
    }

    @GetMapping("/search")
    public ResponseEntity<List<VAllBoardGameDto>> findVAllBoardGamesByName(@RequestParam String boardGameName) {
        if (vAllBoardGameService.findVAllBoardGamesDtoByGameName(boardGameName).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.findVAllBoardGamesDtoByGameName(boardGameName), HttpStatus.OK);
        }
    }

    @GetMapping("/publisher")
    public ResponseEntity<List<VAllBoardGameDto>> findVAllBoardGamesByPublisher(@RequestParam String publisherName) {
        if (vAllBoardGameService.findAllBoardGamesByPublisher(publisherName).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.findAllBoardGamesByPublisher(publisherName), HttpStatus.OK);
        }
    }

    @GetMapping("/category")
    public ResponseEntity<List<VAllBoardGameDto>> findVAllBoardGamesByCategory(@RequestParam String category) {
        if (vAllBoardGameService.findVAllBoardGamesByCategory(category).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.findVAllBoardGamesByCategory(category), HttpStatus.OK);
        }
    }

    @GetMapping("/sort")
    public ResponseEntity<List<VAllBoardGameDto>> sortBy(@RequestParam String sort) {
        if (vAllBoardGameService.sortByName(sort).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.sortByName(sort), HttpStatus.OK);
        }
    }

    @GetMapping("/description")
    public ResponseEntity<List<VAllBoardGameDto>> findAllBoardGamesByDescription(@RequestParam String desc) {
        if (vAllBoardGameService.findVAllBoardGamesByDescription(desc).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.findVAllBoardGamesByDescription(desc), HttpStatus.OK);
        }
    }

    @GetMapping("/maxplayer")
    public ResponseEntity<List<VAllBoardGameDto>> findAllBoardGamesLesserThanOrEqualsByMaxPlayer(@RequestParam int max) {
        if (vAllBoardGameService.findByLessThanOrEqualsMaxPlayer(max).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.findByLessThanOrEqualsMaxPlayer(max), HttpStatus.OK);
        }
    }

    @GetMapping("/minplayer")
    public ResponseEntity<List<VAllBoardGameDto>> findAllBoardGamesGreaterThanOrEqualsByMinPlayer(@RequestParam int min) {
        if (vAllBoardGameService.findByMoreThanOrEqualsMinPlayer(min).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.findByMoreThanOrEqualsMinPlayer(min), HttpStatus.OK);
        }
    }

    @GetMapping("/rating")
    public ResponseEntity<List<VAllBoardGameDto>> findAllBoardGamesGreaterThanOrEqualsByRating(@RequestParam double rating) {
        if (vAllBoardGameService.findByMoreThanOrEqualRating(rating).isEmpty()) {
            throw new ResourceNotFoundException(ERROR_MESSAGE);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.findByMoreThanOrEqualRating(rating), HttpStatus.OK);
        }
    }
}
