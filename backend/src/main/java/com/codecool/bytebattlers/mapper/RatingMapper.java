package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.RatingDto;
import com.codecool.bytebattlers.model.Rating;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface RatingMapper {
    @Mapping(source = "boardGameGameName", target = "boardGame.gameName")
    @Mapping(source = "boardGamePublicID", target = "boardGame.publicID")
    @Mapping(source = "appUserName", target = "appUser.name")
    @Mapping(source = "appUserPublicID", target = "appUser.publicID")
    Rating toEntity(RatingDto ratingDto);

    @InheritInverseConfiguration(name = "toEntity")
    RatingDto toDto(Rating rating);

    @InheritConfiguration(name = "toEntity")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Rating partialUpdate(RatingDto ratingDto, @MappingTarget Rating rating);
}