package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.PublisherDto;
import com.codecool.bytebattlers.mapper.PublisherMapper;
import com.codecool.bytebattlers.model.Publisher;
import com.codecool.bytebattlers.repository.PublisherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

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
        return repository.findAll().stream().map(mapper::toDto).toList();
    }

    public void save(PublisherDto entity) {
        repository.save(mapper.toEntity(entity));
    }

    public void update(PublisherDto updatedPublisher, Long id) {
        Publisher foundPublisher = repository.findById(id).orElseThrow(NoSuchElementException::new);
        repository.save(mapper.partialUpdate(updatedPublisher, foundPublisher));
    }
    public PublisherDto findById(Long aLong) {
        return repository.findById(aLong).map(mapper::toDto).orElseThrow(NoSuchElementException::new);
    }

    public void deleteById(Long aLong) {
        repository.deleteById(aLong);
    }
}
