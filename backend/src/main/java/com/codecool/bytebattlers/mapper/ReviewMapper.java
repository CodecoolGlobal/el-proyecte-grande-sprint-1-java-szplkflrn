package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.ReviewDto;
import com.codecool.bytebattlers.model.Review;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface ReviewMapper {

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Review partialUpdate(ReviewDto reviewDto, @MappingTarget Review review);

    @Mapping(source = "appUserPublicID", target = "appUser.publicID")
    @Mapping(source = "appUserName", target = "appUser.name")
    @Mapping(source = "boardGamePublicID", target = "boardGame.publicID")
    Review toEntity(ReviewDto reviewDto);

    @InheritInverseConfiguration(name = "toEntity")
    ReviewDto toDto(Review review);

    @InheritConfiguration(name = "toEntity")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Review partialUpdate(@MappingTarget Review review, ReviewDto reviewDto);
}
