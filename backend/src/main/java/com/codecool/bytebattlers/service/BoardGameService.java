package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.mapper.BoardGameMapper;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.model.Publisher;
import com.codecool.bytebattlers.repository.BoardGameRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.UUID;

@Service
public class BoardGameService {

    private BoardGameRepository boardGameRepository;

    private final PublisherService publisherService;
    private BoardGameMapper boardGameMapper;

    private final Logger logger = LoggerFactory.getLogger(BoardGameService.class);

    @Autowired
    public BoardGameService(BoardGameRepository boardGameRepository, PublisherService publisherService, BoardGameMapper boardGameMapper) {
        this.boardGameRepository = boardGameRepository;
        this.publisherService = publisherService;
        this.boardGameMapper = boardGameMapper;
    }


    public List<BoardGameDto> findAll() {
        return boardGameRepository.findAll().stream().map(boardGameMapper::toDto).toList();
    }

    public void save(BoardGameDto dto) {

        try {
            Publisher foundPublisher = publisherService.findByPublicId(dto.publisherPublicID());
            BoardGame boardGame = boardGameMapper.toEntity(dto);
            boardGame.setPublisher(foundPublisher);
            boardGameRepository.save(boardGame);
        }
        catch (Exception e) {
            logger.error("An error occurred during application startup", e);
        }
    }

    public BoardGame findByPublicID (UUID publicID) {
        return boardGameRepository.findBoardGameByPublicID(publicID);
    }

    public BoardGameDto findById(Long aLong) {
        return boardGameMapper.toDto(boardGameRepository.findById(aLong).orElseThrow(NoSuchElementException::new));
    }

    public void deleteById(Long aLong) {
        boardGameRepository.deleteById(aLong);
    }
}

