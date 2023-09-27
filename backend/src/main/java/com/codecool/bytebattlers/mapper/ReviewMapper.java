package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.model.Review;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface ReviewMapper {

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Review partialUpdate(ReviewDto reviewDto, @MappingTarget Review review);

    @Mapping(source = "appUserName", target = "appUser.name")
    @Mapping(source = "appUserPublicID", target = "appUser.publicID")
    @Mapping(source = "boardGameRating", target = "boardGame.rating")
    @Mapping(source = "boardGameDescription", target = "boardGame.description")
    @Mapping(source = "boardGameRecommendedAge", target = "boardGame.recommendedAge")
    @Mapping(source = "boardGamePlayTimeInMinutes", target = "boardGame.playTimeInMinutes")
    @Mapping(source = "boardGameMaxPlayer", target = "boardGame.maxPlayer")
    @Mapping(source = "boardGameMinPlayer", target = "boardGame.minPlayer")
    @Mapping(source = "boardGameGameName", target = "boardGame.gameName")
    @Mapping(source = "boardGamePublicID", target = "boardGame.publicID")
    Review toEntity(ReviewDto reviewDto);

    @InheritInverseConfiguration(name = "toEntity")
    ReviewDto toDto(Review review);

    @InheritConfiguration(name = "toEntity")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Review partialUpdate(@MappingTarget Review review, ReviewDto reviewDto);
}