package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.VAllBoardGameDto;
import com.codecool.bytebattlers.mapper.VAllBoardGameMapper;
import com.codecool.bytebattlers.model.VAllBoardGame;
import com.codecool.bytebattlers.repository.VAllBoardGameRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class VAllBoardGameService {

    private final VAllBoardGameRepository vAllBoardGameRepository;
    private final VAllBoardGameMapper vAllBoardGameMapper;

    @Autowired
    public VAllBoardGameService(VAllBoardGameRepository vAllBoardGameRepository, VAllBoardGameMapper vAllBoardGameMapper) {
        this.vAllBoardGameRepository = vAllBoardGameRepository;
        this.vAllBoardGameMapper = vAllBoardGameMapper;
    }

    public List<VAllBoardGameDto> findAll() {
        return vAllBoardGameRepository.findAll().stream().map(vAllBoardGameMapper::toDto).toList();
    }

    public List<VAllBoardGame> findVAllBoardGamesByGameName(String boardGameName) {
        return vAllBoardGameRepository.findBoardGamesByGameNameContainingIgnoreCase(boardGameName);
    }

    public List<VAllBoardGameDto> findVAllBoardGamesDtoByGameName(String boardGameName) {
        List<VAllBoardGame> searchedBoardgames = findVAllBoardGamesByGameName(boardGameName);
        return searchedBoardgames.stream()
                .map(vAllBoardGameMapper::toDto)
                .toList();
    }

    public List<VAllBoardGameDto> findAllBoardGamesByPublisher(String publisherName) {
        return vAllBoardGameRepository.findVAllBoardGamesByPublisherName(publisherName)
                .stream().map(vAllBoardGameMapper::toDto)
                .toList();
    }

    public List<VAllBoardGameDto> findVAllBoardGamesByCategory(String categoryName) {
        return vAllBoardGameRepository.findVAllBoardGamesByCategoriesContaining(categoryName)
                .stream().map(vAllBoardGameMapper::toDto).toList();
    }

    public List<VAllBoardGameDto> findVAllBoardGamesByDescription(String description) {
        return vAllBoardGameRepository.findVAllBoardGamesByDescriptionContainingIgnoreCase(description)
                .stream().map(vAllBoardGameMapper::toDto).toList();
    }

    public List<VAllBoardGameDto> sortByName(String order) {
        if (order.equals("asc")) {
            return vAllBoardGameRepository.findAllByOrderByGameNameAsc()
                    .stream().map(vAllBoardGameMapper::toDto).toList();
        } else if (order.equals("desc")) {
            return vAllBoardGameRepository.findAllByOrderByGameNameDesc()
                    .stream().map(vAllBoardGameMapper::toDto)
                    .toList();
        }
        return Collections.emptyList();
    }

    public List<VAllBoardGameDto> findByLessThanOrEqualsMaxPlayer(int maxPlayer){
        return vAllBoardGameRepository.findAllByMaxPlayerLessThanEqual(maxPlayer)
                .stream().map(vAllBoardGameMapper::toDto)
                .toList();
    }

    public List<VAllBoardGameDto> findByMoreThanOrEqualsMinPlayer(int minPlayer) {
        return vAllBoardGameRepository.findAllByMinPlayerGreaterThanEqual(minPlayer)
                .stream().map(vAllBoardGameMapper::toDto)
                .toList();
    }

    public List<VAllBoardGameDto> findByMoreThanOrEqualRating(double rating) {
        return vAllBoardGameRepository.findAllByAverageRatingGreaterThanEqual(rating)
                .stream().map(vAllBoardGameMapper::toDto)
                .toList();
    }


}
