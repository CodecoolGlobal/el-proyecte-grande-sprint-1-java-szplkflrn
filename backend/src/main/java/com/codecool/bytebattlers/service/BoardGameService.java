package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.mapper.BoardGameMapper;
import com.codecool.bytebattlers.mapper.CategoryMapper;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Category;
import com.codecool.bytebattlers.model.Publisher;
import com.codecool.bytebattlers.repository.BoardGameRepository;
import com.codecool.bytebattlers.repository.CategoryRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class BoardGameService {

    private BoardGameRepository boardGameRepository;
    private final PublisherService publisherService;
    private BoardGameMapper boardGameMapper;
    private final CategoryRepository categoryRepository;
    private final CategoryMapper categoryMapper;
    private final Logger logger = LoggerFactory.getLogger(BoardGameService.class);

    @Autowired
    public BoardGameService(BoardGameRepository boardGameRepository, PublisherService publisherService, BoardGameMapper boardGameMapper, CategoryService categoryService, CategoryRepository categoryRepository, CategoryMapper categoryMapper) {
        this.boardGameRepository = boardGameRepository;
        this.publisherService = publisherService;
        this.boardGameMapper = boardGameMapper;
        this.categoryRepository = categoryRepository;
        this.categoryMapper = categoryMapper;
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
}

