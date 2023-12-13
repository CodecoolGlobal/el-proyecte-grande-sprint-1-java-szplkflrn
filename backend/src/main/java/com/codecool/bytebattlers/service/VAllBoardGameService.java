package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.VAllBoardGameDto;
import com.codecool.bytebattlers.mapper.VAllBoardGameMapper;
import com.codecool.bytebattlers.repository.VAllBoardGameRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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


}
