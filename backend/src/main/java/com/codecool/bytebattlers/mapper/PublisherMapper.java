package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.PublisherDto;
import com.codecool.bytebattlers.model.Publisher;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface PublisherMapper {
    Publisher toEntity(PublisherDto publisherDto);

    @AfterMapping
    default void linkBoardGames(@MappingTarget Publisher publisher) {
        publisher.getBoardGames().forEach(boardGame -> boardGame.setPublisher(publisher));
    }

    PublisherDto toDto(Publisher publisher);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Publisher partialUpdate(PublisherDto publisherDto, @MappingTarget Publisher publisher);
}