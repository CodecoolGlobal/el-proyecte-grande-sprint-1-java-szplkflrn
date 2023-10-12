package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.mapper.BoardGameMapper;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Category;
import com.codecool.bytebattlers.model.Publisher;
import com.codecool.bytebattlers.repository.BoardGameRepository;
import com.codecool.bytebattlers.repository.CategoryRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class BoardGameService {

    private final BoardGameRepository boardGameRepository;
    private final PublisherService publisherService;
    private final BoardGameMapper boardGameMapper;
    private final CategoryRepository categoryRepository;

    @Autowired
    public BoardGameService(
            BoardGameRepository boardGameRepository,
            PublisherService publisherService,
            BoardGameMapper boardGameMapper,
            CategoryRepository categoryRepository) {
        this.boardGameRepository = boardGameRepository;
        this.publisherService = publisherService;
        this.boardGameMapper = boardGameMapper;
        this.categoryRepository = categoryRepository;
    }


    public List<BoardGameDto> findAll() {
        return boardGameRepository.findAll().stream().map(boardGameMapper::toDto).toList();
    }

    public BoardGameDto save(BoardGameDto dto) {
        Set<BoardGameDto.CategoryDto1> categoriesInDTO = dto.categories();
        Set<Category> categoriesInEntity = categoriesInDTO
                .stream().map(categoryDto -> categoryRepository.findCategoryByPublicID(categoryDto.publicID()))
                .collect(Collectors.toSet());
        Publisher foundPublisher = publisherService.findByPublicId(dto.publisherPublicID());
        BoardGame boardGame = boardGameMapper.toEntity(dto);
        boardGame.setCategories(categoriesInEntity);
        boardGame.setPublisher(foundPublisher);
        boardGameRepository.save(boardGame);
        return boardGameMapper.toDto(boardGame);
    }

    public BoardGame findByPublicID(UUID publicID) {
        return boardGameRepository.findBoardGameByPublicID(publicID);
    }

    public BoardGameDto findByPublicIdToDTO(UUID publicID) {
        return boardGameMapper.toDto(boardGameRepository.findBoardGameByPublicID(publicID));
    }

    public void deleteById(UUID publicID) {
        boardGameRepository.deleteByPublicID(publicID);
    }

    public List<BoardGame> findBoardGamesByGameName(String boardGameName) {
        return boardGameRepository.findBoardGamesByGameNameContainingIgnoreCase(boardGameName);
    }

    public List<BoardGameDto> findBoardGamesDtoByGameName(String boardGameName) {
        List<BoardGame> searchedBoardgames = findBoardGamesByGameName(boardGameName);
        return searchedBoardgames.stream()
                .map(boardGameMapper::toDto)
                .toList();
    }

    public List<BoardGameDto> findBoardGamesByPublisherPublicID(UUID publisherID) {
        Publisher foundPublisher = publisherService.findByPublicId(publisherID);
        return boardGameRepository.findBoardGamesByPublisher(foundPublisher)
                .stream().map(boardGameMapper::toDto)
                .toList();
    }

    public List<BoardGameDto> findBoardGamesByCategory(UUID publicId) {
        Category foundCategory = categoryRepository.findCategoryByPublicID(publicId);
        return boardGameRepository.findBoardGamesByCategoriesContaining(foundCategory)
                .stream().map(boardGameMapper::toDto).toList();
    }

    public List<BoardGameDto> findBoardGamesByDescription(String description) {
        return boardGameRepository.findBoardGamesByDescriptionContainsIgnoreCase(description)
                .stream().map(boardGameMapper::toDto).toList();
    }

    public List<BoardGameDto> sortByName(String order) {
        if (order.equals("asc")) {
            return boardGameRepository.findAllByOrderByGameNameAsc()
                    .stream().map(boardGameMapper::toDto).toList();
        } else if (order.equals("desc")) {
            return boardGameRepository.findAllByOrderByGameNameDesc()
                    .stream().map(boardGameMapper::toDto)
                    .toList();
        }
        return Collections.emptyList();
    }

    public List<BoardGameDto> findByLessThanOrEqualsMaxPlayer(int maxPlayer){
       return boardGameRepository.findAllByMaxPlayerLessThanEqual(maxPlayer)
               .stream().map(boardGameMapper::toDto)
               .toList();
    }

    public List<BoardGameDto> findByMoreThanOrEqualsMinPlayer(int minPlayer) {
        return boardGameRepository.findAllByMinPlayerGreaterThanEqual(minPlayer)
                .stream().map(boardGameMapper::toDto)
                .toList();
    }

    public List<BoardGameDto> findByMoreThanOrEqualsRating(double rating) {
        return boardGameRepository.findBoardGamesByRatingGreaterThanEqual(rating)
                .stream().map(boardGameMapper::toDto)
                .toList();
    }
}

