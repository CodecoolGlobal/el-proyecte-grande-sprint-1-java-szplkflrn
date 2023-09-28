package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.PublisherDto;
import com.codecool.bytebattlers.mapper.PublisherMapper;
import com.codecool.bytebattlers.model.Publisher;
import com.codecool.bytebattlers.repository.PublisherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

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

    public PublisherDto save(PublisherDto dto) {
        Publisher publisher = mapper.toEntity(dto);
        repository.save(publisher);
        return mapper.toDto(publisher);
    }

    public void update(PublisherDto updatedPublisher, UUID publicID) {
        Publisher foundPublisher = repository.findPublisherByPublicID(publicID);
        repository.save(mapper.partialUpdate(updatedPublisher, foundPublisher));
    }
    public PublisherDto findById(UUID publicID) {
        return mapper.toDto(repository.findPublisherByPublicID(publicID));
    }

    public Publisher findByPublicId(UUID publicId) {
       return repository.findPublisherByPublicID(publicId);
    }

    public void deleteById(UUID publicID) {
        repository.deleteByPublicID(publicID);
    }
}
