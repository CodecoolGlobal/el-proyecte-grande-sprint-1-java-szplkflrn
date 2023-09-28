package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.mapper.AppUserMapper;
import com.codecool.bytebattlers.mapper.BoardGameMapper;
import com.codecool.bytebattlers.mapper.ReviewMapper;
import com.codecool.bytebattlers.model.AppUser;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Review;
import com.codecool.bytebattlers.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.UUID;

@Service
public class ReviewService {
    private final ReviewMapper reviewMapper;
    private final ReviewRepository reviewRepository;

    private final UserService userService;
    private final AppUserMapper userMapper;

    private final BoardGameService boardGameService;
    private final BoardGameMapper boardGameMapper;



    @Autowired
    public ReviewService(ReviewMapper reviewMapper, ReviewRepository reviewRepository, UserService userService,
                         AppUserMapper userMapper, BoardGameService boardGameService, BoardGameMapper boardGameMapper) {
        this.reviewMapper = reviewMapper;
        this.reviewRepository = reviewRepository;
        this.userService = userService;
        this.userMapper = userMapper;
        this.boardGameService = boardGameService;
        this.boardGameMapper = boardGameMapper;
    }


    public List<ReviewDto> findAll() {
        return reviewRepository.findAll().stream().map(reviewMapper::toDto).toList();
    }

    public ReviewDto save(ReviewDto reviewDto) {
        BoardGame foundBoardgame = boardGameService.findByPublicID(reviewDto.boardGamePublicID());
        Set<Review> foundBoardGameReviews = foundBoardgame.getReviews();
        AppUser foundUser =  userService.findByPublicID(reviewDto.appUserPublicID());
        Review review = reviewMapper.toEntity(reviewDto);
        foundBoardGameReviews.add(review);
        foundBoardgame.setReviews(foundBoardGameReviews);
        review.setAppUser(foundUser);
        review.setBoardGame(foundBoardgame);
        reviewRepository.save(review);
        return reviewMapper.toDto(review);
    }

    public ReviewDto findById(UUID uuid) {
        return reviewMapper.toDto(reviewRepository.findByPublicID(uuid));
    }

    public void deleteById(UUID publicID) {
        reviewRepository.deleteByPublicID(publicID);
    }
}
