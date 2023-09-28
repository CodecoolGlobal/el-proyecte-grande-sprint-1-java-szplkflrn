package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.controller.exception.ResourceNotFoundException;
import com.codecool.bytebattlers.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/reviews")
public class ReviewController {


    private final ReviewService reviewService;

    @Autowired
    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping
    public ResponseEntity<List<ReviewDto>> getAllCategory() {
        if (reviewService.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(reviewService.findAll(), HttpStatus.OK);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<ReviewDto> getCategoryById(@PathVariable UUID id) {
        if (reviewService.findById(id) == null) {
            throw new ResourceNotFoundException("Not found Tutorial with id = " + id);
        } else {
            return new ResponseEntity<>(reviewService.findById(id), HttpStatus.OK);
        }
    }
    @PostMapping
    public ResponseEntity<ReviewDto>  addNewCategory(@RequestBody ReviewDto board) {
        return new ResponseEntity<>(reviewService.save(board), HttpStatus.CREATED);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<ReviewDto> deleteCategoryById(@PathVariable UUID id) {
        reviewService.deleteById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}


