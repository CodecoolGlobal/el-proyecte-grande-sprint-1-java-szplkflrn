package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.model.Review;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface ReviewMapper {
    @Mapping(source = "userUserName", target = "user.userName")
    @Mapping(source = "userId", target = "user.id")
    @Mapping(source = "boardGameGameName", target = "boardGame.gameName")
    @Mapping(source = "boardGameId", target = "boardGame.id")
    Review toEntity(ReviewDto reviewDto);

    @InheritInverseConfiguration(name = "toEntity")
    ReviewDto toDto(Review review);

    @InheritConfiguration(name = "toEntity")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Review partialUpdate(ReviewDto reviewDto, @MappingTarget Review review);
}
