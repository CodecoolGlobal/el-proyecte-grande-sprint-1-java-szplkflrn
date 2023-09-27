package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.model.BoardGame;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface BoardGameMapper {
    @Mapping(source = "publisherPublisherName", target = "publisher.publisherName")
    @Mapping(source = "publisherPublicID", target = "publisher.publicID")
    BoardGame toEntity(BoardGameDto boardGameDto);

    @AfterMapping
    default void linkReviews(@MappingTarget BoardGame boardGame) {
        boardGame.getReviews().forEach(review -> review.setBoardGame(boardGame));
    }

    @InheritInverseConfiguration(name = "toEntity")
    BoardGameDto toDto(BoardGame boardGame);

    @InheritConfiguration(name = "toEntity")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    BoardGame partialUpdate(BoardGameDto boardGameDto, @MappingTarget BoardGame boardGame);
}