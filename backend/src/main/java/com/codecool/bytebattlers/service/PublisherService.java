package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.PublisherDto;
import com.codecool.bytebattlers.mapper.PublisherMapper;
import com.codecool.bytebattlers.repository.PublisherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class PublisherService {

    private final PublisherMapper mapper;
    private final PublisherRepository repository;

    @Autowired
    public PublisherService(PublisherMapper mapper, PublisherRepository repository) {
        this.mapper = mapper;
        this.repository = repository;
    }

    public List<PublisherDto> findAll() {
        return repository.findAll().stream().map(mapper::toDto).collect(Collectors.toList());
    }

    public void save(PublisherDto entity) {
        repository.save(mapper.toEntity(entity));
    }

    public PublisherDto findById(Long aLong) {
        return repository.findById(aLong).map(mapper::toDto).orElseThrow(NoSuchElementException::new);
    }

    public void deleteById(Long aLong) {
        repository.deleteById(aLong);
    }
}
