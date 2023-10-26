package com.codecool.bytebattlers.mapper;

import com.codecool.bytebattlers.controller.dto.AppUserDto;
import com.codecool.bytebattlers.model.AppUser;
import com.codecool.bytebattlers.model.BoardGame;
import org.mapstruct.*;

import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface AppUserMapper {
    AppUser toEntity(AppUserDto appUserDto);

    @AfterMapping
    default void linkReviews(@MappingTarget AppUser appUser) {
        appUser.getReviews().forEach(review -> review.setAppUser(appUser));
    }

    @Mapping(target = "favoriteBoardGamePublicIDS", expression = "java(favoriteBoardGameToFavoriteBoardGamePublicIDS(appUser.getFavoriteBoardGames()))")
    AppUserDto toDto(AppUser appUser);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    AppUser partialUpdate(AppUserDto appUserDto, @MappingTarget AppUser appUser);

    default Set<UUID> favoriteBoardGameToFavoriteBoardGamePublicIDS(Set<BoardGame> favoriteBoardGame) {
        return favoriteBoardGame.stream().map(BoardGame::getPublicID).collect(Collectors.toSet());
    }
}
