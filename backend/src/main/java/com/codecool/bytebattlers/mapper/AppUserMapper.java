package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.AppUserDto;
import com.codecool.bytebattlers.model.AppUser;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface AppUserMapper {
    AppUser toEntity(AppUserDto appUserDto);

    @AfterMapping
    default void linkReviews(@MappingTarget AppUser appUser) {
        appUser.getReviews().forEach(review -> review.setAppUser(appUser));
    }

    AppUserDto toDto(AppUser appUser);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    AppUser partialUpdate(AppUserDto appUserDto, @MappingTarget AppUser appUser);
}