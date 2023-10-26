package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.PublisherDto;
import com.codecool.bytebattlers.controller.exception.ResourceNotFoundException;
import com.codecool.bytebattlers.service.PublisherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/publishers")
public class PublisherController {

    private final PublisherService service;

    @Autowired
    public PublisherController(PublisherService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<PublisherDto>> getAllPublishers() {
        if (service.findAll().isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(service.findAll(), HttpStatus.OK);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<PublisherDto> getPublisherById(@PathVariable UUID id) {
        if (service.findById(id) == null) {
            throw new ResourceNotFoundException("Not found Tutorial with id = " + id);
        } else {
            return new ResponseEntity<>(service.findById(id), HttpStatus.OK);
        }
    }

    @PatchMapping("/{id}")
    public void updatePublisherById(@RequestBody PublisherDto body, @PathVariable UUID id) {
        service.update(body, id);
    }

    @PostMapping
    public ResponseEntity<PublisherDto> addNewPublisher(@RequestBody PublisherDto board) {
        return new ResponseEntity<>(service.save(board), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<PublisherDto> deletePublisherById(@PathVariable UUID id) {
        service.deleteById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
