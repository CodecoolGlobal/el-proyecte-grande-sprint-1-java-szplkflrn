package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.mapper.AppUserMapper;
import com.codecool.bytebattlers.mapper.ReviewMapper;
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


    @Autowired
    public ReviewService(ReviewMapper reviewMapper, ReviewRepository reviewRepository, UserService userService,
                         AppUserMapper userMapper) {
        this.reviewMapper = reviewMapper;
        this.reviewRepository = reviewRepository;
        this.userService = userService;
        this.userMapper = userMapper;
    }


    public List<ReviewDto> findAll() {
        return reviewRepository.findAll().stream().map(reviewMapper::toDto).toList();
    }

    public void save(ReviewDto reviewDto) {
        reviewRepository.save(reviewMapper.toEntity(reviewDto));
    }

    public ReviewDto findById(Long aLong) {
        return reviewMapper.toDto(reviewRepository.findById(aLong).orElseThrow(NoSuchElementException::new));
    }

    public void deleteById(Long aLong) {
        reviewRepository.deleteById(aLong);
    }
}
