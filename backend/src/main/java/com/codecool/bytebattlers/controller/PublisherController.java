package com.codecool.bytebattlers.controller;

import com.codecool.bytebattlers.controller.dto.PublisherDto;
import com.codecool.bytebattlers.service.PublisherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/publisher")
public class PublisherController {

    private final PublisherService service;

    @Autowired
    public PublisherController(PublisherService service) {
        this.service = service;
    }

    @GetMapping("/")
    public List<PublisherDto> getAllPublishers() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public PublisherDto getPublisherById(@PathVariable Long id) {
        return service.findById(id);
    }

    @PostMapping("/")
    public void addNewPublisher(@RequestBody PublisherDto publisher) {
        service.save(publisher);
    }

    @DeleteMapping("/{id}")
    public void deletePublisherById(@PathVariable Long id) {
        service.deleteById(id);
    }
}
