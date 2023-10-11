package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.mapper.BoardGameMapper;
import com.codecool.bytebattlers.mapper.CategoryMapper;
import com.codecool.bytebattlers.model.BoardGame;
import com.codecool.bytebattlers.repository.BoardGameRepository;
import com.codecool.bytebattlers.repository.CategoryRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class BoardGameServiceTest {

    private BoardGameService boardGameService;
    @Mock
    private BoardGameRepository boardGameRepository;
    @Mock
    private PublisherService publisherService;
    @Mock
    private CategoryRepository categoryRepository;
    @Mock
    private CategoryService categoryService;
    @Mock
    private BoardGameMapper boardGameMapper;
    @Mock
    private CategoryMapper categoryMapper;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        this.boardGameService = new BoardGameService(
                this.boardGameRepository,
                this.publisherService,
                this.boardGameMapper,
                this.categoryService,
                this.categoryRepository,
                this.categoryMapper
        );
    }

    @Test
    void test_findBoardGamesDtoByGameName_ReturnEmptyList() {

        String testText = "test";
        int expected = 0;
        List<BoardGame> emptyBoardGames = new ArrayList<>();
        when(this.boardGameService.findBoardGamesByGameName(testText)).thenReturn(emptyBoardGames);

        int actual = this.boardGameService.findBoardGamesDtoByGameName(testText).size();

        assertEquals(expected, actual);
    }
}