package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.mapper.BoardGameMapper;
import com.codecool.bytebattlers.repository.BoardGameRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class BoardGameService {

    private BoardGameRepository boardGameRepository;
    private BoardGameMapper boardGameMapper;

    @Autowired
    public BoardGameService(BoardGameRepository boardGameRepository, BoardGameMapper boardGameMapper) {
        this.boardGameRepository = boardGameRepository;
        this.boardGameMapper = boardGameMapper;
    }


    public List<BoardGameDto> findAll() {
        return boardGameRepository.findAll().stream().map(boardGameMapper::toDto).collect(Collectors.toList());
    }

    public void save(BoardGameDto entity) {
        boardGameRepository.save(boardGameMapper.toEntity(entity));
    }

    public BoardGameDto findById(Long aLong) {
        return boardGameMapper.toDto(boardGameRepository.findById(aLong).orElseThrow(NoSuchElementException::new));
    }

    public void deleteById(Long aLong) {
        boardGameRepository.deleteById(aLong);
    }
}

