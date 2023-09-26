package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.UserDto;
import com.codecool.bytebattlers.model.User;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface UserMapper {
    User toEntity(UserDto userDto);

    @AfterMapping
    default void linkReviews(@MappingTarget User user) {
        user.getReviews().forEach(review -> review.setUser(user));
    }

    UserDto toDto(User user);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    User partialUpdate(UserDto userDto, @MappingTarget User user);
}