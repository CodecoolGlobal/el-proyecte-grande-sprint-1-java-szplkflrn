package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.VAllBoardGameDto;
import com.codecool.bytebattlers.model.VAllBoardGame;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface VAllBoardGameMapper {
    VAllBoardGame toEntity(VAllBoardGameDto VAllBoardGameDto);

    VAllBoardGameDto toDto(VAllBoardGame VAllBoardGame);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    VAllBoardGame partialUpdate(VAllBoardGameDto VAllBoardGameDto, @MappingTarget VAllBoardGame VAllBoardGame);
}