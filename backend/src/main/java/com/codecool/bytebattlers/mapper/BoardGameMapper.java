package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.BoardGameDto;
import com.codecool.bytebattlers.model.BoardGame;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface BoardGameMapper {
    BoardGame toEntity(BoardGameDto board);

    BoardGameDto toDto(BoardGame boardGame);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    BoardGame partialUpdate(BoardGame board, @MappingTarget BoardGame boardGame);
}