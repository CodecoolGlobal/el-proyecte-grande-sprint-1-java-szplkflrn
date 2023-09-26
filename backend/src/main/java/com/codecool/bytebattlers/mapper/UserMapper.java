package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.UserDto;
import com.codecool.bytebattlers.model.User;
import org.mapstruct.*;
import org.springframework.stereotype.Service;

@Service
@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface UserMapper {

    User toEntity(UserDto userEntityDto);

    UserDto toDto1(User user);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    User partialUpdate(UserDto userEntityDto, @MappingTarget User user);
}