package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.VAllBoardGameDto;
import com.codecool.bytebattlers.service.VAllBoardGameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/all")
public class VAllBoardGameController {

    private final VAllBoardGameService vAllBoardGameService;

    @Autowired
    public VAllBoardGameController(VAllBoardGameService vAllBoardGameService) {
        this.vAllBoardGameService = vAllBoardGameService;
    }

    @GetMapping
    public ResponseEntity<List<VAllBoardGameDto>> getAllGames() {
        if (vAllBoardGameService.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(vAllBoardGameService.findAll(), HttpStatus.OK);
        }
    }
}
