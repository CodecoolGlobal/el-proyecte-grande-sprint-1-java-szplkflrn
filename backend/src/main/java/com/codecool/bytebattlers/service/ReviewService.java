package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.mapper.ReviewMapper;
import com.codecool.bytebattlers.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class ReviewService {
    private final ReviewMapper reviewMapper;
    private final ReviewRepository reviewRepository;

    @Autowired
    public ReviewService(ReviewMapper reviewMapper, ReviewRepository reviewRepository) {
        this.reviewMapper = reviewMapper;
        this.reviewRepository = reviewRepository;
    }


    public List<ReviewDto> findAll() {
        return reviewRepository.findAll().stream().map(reviewMapper::toDto).collect(Collectors.toList());
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
