package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.mapper.ReviewMapper;
import com.codecool.bytebattlers.model.AppUser;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Review;
import com.codecool.bytebattlers.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class ReviewService {
    private final ReviewMapper reviewMapper;
    private final ReviewRepository reviewRepository;
    private final UserService userService;
    private final BoardGameService boardGameService;


    @Autowired
    public ReviewService(ReviewMapper reviewMapper, ReviewRepository reviewRepository, UserService userService, BoardGameService boardGameService) {
        this.reviewMapper = reviewMapper;
        this.reviewRepository = reviewRepository;
        this.userService = userService;
        this.boardGameService = boardGameService;
    }


    public List<ReviewDto> findAll() {
        return reviewRepository.findAll().stream().map(reviewMapper::toDto).toList();
    }

    public List<ReviewDto> findAllReviewsByBoardGame(UUID id){
        BoardGame foundBoardgame = boardGameService.findByPublicID(id);
        Set<Review> foundBoardGameReviews = foundBoardgame.getReviews();
         return foundBoardGameReviews.stream().map(reviewMapper::toDto).toList();
    }

    public ReviewDto save(ReviewDto reviewDto) {
        BoardGame foundBoardgame = boardGameService.findByPublicID(reviewDto.boardGamePublicID());
        Set<Review> foundBoardGameReviews = foundBoardgame.getReviews();
        AppUser foundUser = userService.findByPublicID(reviewDto.appUserPublicID());
        Review review = reviewMapper.toEntity(reviewDto);
        foundBoardGameReviews.add(review);
        foundBoardgame.setReviews(foundBoardGameReviews);
        review.setAppUser(foundUser);
        review.setBoardGame(foundBoardgame);
        reviewRepository.save(review);
        return reviewMapper.toDto(review);
    }

    public void deleteById(UUID publicID) {
        reviewRepository.deleteByPublicID(publicID);
    }
}
