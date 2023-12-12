package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.RatingDto;
import com.codecool.bytebattlers.service.RatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/ratings")
public class RatingController {

    private final RatingService ratingService;

    @Autowired
    public RatingController(RatingService ratingService) {
        this.ratingService = ratingService;
    }

    @GetMapping
    public ResponseEntity<List<RatingDto>> getAllRatings() {
        if (ratingService.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(ratingService.findAll(), HttpStatus.OK);
        }
    }

    @PostMapping
    public ResponseEntity<RatingDto> addNewRating(@RequestBody RatingDto rating) {
        return new ResponseEntity<>(ratingService.save(rating), HttpStatus.CREATED);
    }
}
