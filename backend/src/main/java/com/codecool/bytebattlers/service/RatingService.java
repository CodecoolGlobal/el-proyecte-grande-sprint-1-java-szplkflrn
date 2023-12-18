package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.RatingDto;
import com.codecool.bytebattlers.mapper.RatingMapper;
import com.codecool.bytebattlers.model.AppUser;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Rating;
import com.codecool.bytebattlers.repository.AppUserRepository;
import com.codecool.bytebattlers.repository.BoardGameRepository;
import com.codecool.bytebattlers.repository.RatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class RatingService {

    private final RatingMapper ratingMapper;

    private final RatingRepository ratingRepository;

    private final BoardGameRepository boardGameRepository;

    private final AppUserRepository appUserRepository;


    @Autowired
    public RatingService(RatingMapper ratingMapper, RatingRepository ratingRepository, BoardGameRepository boardGameRepository, AppUserRepository appUserRepository) {
        this.ratingMapper = ratingMapper;
        this.ratingRepository = ratingRepository;
        this.boardGameRepository = boardGameRepository;
        this.appUserRepository = appUserRepository;
    }

    public List<RatingDto> findAll() {
        return ratingRepository.findAll().stream().map(ratingMapper::toDto).toList();
    }

    public RatingDto save(RatingDto dto) {
        BoardGame boardGame = boardGameRepository.findBoardGameByPublicID(dto.boardGamePublicID());
        AppUser appUser = appUserRepository.findAppUsersByPublicID(dto.appUserPublicID());
        Rating rating = ratingMapper.toEntity(dto);
        rating.setAppUser(appUser);
        rating.setBoardGame(boardGame);
        ratingRepository.save(rating);
        return ratingMapper.toDto(rating);
    }

    public void delete(Rating entity) {
        ratingRepository.delete(entity);
    }

    public List<Rating> findAllRatingsByBoardGame_Id(UUID boardGameId) {
        return ratingRepository.findAllByBoardGame_PublicID(boardGameId);
    }

    public Rating checkIfRatingExist(UUID appUserPublicID, UUID boardGamePublicID) {
        BoardGame boardGame = boardGameRepository.findBoardGameByPublicID(boardGamePublicID);
        AppUser appUser = appUserRepository.findAppUsersByPublicID(appUserPublicID);
        return ratingRepository.findByAppUserAndAndBoardGame(appUser, boardGame);
    }
}
