package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.RatingDto;
import com.codecool.bytebattlers.mapper.RatingMapper;
import com.codecool.bytebattlers.service.RatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/ratings")
public class RatingController {

    private final RatingService ratingService;
    private final RatingMapper ratingMapper;

    @Autowired
    public RatingController(RatingService ratingService,
                            RatingMapper ratingMapper) {
        this.ratingService = ratingService;
        this.ratingMapper = ratingMapper;
    }

    @GetMapping
    public ResponseEntity<List<RatingDto>> getAllRatings() {
        if (ratingService.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(ratingService.findAll(), HttpStatus.OK);
        }
    }

    @GetMapping("/check-existence")
    public ResponseEntity<RatingDto> checkRating(@RequestParam(name = "appUserPublicID") UUID appUserPublicID,
                                                 @RequestParam(name = "boardGamePublicID") UUID boardGamePublicID) {
        if (ratingService.checkIfRatingExist(appUserPublicID, boardGamePublicID) == null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(ratingMapper.toDto(ratingService.checkIfRatingExist(appUserPublicID, boardGamePublicID)), HttpStatus.OK);
        }
    }

    @PostMapping
    public ResponseEntity<RatingDto> addNewRating(@RequestBody RatingDto rating) {
        return new ResponseEntity<>(ratingService.save(rating), HttpStatus.CREATED);
    }
}
