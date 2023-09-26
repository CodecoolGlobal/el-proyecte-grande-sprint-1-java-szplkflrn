package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.CategoryDto;
import com.codecool.bytebattlers.mapper.CategoryMapper;
import com.codecool.bytebattlers.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.NoSuchElementException;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;
    private final CategoryMapper categoryMapper;

    @Autowired
    public CategoryService(CategoryRepository categoryRepository, CategoryMapper categoryMapper) {
        this.categoryRepository = categoryRepository;
        this.categoryMapper = categoryMapper;
    }

    public List<CategoryDto> findAll() {
        return categoryRepository.findAll().stream()
                .map(categoryMapper::toDto).toList();
    }

    public void save(CategoryDto entity) {
        categoryRepository.save(categoryMapper.toEntity(entity));
    }

    public CategoryDto findById(Long aLong) {
        return categoryRepository.findById(aLong)
                .map(categoryMapper::toDto)
                .orElseThrow(NoSuchElementException::new);
    }

    public void deleteById(Long aLong) {
        categoryRepository.deleteById(aLong);
    }
}
