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

    public void save(ReviewDto reviewDto) {
        BoardGame foundBoardgame = boardGameService.findByPublicID(reviewDto.boardGamePublicID());
        AppUser foundUser =  userService.findByPublicID(reviewDto.appUserPublicID());
        Review review = reviewMapper.toEntity(reviewDto);
        review.setAppUser(foundUser);
        review.setBoardGame(foundBoardgame);
        reviewRepository.save(review);
    }

    public ReviewDto findById(Long aLong) {
        return reviewMapper.toDto(reviewRepository.findById(aLong).orElseThrow(NoSuchElementException::new));
    }

    public void deleteById(Long aLong) {
        reviewRepository.deleteById(aLong);
    }
}
