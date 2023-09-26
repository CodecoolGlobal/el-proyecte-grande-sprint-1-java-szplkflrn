package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reviews")
public class ReviewController {


    private final ReviewService reviewService;

    @Autowired
    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping("/")
    public List<ReviewDto> getAllReviews() {
        return reviewService.findAll();
    }

    @GetMapping("/{id}")
    public ReviewDto getReviewById(@PathVariable Long id) {
        return reviewService.findById(id);
    }

    @PostMapping("/")
    public void addNewReview(@RequestBody ReviewDto board) {
        reviewService.save(board);
    }

    @DeleteMapping("/{id}")
    public void deleteReviewById(@PathVariable Long id) {
        reviewService.deleteById(id);
    }

}

