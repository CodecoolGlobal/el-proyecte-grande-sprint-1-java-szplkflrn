package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.CategoryDto;
import com.codecool.bytebattlers.mapper.CategoryMapper;
import com.codecool.bytebattlers.model.Category;
import com.codecool.bytebattlers.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.UUID;

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

    public CategoryDto save(CategoryDto entity) {
        Category createdCategory = categoryMapper.toEntity(entity);
        categoryRepository.save(createdCategory);
        return categoryMapper.toDto(createdCategory);
    }

    public CategoryDto findById(UUID publicID) {
        return categoryMapper
                .toDto(categoryRepository.findCategoryByPublicID(publicID));
    }

    public void deleteById(UUID publicId) {
        categoryRepository.deleteByPublicID(publicId);
    }
}
