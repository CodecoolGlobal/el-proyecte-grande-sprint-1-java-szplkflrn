package com.codecool.bytebattlers.service;

import com.codecool.bytebattlers.controller.dto.PublisherDto;
import com.codecool.bytebattlers.mapper.PublisherMapper;
import com.codecool.bytebattlers.model.Publisher;
import com.codecool.bytebattlers.repository.PublisherRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class PublisherServiceTest {

    private PublisherService publisherService;
    @Mock
    private PublisherMapper mapper;
    @Mock
    private PublisherRepository repository;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        when(repository.findAll()).thenReturn(Collections.emptyList());
        when(mapper.toDto(any(Publisher.class))).thenReturn(new PublisherDto(UUID.randomUUID(), "test", new HashSet<>()));
        this.publisherService = new PublisherService(mapper, repository);
    }

    @Test
    void test_findAll_returnEmptyList() {

        List<Publisher> publishers = new ArrayList<>();
        when(repository.findAll()).thenReturn(publishers);

        List<PublisherDto> result = publisherService.findAll();

        assertTrue(result.isEmpty());
    }

    @Test
    void test_findAll_returnArrayWithTwoPublishers() {

        int expected = 2;
        Publisher publisher1 = new Publisher();
        Publisher publisher2 = new Publisher();
        List<Publisher> publishers = Arrays.asList(publisher1, publisher2);
        when(repository.findAll()).thenReturn(publishers);

        PublisherDto dto1 = new PublisherDto(UUID.randomUUID(), "test1", new HashSet<>());
        PublisherDto dto2 = new PublisherDto(UUID.randomUUID(), "test2", new HashSet<>());
        when(mapper.toDto(publisher1)).thenReturn(dto1);
        when(mapper.toDto(publisher2)).thenReturn(dto2);

        List<PublisherDto> result = publisherService.findAll();

        assertEquals(expected, result.size());
        assertTrue(result.contains(dto1));
        assertTrue(result.contains(dto2));
    }

    @Test
    void test_save_callsMapperAndRepository() {

        Publisher publisher1 = new Publisher();
        PublisherDto dto1 = new PublisherDto(UUID.randomUUID(), "test1", new HashSet<>());

        when(mapper.toEntity(dto1)).thenReturn(publisher1);

        publisherService.save(dto1);

        verify(mapper, times(1)).toEntity(dto1);
        verify(repository, times(1)).save(publisher1);
    }


    @Test
    void test_findById_returnsPublisherDto() {
        Publisher publisher = new Publisher();
        UUID uuid = UUID.randomUUID();
        PublisherDto expectedDto = new PublisherDto(uuid, "test1", new HashSet<>());

        when(repository.findPublisherByPublicID(uuid)).thenReturn(publisher);

        when(mapper.toDto(publisher)).thenReturn(expectedDto);

        PublisherDto result = publisherService.findById(uuid);

        assertEquals(expectedDto, result);
    }

    @Test
    void test_findByPublicId_returnsPublisher() {
        UUID publicId = UUID.randomUUID();
        Publisher expectedPublisher = new Publisher();

        when(repository.findPublisherByPublicID(publicId)).thenReturn(expectedPublisher);

        Publisher result = publisherService.findByPublicId(publicId);

        assertEquals(expectedPublisher, result);
    }

    @Test
    void test_deleteById_callsRepositoryDeleteById() {
        UUID publicId = UUID.randomUUID();

        publisherService.deleteById(publicId);

        verify(repository, times(1)).deleteByPublicID(publicId);
    }

    @Test
    void test_deleteById_throwsExceptionOnError() {
        UUID publicId = UUID.randomUUID();

        doThrow(new RuntimeException("Error during deletion")).when(repository).deleteByPublicID(publicId);

        assertThrows(RuntimeException.class, () -> publisherService.deleteById(publicId));
    }
}